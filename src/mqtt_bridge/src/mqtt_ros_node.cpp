#include <mqtt_ros_node.h>
#include <sstream>
#include <ros/console.h>

namespace mqtt_bridge {

MQTTROSNode::MQTTROSNode(ros::NodeHandle& nh) : nh_(nh) {}

bool MQTTROSNode::init() {
    // 加载参数
    if (!loadParameters()) {
        ROS_ERROR("Failed to load parameters");
        return false;
    }

    // 创建MQTT客户端
    std::string server_uri = mqtt_server_uri_ + ":" + std::to_string(mqtt_port_);
    mqtt_client_ = std::make_unique<MQTTClient>(
        server_uri,
        mqtt_client_id_,
        mqtt_ca_path_,
        mqtt_username_,
        mqtt_password_,
        mqtt_reconnect_interval_
    );

    // 设置MQTT回调
    mqtt_client_->setMessageCallback(
        std::bind(&MQTTROSNode::handleMQTTMessage, this, std::placeholders::_1, std::placeholders::_2)
    );
    
    mqtt_client_->setConnectionCallback(
        std::bind(&MQTTROSNode::handleConnectionStatus, this, std::placeholders::_1)
    );
    // 连接到MQTT服务器
    if (!mqtt_client_->connect()) {
        ROS_ERROR("Failed to connect to MQTT server");
        return false;
    }

    // 订阅MQTT主题
    if (!mqtt_subscribe_topic_.empty()) {
        if (!mqtt_client_->subscribe(mqtt_subscribe_topic_)) {
            ROS_WARN("Failed to subscribe to MQTT topic: %s", mqtt_subscribe_topic_.c_str());
        } else {
            ROS_INFO("Successfully subscribed to MQTT topic: %s. Waiting for JSON data...", mqtt_subscribe_topic_.c_str());
        }
    }

    // 设置ROS发布器和订阅器
    mqtt_to_ros_pub_ = nh_.advertise<std_msgs::String>(ros_publish_topic_, 10);
    ros_to_mqtt_sub_ = nh_.subscribe(ros_subscribe_topic_, 10, &MQTTROSNode::handleROSMessage, this);

    ROS_INFO("MQTT-ROS bridge initialized successfully");
    return true;
}

void MQTTROSNode::run() {
    ros::Rate rate(10); // 10Hz
    while (ros::ok()) {
        ros::spinOnce();
        rate.sleep();
    }
    
    // 断开MQTT连接
    if (mqtt_client_) {
        mqtt_client_->disconnect();
    }
}

bool MQTTROSNode::loadParameters() {
    // 从参数服务器获取配置
    nh_.param<std::string>("mqtt/server_uri", mqtt_server_uri_, "mqtts://de80ed56.ala.cn-hangzhou.emqxsl.cn");
    nh_.param<std::string>("mqtt/client_id", mqtt_client_id_, "ros_mqtt_bridge");
    nh_.param<std::string>("mqtt/ca_path", mqtt_ca_path_, "/home/px/UAV_SDK/src/mqtt_bridge/config/emqxsl-ca.crt");
    nh_.param<std::string>("mqtt/username", mqtt_username_, "px_uav");
    nh_.param<std::string>("mqtt/password", mqtt_password_, "123456");
    nh_.param<int>("mqtt/port", mqtt_port_, 8883);
    nh_.param<int>("mqtt/reconnect_interval", mqtt_reconnect_interval_, 5000);
    
    // 主题映射配置
    nh_.param<std::string>("topics/mqtt_subscribe", mqtt_subscribe_topic_, "uav1/mqtt/uavcontrol/command");
    nh_.param<std::string>("topics/mqtt_publish", mqtt_publish_topic_, "uav1/mqtt/state");
    nh_.param<std::string>("topics/ros_publish", ros_publish_topic_, "uav1/ros/state");
    nh_.param<std::string>("topics/ros_subscribe", ros_subscribe_topic_, "uav1/ros/uavcontrol/command");

    ROS_INFO("Loaded MQTT parameters:");
    ROS_INFO("  Server URI: %s:%d", mqtt_server_uri_.c_str(), mqtt_port_);
    ROS_INFO("  Client ID: %s", mqtt_client_id_.c_str());
    ROS_INFO("  CA Path: %s", mqtt_ca_path_.c_str());
    ROS_INFO("  Username: %s", mqtt_username_.c_str());
    
    return true;
}

void MQTTROSNode::handleMQTTMessage(const std::string& topic, const std::string& payload) {
    ROS_INFO("Received MQTT message on topic %s: %s", topic.c_str(), payload.c_str());
    
    // 解析JSON数据（假设payload是JSON格式）+++
    
    // 将MQTT消息发布到ROS
    std_msgs::String msg;
    msg.data = payload;
    mqtt_to_ros_pub_.publish(msg);
}

void MQTTROSNode::handleROSMessage(const std_msgs::String::ConstPtr& msg) {
    if (!mqtt_client_ || !mqtt_client_->isConnected()) {
        ROS_WARN("Cannot publish to MQTT, not connected");
        return;
    }
    
    // 将ros消息转换为MQTT消息+++

    ROS_DEBUG("Publishing ROS message to MQTT topic %s: %s", 
              mqtt_publish_topic_.c_str(), msg->data.c_str());
    
    // 将ROS消息发布到MQTT
    mqtt_client_->publish(mqtt_publish_topic_, msg->data);
}

void MQTTROSNode::handleConnectionStatus(bool connected) {
    if (connected) {
        ROS_INFO("Connected to MQTT server");
        // 如果有需要订阅的主题，重新订阅
        if (!mqtt_subscribe_topic_.empty()) {
            mqtt_client_->subscribe(mqtt_subscribe_topic_);
        }
    } else {
        ROS_WARN("Disconnected from MQTT server");
    }
}

} // namespace mqtt_bridge
