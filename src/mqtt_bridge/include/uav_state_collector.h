// #pragma once

// #include <ros/ros.h>
// #include <mavros_msgs/State.h>
// #include <sensor_msgs/BatteryState.h>
// #include <sensor_msgs/NavSatFix.h>
// #include <geometry_msgs/PoseStamped.h>
// #include <geometry_msgs/TwistStamped.h>
// #include <mavros_msgs/GPSRAW.h>
// #include <nlohmann/json.hpp>

// class UAVStateCollector {
// public:
//     explicit UAVStateCollector(ros::NodeHandle& nh);

//     std::string getStateJson();

// private:
//     // 回调函数
//     void stateCallback(const mavros_msgs::State::ConstPtr& msg);
//     void batteryCallback(const sensor_msgs::BatteryState::ConstPtr& msg);
//     void globalPosCallback(const sensor_msgs::NavSatFix::ConstPtr& msg);
//     void localPosCallback(const geometry_msgs::PoseStamped::ConstPtr& msg);
//     void velocityCallback(const geometry_msgs::TwistStamped::ConstPtr& msg);
//     void gpsStatusCallback(const mavros_msgs::GPSRAW::ConstPtr& msg);

//     // ROS 句柄和订阅器
//     ros::Subscriber state_sub_, battery_sub_, global_pos_sub_, local_pos_sub_, velocity_sub_, gps_status_sub_;

//     // 存储变量
//     std::string flight_mode_;
//     float battery_percent_;
//     double latitude_, longitude_, altitude_;
//     double enu_x_, enu_y_, enu_z_;
//     double ned_x_, ned_y_, ned_z_;
//     double velocity_x_, velocity_y_, velocity_z_;
//     double roll_, pitch_, yaw_;
//     int fix_type_, satellites_visible_;
// };
#pragma once

#include <ros/ros.h>
#include <mavros_msgs/State.h>
#include <sensor_msgs/BatteryState.h>
#include <sensor_msgs/NavSatFix.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <mavros_msgs/GPSRAW.h>
#include <nlohmann/json.hpp>
#include <geometry_msgs/QuaternionStamped.h>

class UAVStateCollector {
public:
    explicit UAVStateCollector(ros::NodeHandle& nh);

    std::string getFlightModeJson();
    std::string getBatteryStatusJson();
    std::string getGPSPositionJson();
    std::string getLocalPositionJson();
    std::string getNEDPositionJson();
    std::string getVelocityJson();
    std::string getGPSStatusJson();
    std::string getAttitudeJson();
    std::string getStateJson();

private:
    void stateCallback(const mavros_msgs::State::ConstPtr& msg);
    void batteryCallback(const sensor_msgs::BatteryState::ConstPtr& msg);
    void globalPosCallback(const sensor_msgs::NavSatFix::ConstPtr& msg);
    void localPosCallback(const geometry_msgs::PoseStamped::ConstPtr& msg);
    void velocityCallback(const geometry_msgs::TwistStamped::ConstPtr& msg);
    void gpsStatusCallback(const mavros_msgs::GPSRAW::ConstPtr& msg);
    void attitudeCallback(const geometry_msgs::QuaternionStamped::ConstPtr& msg);

    ros::Subscriber state_sub_, battery_sub_, global_pos_sub_, local_pos_sub_, velocity_sub_, gps_status_sub_;

    std::string uav_id_;
    std::string fix_desc_;
    std::string flight_mode_;

    std::chrono::system_clock::time_point system_now = std::chrono::system_clock::now();
    double system_timestamp = std::chrono::duration_cast<std::chrono::seconds>(system_now.time_since_epoch()).count();

    float battery_percent_ = 0.0;
    float battery_voltage_ = 0.0;
    float battery_current_ = 0.0;
    int battery_remaining_capacity_ = 0;

    double latitude_ = 0.0, longitude_ = 0.0, altitude_amsl_ = 0.0, altitude_relative_ = 0.0;
    double enu_x_ = 0.0, enu_y_ = 0.0, enu_z_ = 0.0;
    double ned_x_ = 0.0, ned_y_ = 0.0, ned_z_ = 0.0;
    double velocity_x_ = 0.0, velocity_y_ = 0.0, velocity_z_ = 0.0;
    double ground_speed_ = 0.0;
    int fix_type_ = 0, satellites_visible_ = 0;
    float hdop_ = 0.0, vdop_ = 0.0;

    double roll_ = 0.0, pitch_ = 0.0, yaw_ = 0.0;
    double qx_ = 0.0, qy_ = 0.0, qz_ = 0.0, qw_ = 1.0;
};
