#include "uav_control/controller_manager.h"

void ControllerManager::init(ros::NodeHandle& nh, const std::string& ns) {
    nh_ = nh;
    ns_ = ns;
    std::string prefix = ns_.empty() ? "/" : ns_;
    pos_pub_ = nh_.advertise<geometry_msgs::PoseStamped>(prefix + "mavros/setpoint_position/local", 10);
    vel_pub_ = nh_.advertise<geometry_msgs::TwistStamped>(prefix + "mavros/setpoint_velocity/cmd_vel", 10);
}

void ControllerManager::publishPosition(const geometry_msgs::PoseStamped& p) {
    pos_pub_.publish(p);
}

void ControllerManager::publishVelocity(const geometry_msgs::TwistStamped& v) {
    vel_pub_.publish(v);
}

void ControllerManager::stopAll() {
    geometry_msgs::TwistStamped z;
    z.header.stamp = ros::Time::now();
    z.twist.linear.x = z.twist.linear.y = z.twist.linear.z = 0.0;
    vel_pub_.publish(z);
}
