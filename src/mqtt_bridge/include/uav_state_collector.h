#pragma once
#include <ros/ros.h>
#include <mavros_msgs/State.h>
#include <sensor_msgs/BatteryState.h>
#include <mavros_msgs/BatteryStatus.h>
#include <sensor_msgs/NavSatFix.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <mavros_msgs/GPSRAW.h>
#include <sensor_msgs/Imu.h>
#include <tf/tf.h>
#include <nlohmann/json.hpp>
#include <mutex>

class UAVStateCollector {
public:
    UAVStateCollector(ros::NodeHandle& nh);

    // 获取当前飞控数据的 JSON（线程安全）
    std::string getStateJson();

private:
    // ROS 订阅回调
    void stateCb(const mavros_msgs::State::ConstPtr &msg);
    void batteryCb(const sensor_msgs::BatteryState::ConstPtr &msg);
    void gpsCb(const sensor_msgs::NavSatFix::ConstPtr &msg);
    void poseCb(const geometry_msgs::PoseStamped::ConstPtr &msg);
    void velCb(const geometry_msgs::TwistStamped::ConstPtr &msg);
    void gpsRawCb(const mavros_msgs::GPSRAW::ConstPtr &msg);
    void imuCb(const sensor_msgs::Imu::ConstPtr &msg);

    ros::Subscriber sub_state_, sub_battery_, sub_gps_, sub_pose_, sub_vel_, sub_gps_raw_, sub_imu_ ;

    mavros_msgs::State state_;
    sensor_msgs::BatteryState battery_;
    sensor_msgs::NavSatFix gps_;
    geometry_msgs::Pose pose_;
    geometry_msgs::Twist vel_;
    mavros_msgs::GPSRAW gps_raw_;
    sensor_msgs::Imu imu_;

    std::mutex mtx_;
};
