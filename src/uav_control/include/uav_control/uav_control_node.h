#ifndef UAV_CONTROL_NODE_H
#define UAV_CONTROL_NODE_H

#include <ros/ros.h>
#include <std_msgs/String.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <sensor_msgs/BatteryState.h>
#include <mavros_msgs/State.h>
#include <mavros_msgs/GPSRAW.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/CommandTOL.h>
#include <uav_msgs/UAVControlCommand.h>
#include <yaml-cpp/yaml.h>
#include <thread>
#include <mutex>

class UAVControlNode
{
public:
    UAVControlNode(ros::NodeHandle& nh);
    void run();

private:
    ros::NodeHandle nh_;
    std::string uav_id_;
    std::string prefix_;

    // MAVROS Subscribers
    ros::Subscriber state_sub_;
    ros::Subscriber battery_sub_;
    ros::Subscriber gps_sub_;
    ros::Subscriber global_pos_sub_;
    ros::Subscriber local_pos_sub_;
    ros::Subscriber velocity_sub_;

    // UAVControlCommand Subscriber
    ros::Subscriber cmd_sub_;

    // MAVROS Service Clients
    ros::ServiceClient arming_client_;
    ros::ServiceClient set_mode_client_;
    ros::ServiceClient takeoff_client_;
    ros::ServiceClient land_client_;

    // MAVROS Publishers
    ros::Publisher local_pos_pub_;
    ros::Publisher local_vel_pub_;

    // UAV 状态缓存
    mavros_msgs::State current_state_;
    sensor_msgs::BatteryState battery_;
    mavros_msgs::GPSRAW gps_;
    geometry_msgs::PoseStamped local_pose_;
    geometry_msgs::TwistStamped velocity_;

    // 地理围栏参数
    double fence_min_x_, fence_max_x_, fence_min_y_, fence_max_y_, fence_min_z_, fence_max_z_;

    std::mutex state_mutex_;

    // 回调函数
    void stateCallback(const mavros_msgs::State::ConstPtr& msg);
    void batteryCallback(const sensor_msgs::BatteryState::ConstPtr& msg);
    void gpsCallback(const mavros_msgs::GPSRAW::ConstPtr& msg);
    void localPosCallback(const geometry_msgs::PoseStamped::ConstPtr& msg);
    void velocityCallback(const geometry_msgs::TwistStamped::ConstPtr& msg);
    void uavCommandCallback(const uav_msgs::UAVControlCommand::ConstPtr& msg);

    // 核心功能
    bool checkPreArmSafety();
    bool checkInFlightSafety();
    bool isInsideFence(double x, double y, double z);
    void executeCommand(const uav_msgs::UAVControlCommand& cmd);

    // MAVROS操作
    bool arm();
    bool setMode(const std::string& mode);
    bool takeoff(double altitude, double yaw);
    bool land(double yaw);
    void sendPositionSetpoint(double x, double y, double z, double yaw);
    void sendVelocitySetpoint(double vx, double vy, double vz, double yaw_rate);

    // 参数加载
    void loadPX4Params(const std::string& yaml_file);
};

#endif
