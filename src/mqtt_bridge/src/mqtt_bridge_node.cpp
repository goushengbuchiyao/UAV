#include "ros/ros.h"
#include "mqtt_client.h"
#include "px_uav_msgs/UAVState.h"
#include "px_uav_msgs/UAVControlState.h"
#include <jsoncpp/json/json.h>

// 全局变量，用于存储MQTT客户端
std::shared_ptr<mqtt_bridge::MqttClient> mqtt_client;
ros::Publisher control_pub;

// MQTT消息回调函数
void mqttMessageCallback(const std::string& topic, const std::string& payload) {
  ROS_INFO_STREAM("Received MQTT message on topic: " << topic);
  
  // 检查是否是控制指令主题
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

int main(int argc, char **argv) {
  // 初始化ROS节点
  ros::init(argc, argv, "mqtt_bridge_node");
  ros::NodeHandle nh("~");
  
  // 读取MQTT配置参数
  std::string server_address = "mqtts://de80ed56.ala.cn-hangzhou.emqxsl.cn:8883";
  std::string client_id = "ros_uav_client";
  std::string username = "px_uav";
  std::string password = "Wcnm1111!";
  std::string ca_cert_path = "config/emqxsl-ca.crt"; // CA证书路径
  
  // 从参数服务器读取配置（如果有）
  nh.param<std::string>("server_address", server_address, server_address);
  nh.param<std::string>("client_id", client_id, client_id);
  nh.param<std::string>("username", username, username);
  nh.param<std::string>("password", password, password);
  nh.param<std::string>("ca_cert_path", ca_cert_path, ca_cert_path);
  
  // 检查CA证书路径
  if (ca_cert_path.empty()) {
    ROS_ERROR("CA certificate path is required for TLS connection");
    return -1;
  }
  
  // 创建MQTT客户端
  mqtt_client = std::make_shared<mqtt_bridge::MqttClient>(
    server_address, client_id, username, password, ca_cert_path);
  
  // 设置消息回调
  mqtt_client->setMessageCallback(mqttMessageCallback);
  
  // 连接到MQTT服务器
  if (!mqtt_client->connect()) {
    ROS_ERROR("Failed to connect to MQTT server, exiting");
    return -1;
  }
  
  // 订阅控制主题
  mqtt_client->subscribe("uav/control");
  
  // 创建ROS发布者和订阅者
  control_pub = nh.advertise<px_uav_msgs::UAVControlState>("/uav/control", 10);
  ros::Subscriber status_sub = nh.subscribe("/uav/status", 10, statusCallback);
  
  // 设置循环频率
  ros::Rate rate(10); // 10Hz
  
  // 主循环
  while (ros::ok()) {
    // 处理ROS回调
    ros::spinOnce();
    
    // 检查MQTT连接状态
    if (!mqtt_client->isConnected()) {
      ROS_WARN("MQTT connection lost, attempting to reconnect");
      if (!mqtt_client->connect()) {
        ROS_ERROR("Failed to reconnect to MQTT server");
      } else {
        // 重新订阅主题
        mqtt_client->subscribe("uav/control");
      }
    }
    
    rate.sleep();
  }
  
  // 断开MQTT连接
  mqtt_client->disconnect();
  
  return 0;
}
  