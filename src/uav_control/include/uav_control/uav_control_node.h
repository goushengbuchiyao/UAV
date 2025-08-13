#pragma once

#include <ros/ros.h>
#include <std_msgs/String.h>
#include <uav_msgs/UAVControlCommand.h>
#include "safety_checker.h"
#include "px4_param_loader.h"
#include "command_executor.h"

namespace uav_control {

class UAVControlNode {
public:
    UAVControlNode(ros::NodeHandle& nh);
    void run();

private:
    void mavrosConnectionCheck(const ros::TimerEvent& event);
    void uavControlCmdCallback(const uav_msgs::UAVControlCommand::ConstPtr& msg);

    ros::NodeHandle nh_;
    ros::Subscriber cmd_sub_;
    ros::Publisher status_pub_;

    SafetyChecker safety_checker_;
    PX4ParamLoader param_loader_;
    CommandExecutor cmd_executor_;

    bool mavros_connected_ = false;
    bool enable_px4_params_load_ = false;

    ros::Timer connection_timer_;
};

} // namespace uav_control
