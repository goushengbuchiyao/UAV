#ifndef COMMAND_EXECUTOR_H
#define COMMAND_EXECUTOR_H
#pragma once

#include <ros/ros.h>
#include <uav_msgs/UAVControlCommand.h>
#include <mavros_msgs/CommandTOL.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/CommandBool.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <string>

/**
 * CommandExecutor
 * 将 uav_msgs::UAVControlCommand 映射为 MAVROS 服务/话题调用
 */
class CommandExecutor {
public:
    CommandExecutor();
    void init(ros::NodeHandle &nh, const std::string& ns);

    // 执行顶层消息，返回 true 表示已成功分发或调用
    bool execute(const uav_msgs::UAVControlCommand& msg, std::string& out_reason);

    // 也保留单项方法供外部调用
    bool doTakeoff(double altitude, double yaw, std::string& out_reason);
    bool doLand(double yaw, std::string& out_reason);
    bool doPositionNED(const uav_msgs::UAVControlCommand::_pos_ned_type &p, std::string& out_reason);
    bool doVelocityNED(const uav_msgs::UAVControlCommand::_vel_ned_type &v, std::string& out_reason);
    bool doRTL(double altitude, std::string& out_reason);
    bool doHover(const std::string& mode, std::string& out_reason);
    bool doSetMode(const std::string& mode, std::string& out_reason);

private:
    ros::NodeHandle nh_;
    std::string ns_;

    ros::ServiceClient takeoff_srv_;
    ros::ServiceClient land_srv_;
    ros::ServiceClient set_mode_srv_;
    ros::ServiceClient arming_srv_;

    ros::Publisher pos_pub_;
    ros::Publisher vel_pub_;
};
#endif