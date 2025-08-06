#include "mqtt_ros_bridge/message_converter.h"
#include <ros/ros.h>
#include <sstream>
#include <openssl/sha.h>
#include <iomanip>
#include <ctime>

namespace mqtt_ros_bridge {

MessageConverter::MessageConverter() {
    // 从参数服务器获取签名密钥，默认为空
    if (!ros::param::get("~signature_secret", secret_key_)) {
        ROS_WARN("If the signature key is not set, message signing will not be performed.");
        secret_key_ = "";
    }
}

json MessageConverter::convertState(const mavros_msgs::State::ConstPtr& msg) {
    json j;
    j["connected"] = msg->connected;
    j["armed"] = msg->armed;
    j["guided"] = msg->guided;
    j["mode"] = msg->mode;
    j["system_status"] = msg->system_status;
    return j;
}

json MessageConverter::convertBattery(const sensor_msgs::BatteryState::ConstPtr& msg) {
    json j;
    j["voltage"] = msg->voltage;
    j["current"] = msg->current;
    j["charge"] = msg->charge;
    j["capacity"] = msg->capacity;
    j["percentage"] = msg->percentage;
    j["power_supply_status"] = msg->power_supply_status;
    j["power_supply_health"] = msg->power_supply_health;
    return j;
}

json MessageConverter::convertGpsGlobal(const sensor_msgs::NavSatFix::ConstPtr& msg) {
    json j;
    j["latitude"] = msg->latitude;
    j["longitude"] = msg->longitude;
    j["altitude"] = msg->altitude;
    j["status"] = msg->status.status;
    j["service"] = msg->status.service;
    return j;
}

json MessageConverter::convertLocalPose(const geometry_msgs::PoseStamped::ConstPtr& msg) {
    json j;
    j["position"]["x"] = msg->pose.position.x;
    j["position"]["y"] = msg->pose.position.y;
    j["position"]["z"] = msg->pose.position.z;
    j["orientation"]["x"] = msg->pose.orientation.x;
    j["orientation"]["y"] = msg->pose.orientation.y;
    j["orientation"]["z"] = msg->pose.orientation.z;
    j["orientation"]["w"] = msg->pose.orientation.w;
    j["frame_id"] = msg->header.frame_id;
    return j;
}

json MessageConverter::convertNedOdom(const nav_msgs::Odometry::ConstPtr& msg) {
    json j;
    j["position"]["x"] = msg->pose.pose.position.x;  // 北
    j["position"]["y"] = msg->pose.pose.position.y;  // 东
    j["position"]["z"] = msg->pose.pose.position.z;  // 地
    j["orientation"]["x"] = msg->pose.pose.orientation.x;
    j["orientation"]["y"] = msg->pose.pose.orientation.y;
    j["orientation"]["z"] = msg->pose.pose.orientation.z;
    j["orientation"]["w"] = msg->pose.pose.orientation.w;
    j["frame_id"] = msg->header.frame_id;
    return j;
}

json MessageConverter::convertVelocity(const geometry_msgs::TwistStamped::ConstPtr& msg) {
    json j;
    j["linear"]["x"] = msg->twist.linear.x;
    j["linear"]["y"] = msg->twist.linear.y;
    j["linear"]["z"] = msg->twist.linear.z;
    j["angular"]["x"] = msg->twist.angular.x;
    j["angular"]["y"] = msg->twist.angular.y;
    j["angular"]["z"] = msg->twist.angular.z;
    j["frame_id"] = msg->header.frame_id;
    return j;
}

json MessageConverter::convertGpsStatus(const mavros_msgs::GPSRAW::ConstPtr& msg) {
    json j;
    j["satellites_visible"] = msg->satellites_visible;
    j["eph"] = msg->eph;  // 水平精度因子
    j["epv"] = msg->epv;  // 垂直精度因子
    j["fix_type"] = msg->fix_type;  // GPS fix类型
    return j;
}

json MessageConverter::convertAttitude(const mavros_msgs::AttitudeTarget::ConstPtr& msg) {
    json j;
    j["orientation"]["x"] = msg->orientation.x;
    j["orientation"]["y"] = msg->orientation.y;
    j["orientation"]["z"] = msg->orientation.z;
    j["orientation"]["w"] = msg->orientation.w;
    j["thrust"] = msg->thrust;
    return j;
}

json MessageConverter::wrapMessage(const json& data, const std::string& type) {
    json j;
    j["type"] = type;
    j["timestamp"] = ros::Time::now().toSec();
    j["data"] = data;
    
    // 如果设置了密钥，则添加签名
    if (!secret_key_.empty()) {
        j["signature"] = generateSignature(j);
    }
    
    return j;
}

std::string MessageConverter::generateSignature(const json& data) {
    // 将JSON数据转换为字符串
    std::string data_str = data.dump();
    
    // 与密钥拼接
    std::string sign_str = data_str + secret_key_;
    
    // 计算SHA256哈希
    unsigned char hash[SHA256_DIGEST_LENGTH];
    SHA256((const unsigned char*)sign_str.c_str(), sign_str.size(), hash);
    
    // 转换为十六进制字符串
    std::stringstream ss;
    for(int i = 0; i < SHA256_DIGEST_LENGTH; i++) {
        ss << std::hex << std::setw(2) << std::setfill('0') << (int)hash[i];
    }
    
    return ss.str();
}

} // namespace mqtt_ros_bridge
    