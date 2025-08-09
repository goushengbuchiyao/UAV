#pragma once
#include <ros/ros.h>
#include <mavros_msgs/RCIn.h>

class RCMonitor {
public:
    RCMonitor() = default;
    void init(ros::NodeHandle& nh, const std::string& ns = "");

    bool isRCOverride() const;
    void resetOverride();
    double lastUpdateSec() const;

private:
    void rcCallback(const mavros_msgs::RCIn::ConstPtr& msg);

    ros::Subscriber rc_sub_;
    ros::Time last_rc_time_;
    bool rc_override_{false};
    int channel_count_{0};
    int deadzone_{50}; // change detection threshold (us)
    std::string rc_topic_;
};
