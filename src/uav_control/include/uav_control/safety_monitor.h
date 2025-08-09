#pragma once
#include <ros/ros.h>

class SafetyMonitor {
public:
    SafetyMonitor() = default;
    void init(ros::NodeHandle& nh, const std::string& ns);

    bool checkUnsafe(std::string& reason); // true if unsafe
private:
    ros::NodeHandle nh_;
    std::string ns_;
    double min_battery_pct_{20.0};
    double cmd_timeout_{5.0};
    // TODO: subscribe battery/gps topics to implement real checks
};
