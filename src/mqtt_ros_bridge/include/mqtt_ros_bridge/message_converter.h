#ifndef MESSAGE_CONVERTER_H
#define MESSAGE_CONVERTER_H

#include <ros/ros.h>
#include <mavros_msgs/State.h>
#include <sensor_msgs/BatteryState.h>
#include <sensor_msgs/NavSatFix.h>
#include <geometry_msgs/PoseStamped.h>
#include <nav_msgs/Odometry.h>
#include <geometry_msgs/TwistStamped.h>
#include <mavros_msgs/GPSRAW.h>
#include <mavros_msgs/AttitudeTarget.h>
#include <nlohmann/json.hpp>
#include <string>

namespace mqtt_ros_bridge {
// 使用 nlohmann/json 库进行 JSON 处理
using json = nlohmann::json;

class MessageConverter {
public:
    MessageConverter();
    
    // 转换各种ROS消息到JSON
    json convertState(const mavros_msgs::State::ConstPtr& msg);
    json convertBattery(const sensor_msgs::BatteryState::ConstPtr& msg);
    json convertGpsGlobal(const sensor_msgs::NavSatFix::ConstPtr& msg);
    json convertLocalPose(const geometry_msgs::PoseStamped::ConstPtr& msg);
    json convertNedOdom(const nav_msgs::Odometry::ConstPtr& msg);
    json convertVelocity(const geometry_msgs::TwistStamped::ConstPtr& msg);
    json convertGpsStatus(const mavros_msgs::GPSRAW::ConstPtr& msg);
    json convertAttitude(const mavros_msgs::AttitudeTarget::ConstPtr& msg);
    
    // 包装JSON数据并添加元信息
    json wrapMessage(const json& data, const std::string& type);
    
    // 生成消息签名
    std::string generateSignature(const json& data);
    
private:
    std::string secret_key_;  // 用于签名的密钥
};

} // namespace mqtt_ros_bridge

#endif // MESSAGE_CONVERTER_H
    