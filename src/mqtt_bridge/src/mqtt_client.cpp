#include "mqtt_client.h"
#include <ros/ros.h>

namespace mqtt_bridge {

MqttClient::MqttClient(const std::string& server_address, 
                       const std::string& client_id,
                       const std::string& username,
                       const std::string& password,
                       const std::string& ca_cert_path,
                       int qos)
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

bool MqttClient::publish(const std::string& topic, const std::string& payload, int qos, bool retain) {
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
    ROS_ERROR_STREAM("MQTT publish exception: " << exc.what());
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

void MqttClient::setMessageCallback(const MessageCallback& callback) {
  message_callback_ = callback;
}

bool MqttClient::isConnected() const {
  return connected_;
}

// 回调类实现
void MqttClient::Callback::connection_lost(const std::string& cause) {
  ROS_WARN_STREAM("MQTT connection lost: " << cause);
  parent_.connected_ = false;
  
  // 可以在这里实现重连逻辑
}

void MqttClient::Callback::message_arrived(mqtt::const_message_ptr msg) {
  ROS_DEBUG_STREAM("MQTT message arrived: " << msg->get_topic() << " - " << msg->to_string());
  
  if (parent_.message_callback_) {
    parent_.message_callback_(msg->get_topic(), msg->to_string());
  }
}

void MqttClient::Callback::delivery_complete(mqtt::delivery_token_ptr token) {
  ROS_DEBUG("MQTT delivery complete");
}

} // namespace mqtt_bridge
  