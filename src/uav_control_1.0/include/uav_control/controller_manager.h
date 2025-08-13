#pragma once
#include <ros/ros.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>

class ControllerManager {
public:
    ControllerManager() = default;
    void init(ros::NodeHandle& nh, const std::string& ns);

    void publishPosition(const geometry_msgs::PoseStamped& p);
    void publishVelocity(const geometry_msgs::TwistStamped& v);
    void stopAll();

private:
    ros::Publisher pos_pub_;
    ros::Publisher vel_pub_;
    ros::NodeHandle nh_;
    std::string ns_;
};
