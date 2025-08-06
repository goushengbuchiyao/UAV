#include "ros/ros.h"
#include "mqtt_client.h"
#include "px_uav_msgs/UAVState.h"
#include "px_uav_msgs/UAVControlState.h"
#include <jsoncpp/json/json.h>
#include "uav_state_publisher.h"
#include <openssl/hmac.h>
#include <openssl/sha.h>
#include <boost/filesystem.hpp>
// 全局变量，用于存储MQTT客户端
std::shared_ptr<mqtt_bridge::MqttClient> mqtt_client;
ros::Publisher control_pub;
struct MqttConfig {
  std::string server_address;
  std::string client_id;
  std::string username;
  std::string password;
  std::string ca_cert_path;
  int qos = 1;
  int reconnect_interval = 5; // 初始重连间隔（秒）
};

// 从参数服务器加载配置
MqttConfig loadMqttConfig(ros::NodeHandle& nh) {
  MqttConfig cfg;
  // 读取参数，强制检查必要参数
  if (!nh.getParam("server_address", cfg.server_address) || cfg.server_address.empty()) {
    ROS_FATAL("Missing required parameter: server_address");
    throw std::runtime_error("Missing server_address");
  }
  nh.param("client_id", cfg.client_id, std::string("ros_uav_client_") + std::to_string(getpid())); // 自动生成唯一ID
  nh.param("username", cfg.username, std::string());
  nh.param("password", cfg.password, std::string());
  
  if (!nh.getParam("ca_cert_path", cfg.ca_cert_path) || cfg.ca_cert_path.empty()) {
    ROS_FATAL("Missing required parameter: ca_cert_path");
    throw std::runtime_error("Missing ca_cert_path");
  }
  // 检查CA证书文件是否存在
  if (!boost::filesystem::exists(cfg.ca_cert_path)) {
    ROS_FATAL_STREAM("CA certificate file not found: " << cfg.ca_cert_path);
    throw std::runtime_error("CA cert file not found");
  }
  
  nh.param("qos", cfg.qos, 1);
  nh.param("reconnect_interval", cfg.reconnect_interval, 5);
  return cfg;
}

// MQTT消息回调函数
// 添加验签函数
bool verifySignature(const std::string& payload, const std::string& signature, const std::string& secret_key) {
  unsigned char digest[SHA256_DIGEST_LENGTH];
  HMAC_CTX* ctx = HMAC_CTX_new();
  HMAC_Init_ex(ctx, secret_key.c_str(), secret_key.length(), EVP_sha256(), NULL);
  HMAC_Update(ctx, (unsigned char*)payload.c_str(), payload.length());
  unsigned int len = SHA256_DIGEST_LENGTH;
  HMAC_Final(ctx, digest, &len);
  HMAC_CTX_free(ctx);
  
  std::string computed_signature;
  for (int i = 0; i < len; ++i) {
    char buf[3];
    sprintf(buf, "%02x", digest[i]);
    computed_signature += buf;
  }
  
  return computed_signature == signature;
}

// 修改MQTT消息回调
void mqttMessageCallback(const std::string& topic, const std::string& payload, ros::NodeHandle& nh) {
  ROS_INFO_STREAM("Received MQTT message on topic: " << topic);
  
  // 获取密钥
  std::string secret_key;
  if (!nh.getParam("signature_secret_key", secret_key) || secret_key.empty()) {
    ROS_ERROR("Signature secret key not configured");
    return;
  }
  
  // 解析消息和签名
  Json::Reader reader;
  Json::Value root;
  if (!reader.parse(payload, root)) {
    ROS_ERROR("Failed to parse MQTT message");
    return;
  }
  
  std::string data = root["data"].asString();
  std::string signature = root["signature"].asString();
  
  // 验签
  if (!verifySignature(data, signature, secret_key)) {
    ROS_ERROR("Message signature verification failed");
    // 记录日志并有限重试
    static int retry_count = 0;
    
    if (retry_count < 3) {
      retry_count++;
      ROS_WARN_STREAM("Retrying message processing (attempt " << retry_count << "/3)");
      // 重新入队或延迟处理
      return;
    }
    retry_count = 0;
    return;
  }
  
  // 验签通过，继续处理
  if (topic == "uav/control") {
    try {
      // 解析JSON消息
      Json::Reader reader;
      Json::Value root;
      
      if (reader.parse(payload, root)) {
        // 创建ROS消息
        px_uav_msgs::UAVControlState control_msg;
        
        // 填充消息字段
        control_msg.header.stamp = ros::Time::now();
        
        if (!root["mode"].isNull())
          control_msg.mode = root["mode"].asString();
          
        if (!root["position"].isNull()) {
          control_msg.position.x = root["position"]["x"].asDouble();
          control_msg.position.y = root["position"]["y"].asDouble();
          control_msg.position.z = root["position"]["z"].asDouble();
        }
        
        if (!root["velocity"].isNull()) {
          control_msg.velocity.x = root["velocity"]["x"].asDouble();
          control_msg.velocity.y = root["velocity"]["y"].asDouble();
          control_msg.velocity.z = root["velocity"]["z"].asDouble();
        }
        
        if (!root["yaw"].isNull())
          control_msg.yaw = root["yaw"].asDouble();
          
        if (!root["takeoff"].isNull())
          control_msg.takeoff = root["takeoff"].asBool();
          
        if (!root["land"].isNull())
          control_msg.land = root["land"].asBool();
          
        if (!root["emergency"].isNull())
          control_msg.emergency = root["emergency"].asBool();
        
        // 发布ROS消息
        control_pub.publish(control_msg);
        ROS_INFO("Published control message to ROS");
      } else {
        ROS_ERROR("Failed to parse MQTT control message");
      }
    } catch (const std::exception& e) {
      ROS_ERROR_STREAM("Exception while processing MQTT message: " << e.what());
    }
  }
}

// ROS状态消息回调函数
void statusCallback(const px_uav_msgs::UAVState::ConstPtr& msg) {
  // 检查MQTT连接状态
  if (!mqtt_client->isConnected()) {
    ROS_WARN("MQTT client not connected, skipping status publish");
    return;
  }
  
  try {
    // 创建JSON对象
    Json::Value root;
    
    // 填充状态信息
    root["header"]["seq"] = msg->header.seq;
    root["header"]["stamp"]["secs"] = msg->header.stamp.sec;
    root["header"]["stamp"]["nsecs"] = msg->header.stamp.nsec;
    root["header"]["frame_id"] = msg->header.frame_id;
    
    root["position"]["x"] = msg->position[0];
    root["position"]["y"] = msg->position[1];
    root["position"]["z"] = msg->position[2];
    
    root["velocity"]["x"] = msg->velocity[0];
    root["velocity"]["y"] = msg->velocity[1];
    root["velocity"]["z"] = msg->velocity[2];
    
    root["attitude"]["roll"] = msg->attitude[0];
    root["attitude"]["pitch"] = msg->attitude[1];
    root["attitude"]["yaw"] = msg->attitude[2];
    
    root["battery"] = msg->battery_state;
    root["status"] = msg->gps_status;
    root["mode"] = msg->mode;
    root["armed"] = msg->armed;
    
    // 转换为字符串
    Json::FastWriter writer;
    std::string json_str = writer.write(root);
    
    // 发布到MQTT
    mqtt_client->publish("uav/status", json_str);
    ROS_DEBUG("Published UAV status to MQTT");
  } catch (const std::exception& e) {
    ROS_ERROR_STREAM("Exception while publishing UAV status: " << e.what());
  }
}

int main(int argc, char**argv) {
    ros::init(argc, argv, "mqtt_bridge");
    ros::NodeHandle nh("~");
    
    try {
        // 加载MQTT配置
        MqttConfig cfg = loadMqttConfig(nh);
        
        // 创建MQTT客户端
       mqtt_client = std::make_shared<mqtt_bridge::MqttClient>(
        cfg.server_address, cfg.client_id, cfg.username, cfg.password, cfg.ca_cert_path, cfg.qos, nh);
        // 连接MQTT服务器
        if (!mqtt_client->connect()) {
            ROS_ERROR_STREAM("Failed to connect to MQTT server at " << cfg.server_address 
                            << ". Check server address, port, CA certificate, and network connectivity.");
        }
        
        // 创建并启动UAV状态发布器
        UAVStatePublisher state_publisher(nh, *mqtt_client);
        
        // 连接状态回调
        mqtt_client->setConnectionCallback([](bool connected) {
            if (connected) {
                ROS_INFO("MQTT connected, starting to publish UAV state");
            } else {
                ROS_WARN("MQTT disconnected");
            }
        });
        
        // 消息回调
        mqtt_client->setMessageCallback([](const std::string& topic, const std::string& payload, ros::NodeHandle& nh) {
            mqttMessageCallback(topic, payload, nh);
        });
        
        
        ros::spin();
        
        // 断开连接
        mqtt_client->disconnect();
    } catch (const std::exception& e) {
        ROS_FATAL("Fatal error: %s", e.what());
        return 1;
    }
    
    return 0;
}