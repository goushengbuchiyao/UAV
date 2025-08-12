#include <mqtt_ros_node.h>
#include <sstream>
#include <ros/console.h>
#include "uav_state_collector.h"
#include "uav_command_parser.h"
#include "uav_msgs/UAVControlCommand.h"

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
    if (mqtt_client_->connect()) {
        ROS_INFO("MQTT-ROS bridge initialized successfully");
        // 创建 MAVROS 数据采集器
        uav_collector_ = std::make_unique<UAVStateCollector>(nh_);
        // 订阅MQTT主题
        if (!mqtt_subscribe_topic_.empty()) {
            if (!mqtt_client_->subscribe(mqtt_subscribe_topic_)) {
                ROS_WARN("Failed to subscribe to MQTT topic: %s", mqtt_subscribe_topic_.c_str());
            } else {
                ROS_INFO("Successfully subscribed to MQTT topic: %s. Waiting for JSON data...", mqtt_subscribe_topic_.c_str());
                // 设置ROS发布器和订阅器 
                // ros发布器发布mqtt订阅到的消息
                mqtt_to_ros_pub_ = nh_.advertise<uav_msgs::UAVControlCommand>(ros_publish_topic_, 10);
                // ros订阅器订阅mqtt指令执行状态的ros消息，将执行结果反馈给mqtt
                ros_to_mqtt_sub_ = nh_.subscribe(ros_subscribe_topic_, 10, &MQTTROSNode::handleROSMessage, this);
            }
        }
       
    }else {
        ROS_ERROR("Failed to connect to MQTT server: %s", server_uri.c_str());
        return false;
    }
    
    return true;
}

void MQTTROSNode::run() {
    ros::Rate rate(2); // 2Hz 发布
    while (ros::ok()) {
        ros::spinOnce();
        // 发布 UAV 状态到 MQTT 状态数据一直发送，不依赖于命令
        if (mqtt_client_ && mqtt_client_->isConnected()) {
            std::string json_state = uav_collector_->getStateJson();
            mqtt_client_->publish(mqtt_publish_topic_, json_state);
        }
        rate.sleep();
    }
}

bool MQTTROSNode::loadParameters() {
    // 从参数服务器获取配置
    nh_.param<std::string>("uav_id", uav_id_, "uav1");
    std::string prefix = "/" + uav_id_;
    nh_.param<std::string>("mqtt/server_uri", mqtt_server_uri_, "mqtts://de80ed56.ala.cn-hangzhou.emqxsl.cn");
    nh_.param<std::string>("mqtt/client_id", mqtt_client_id_, "ros_mqtt_bridge");
    nh_.param<std::string>("mqtt/ca_path", mqtt_ca_path_, "/home/px/UAV_SDK/src/mqtt_bridge/config/emqxsl-ca.crt");
    nh_.param<std::string>("mqtt/username", mqtt_username_, "px_uav");
    nh_.param<std::string>("mqtt/password", mqtt_password_, "123456");
    nh_.param<int>("mqtt/port", mqtt_port_, 8883);
    nh_.param<int>("mqtt/reconnect_interval", mqtt_reconnect_interval_, 5000);
    
    // 主题映射配置
    nh_.param<std::string>("topics/mqtt_subscribe", mqtt_subscribe_topic_, prefix + "/mqtt/uavcontrol/command");
    nh_.param<std::string>("topics/mqtt_publish", mqtt_publish_topic_, prefix + "/mqtt/state");
    nh_.param<std::string>("topics/ros_publish", ros_publish_topic_, prefix + "/ros/uavcontrol/command");
    nh_.param<std::string>("topics/ros_subscribe", ros_subscribe_topic_, prefix + "/ros/uavcontrol/command/state");

    ROS_INFO("Loaded MQTT parameters:");
    ROS_INFO("  Server URI: %s:%d", mqtt_server_uri_.c_str(), mqtt_port_);
    ROS_INFO("  Client ID: %s", mqtt_client_id_.c_str());
    ROS_INFO("  CA Path: %s", mqtt_ca_path_.c_str());
    ROS_INFO("  Username: %s", mqtt_username_.c_str());
    
    return true;
}

// void MQTTROSNode::handleMQTTMessage(const std::string& topic, const std::string& payload) {
//     ROS_INFO("Received MQTT message on topic %s: %s", topic.c_str(), payload.c_str());

//     UAVCommandParser parser;
//     UAVCommandParser::CommandData cmd;
//     std::string err_msg;

//     if (parser.parse(payload, cmd, err_msg)) {
//         ROS_INFO("Parsed command: type=%s, ts=%llu, target=%d",
//                  cmd.command_type.c_str(),
//                  static_cast<unsigned long long>(cmd.timestamp),
//                  cmd.target_system);

//         // 这里可以直接根据 command_type 分发到 MAVROS 控制逻辑
//         std_msgs::String ros_msg;
//         ros_msg.data = cmd.params.dump();
//         mqtt_to_ros_pub_.publish(ros_msg);
//     } else {
//         ROS_WARN("Invalid command JSON: %s", err_msg.c_str());
//     }
// }
ros::Time uint64_to_ros_time(uint64_t timestamp_ms) {
    uint32_t sec = timestamp_ms / 1000;       // 秒数（32位）
    uint32_t nsec = (timestamp_ms % 1000) * 1000000;  // 纳秒数（32位）
    return ros::Time(sec, nsec);
}
void MQTTROSNode::handleMQTTMessage(const std::string& topic, const std::string& payload) {
    UAVCommandParser parser;
    UAVCommandParser::CommandData cmd;
    std::string err_msg;

    if (parser.parse(payload, cmd, err_msg)) {
        uav_msgs::UAVControlCommand ros_cmd;
        ros_cmd.command_type = cmd.command_type;
        ros_cmd.timestamp = ros::Time(cmd.timestamp);
        // ros_cmd.timestamp = cmd.timestamp;
        // ros_cmd.timestamp.nsec = 0;
        ros_cmd.target_system = cmd.target_system;

        if (cmd.command_type == "takeoff") {
            ros_cmd.takeoff.altitude = cmd.params["altitude"].get<double>();
            ros_cmd.takeoff.yaw = cmd.params["yaw"].get<double>();
        }
        else if (cmd.command_type == "land") {
            ros_cmd.land.yaw = cmd.params["yaw"].get<double>();
        }
        else if (cmd.command_type == "position_control_ned") {
            ros_cmd.pos_ned.x = cmd.params["x"].get<double>();
            ros_cmd.pos_ned.y = cmd.params["y"].get<double>();
            ros_cmd.pos_ned.z = cmd.params["z"].get<double>();
            ros_cmd.pos_ned.yaw = cmd.params["yaw"].get<double>();
        }
        else if (cmd.command_type == "position_control_global") {
            ros_cmd.pos_global.latitude = cmd.params["latitude"].get<double>();
            ros_cmd.pos_global.longitude = cmd.params["longitude"].get<double>();
            ros_cmd.pos_global.altitude = cmd.params["altitude"].get<double>();
            ros_cmd.pos_global.yaw = cmd.params["yaw"].get<double>();
        }
        else if (cmd.command_type == "velocity_control_ned") {
            ros_cmd.vel_ned.vx = cmd.params["vx"].get<double>();
            ros_cmd.vel_ned.vy = cmd.params["vy"].get<double>();
            ros_cmd.vel_ned.vz = cmd.params["vz"].get<double>();
            ros_cmd.vel_ned.yaw_rate = cmd.params["yaw_rate"].get<double>();
        }
        else if (cmd.command_type == "return_to_launch") {
            ros_cmd.rtl.altitude = cmd.params["altitude"].get<double>();
        }
        else if (cmd.command_type == "hover") {
            ros_cmd.hover.mode = cmd.params["mode"].get<std::string>();
        }
        else if (cmd.command_type == "set_mode") {
            ros_cmd.set_mode.mode = cmd.params["mode"].get<std::string>();
        }
        else {
            ROS_WARN("Unknown command type: %s", cmd.command_type.c_str());
            return;
        }
        // ROS_DEBUG("ros_cmd: %s", ros_cmd.c_str());
        // ROS_INFO("ros_cmd.command_type: %s", ros_cmd.command_type.c_str());
        ROS_INFO_STREAM("ros_cmd: " << ros_cmd);
        // ROS_INFO("ros_cmd.timestamp: %d", ros_cmd.timestamp);
        // ROS_INFO("ros_cmd.target_system: %d", ros_cmd.target_system);
        // ROS_INFO("ros_cmd.takeoff.altitude: %f", ros_cmd.takeoff.altitude);
        // ROS_INFO("ros_cmd.takeoff.yaw: %f", ros_cmd.takeoff.yaw);
        // ROS_INFO("ros_cmd.land.yaw: %f", ros_cmd.land.yaw);
        mqtt_to_ros_pub_.publish(ros_cmd);
    }
    else {
        ROS_WARN("Invalid command JSON: %s", err_msg.c_str());
    }
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
