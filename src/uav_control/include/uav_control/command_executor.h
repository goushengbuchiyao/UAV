#pragma once

#include <ros/ros.h>
#include <uav_msgs/UAVControlCommand.h>

namespace uav_control {

class CommandExecutor {
public:
    CommandExecutor(ros::NodeHandle& nh);

    // 执行UAVControlCommand
    bool executeCommand(const uav_msgs::UAVControlCommand& cmd);

private:
    ros::NodeHandle nh_;

    // MAVROS服务客户端或话题发布者声明
};

} // namespace uav_control
