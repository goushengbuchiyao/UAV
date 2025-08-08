#include "uav_state_collector.h"
#include <ros/ros.h>
using json = nlohmann::json;

UAVStateCollector::UAVStateCollector(ros::NodeHandle& nh) {
    sub_state_   = nh.subscribe("/uav1/mavros/state", 10, &UAVStateCollector::stateCb, this);
    sub_battery_ = nh.subscribe("/uav1/mavros/battery", 10, &UAVStateCollector::batteryCb, this);
    sub_gps_     = nh.subscribe("/uav1/mavros/global_position/global", 10, &UAVStateCollector::gpsCb, this);
    sub_pose_    = nh.subscribe("/uav1/mavros/local_position/pose", 10, &UAVStateCollector::poseCb, this);
    sub_vel_     = nh.subscribe("/uav1/mavros/local_position/velocity_local", 10, &UAVStateCollector::velCb, this);
    sub_gps_raw_ = nh.subscribe("/uav1/mavros/gps/gps0", 10, &UAVStateCollector::gpsRawCb, this);
    sub_imu_     = nh.subscribe("/uav1/mavros/imu/data", 10, &UAVStateCollector::imuCb, this);
}

std::string UAVStateCollector::getStateJson() {
    std::lock_guard<std::mutex> lock(mtx_);
    json j;
    j["mode"] = state_.mode;
    j["connected"] = state_.connected;
    j["armed"] = state_.armed;
    j["battery_voltage"] = battery_.voltage;
    j["battery_percentage"] = battery_.percentage;
    j["gps_lat"] = gps_.latitude;
    j["gps_lon"] = gps_.longitude;
    j["gps_alt"] = gps_.altitude;
    j["gps_fix_status"] = gps_.status.status;
    j["gps_satellites"] = gps_raw_.satellites_visible;
    j["local_x"] = pose_.position.x;
    j["local_y"] = pose_.position.y;
    j["local_z"] = pose_.position.z;
    j["vel_x"] = vel_.linear.x;
    j["vel_y"] = vel_.linear.y;
    j["vel_z"] = vel_.linear.z;

    double roll, pitch, yaw;
    tf::Quaternion q(imu_.orientation.x, imu_.orientation.y, imu_.orientation.z, imu_.orientation.w);
    tf::Matrix3x3(q).getRPY(roll, pitch, yaw);
    j["roll"] = roll;
    j["pitch"] = pitch;
    j["yaw"] = yaw;

    return j.dump();
}

// 回调函数
void UAVStateCollector::stateCb(const mavros_msgs::State::ConstPtr &msg) { std::lock_guard<std::mutex> lock(mtx_); state_ = *msg; }
void UAVStateCollector::batteryCb(const sensor_msgs::BatteryState::ConstPtr &msg) { std::lock_guard<std::mutex> lock(mtx_); battery_ = *msg; }
void UAVStateCollector::gpsCb(const sensor_msgs::NavSatFix::ConstPtr &msg) { std::lock_guard<std::mutex> lock(mtx_); gps_ = *msg; }
void UAVStateCollector::poseCb(const geometry_msgs::PoseStamped::ConstPtr &msg) { std::lock_guard<std::mutex> lock(mtx_); pose_ = msg->pose; }
void UAVStateCollector::velCb(const geometry_msgs::TwistStamped::ConstPtr &msg) { std::lock_guard<std::mutex> lock(mtx_); vel_ = msg->twist; }
void UAVStateCollector::gpsRawCb(const mavros_msgs::GPSRAW::ConstPtr &msg) { std::lock_guard<std::mutex> lock(mtx_); gps_raw_ = *msg; }
void UAVStateCollector::imuCb(const sensor_msgs::Imu::ConstPtr &msg) { std::lock_guard<std::mutex> lock(mtx_); imu_ = *msg; }
