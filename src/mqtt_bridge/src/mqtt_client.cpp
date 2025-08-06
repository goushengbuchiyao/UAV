#include "mqtt_client.h"
#include <ros/ros.h>

namespace mqtt_bridge {

MqttClient::MqttClient(const std::string& server_address, 
                       const std::string& client_id,
                       const std::string& username,
                       const std::string& password,
                       const std::string& ca_cert_path,
                       int qos,
                       ros::NodeHandle nh)
  : client_id_(client_id), 
    connected_(false),
    callback_(*this) {
  
  // 创建MQTT客户端
  client_ = std::make_unique<mqtt::async_client>(server_address, client_id);
  
  // 设置回调
  client_->set_callback(callback_);
  
  // 配置SSL选项
  sslOpts_ = mqtt::ssl_options_builder()
    .trust_store(ca_cert_path)
    .error_handler([](const std::string& msg) {
      ROS_WARN_STREAM("MQTT SSL error: " << msg);
    })
    .finalize();
  
  // 配置连接选项
  connOpts_ = mqtt::connect_options_builder()
    .keep_alive_interval(std::chrono::seconds(20))
    .clean_session(true)
    .user_name(username)
    .password(password)
    .ssl(sslOpts_)
    .finalize();
}

MqttClient::~MqttClient() {
  disconnect();
}

bool MqttClient::connect() {
  try {
    // 尝试连接
    mqtt::token_ptr conntok = client_->connect(connOpts_);
    
    // 等待连接完成
    conntok->wait();
    
    // 检查连接状态
    connected_ = client_->is_connected();
    
    if (connected_) {
      ROS_INFO("Connected to MQTT server");
    } else {
      ROS_ERROR("Failed to connect to MQTT server");
    }
    
    return connected_;
  } catch (const mqtt::exception& exc) {
    ROS_ERROR_STREAM("MQTT connection exception: " << exc.what());
    return false;
  }
}

void MqttClient::disconnect() {
  if (connected_) {
    try {
      // 断开连接
      mqtt::token_ptr disconntok = client_->disconnect();
      disconntok->wait();
      connected_ = false;
      ROS_INFO("Disconnected from MQTT server");
    } catch (const mqtt::exception& exc) {
      ROS_ERROR_STREAM("MQTT disconnection exception: " << exc.what());
    }
  }
}

void MqttClient::attemptReconnect() {
  if (reconnecting_ || connected_) return;
  reconnecting_ = true;
  
  std::thread([this]() {
    int interval = reconnect_interval_;
    while (!connected_ && ros::ok()) {
      ROS_INFO_STREAM("Attempting to reconnect (interval: " << interval << "s)");
      if (connect()) {
        reconnecting_ = false;
        interval = reconnect_interval_; // 重置间隔
        if (conn_callback_) conn_callback_(true);
        return;
      }
      // 指数退避（最大间隔60秒）
      std::this_thread::sleep_for(std::chrono::seconds(interval));
      interval = std::min(interval * 2, 60);
    }
    reconnecting_ = false;
  }).detach();
}

// 在connection_lost中触发重连
void MqttClient::Callback::connection_lost(const std::string& cause) {
  ROS_WARN_STREAM("MQTT connection lost: " << cause);
  parent_.connected_ = false;
  if (parent_.conn_callback_) parent_.conn_callback_(false);
  parent_.attemptReconnect(); // 自动重连
}

bool MqttClient::publish(const std::string& topic, const std::string& payload, int qos, bool retain) {
  ROS_INFO_STREAM("Publishing MQTT message: topic=" << topic << ", size=" << payload.size());
  if (!connected_) {
    ROS_WARN("Cannot publish: Not connected to MQTT server");
    return false;
  }
  
  try {
    // 创建消息
    std::shared_ptr<mqtt::message> msg = mqtt::message::create(topic, payload, qos, retain);
    
    // 发布消息
    mqtt::delivery_token_ptr pubtok = client_->publish(msg);
    
    // 可以选择等待发布完成
    // pubtok->wait();
    
    return true;
  } catch (const mqtt::exception& exc) {
    ROS_ERROR_STREAM("MQTT publish exception: " << exc.what() << ", topic=" << topic);
    // 添加重试逻辑
    if (retry_count_ < max_retries_) {
      retry_count_++;
      ROS_WARN_STREAM("Retrying publish (attempt " << retry_count_ << "/" << max_retries_ << ")");
      std::this_thread::sleep_for(std::chrono::milliseconds(retry_interval_));
      return publish(topic, payload, qos, retain);
    }
    retry_count_ = 0;
    return false;
  }
}

bool MqttClient::subscribe(const std::string& topic, int qos) {
  if (!connected_) {
    ROS_WARN("Cannot subscribe: Not connected to MQTT server");
    return false;
  }
  
  try {
    // 订阅主题
    mqtt::token_ptr subtok = client_->subscribe(topic, qos);
    
    // 等待订阅完成
    subtok->wait();
    
    ROS_INFO_STREAM("Subscribed to topic: " << topic);
    return true;
  } catch (const mqtt::exception& exc) {
    ROS_ERROR_STREAM("MQTT subscribe exception: " << exc.what());
    return false;
  }
}

void mqtt_bridge::MqttClient::setMessageCallback(const MessageCallback& callback) {
    message_callback_ = callback;
}

bool MqttClient::isConnected() const {
  return connected_;
}


void mqtt_bridge::MqttClient::Callback::message_arrived(mqtt::const_message_ptr msg) {
  ROS_DEBUG_STREAM("MQTT message arrived: " << msg->get_topic() << " - " << msg->to_string());
  
  if (parent_.message_callback_) {
    parent_.message_callback_(msg->get_topic(), msg->to_string(), parent_.nh_);
  }
}

void MqttClient::Callback::delivery_complete(mqtt::delivery_token_ptr token) {
  ROS_DEBUG("MQTT delivery complete");
}

void MqttClient::enqueueMessage(const std::string& topic, const std::string& payload, int qos, bool retain) {
  std::lock_guard<std::mutex> lock(queue_mutex_);
  message_queue_.emplace(topic, payload, qos, retain);
  queue_condition_.notify_one();
}

void MqttClient::startWorkerThread() {
  worker_running_ = true;
  worker_thread_ = std::thread([this]() {
    while (worker_running_) {
      std::tuple<std::string, std::string, int, bool> msg;
      {
        std::unique_lock<std::mutex> lock(queue_mutex_);
        queue_condition_.wait(lock, [this]() { return !message_queue_.empty() || !worker_running_; });
        if (!worker_running_) break;
        msg = std::move(message_queue_.front());
        message_queue_.pop();
      }
      // 实际发送消息
      publish(std::get<0>(msg), std::get<1>(msg), std::get<2>(msg), std::get<3>(msg));
    }
  });
}

void MqttClient::stopWorkerThread() {
  worker_running_ = false;
  queue_condition_.notify_one();
  if (worker_thread_.joinable()) {
    worker_thread_.join();
  }
}
} // namespace mqtt_bridge