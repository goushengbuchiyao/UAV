#include "uav_control/safety_monitor.h"

void SafetyMonitor::init(ros::NodeHandle& nh, const std::string& ns) {
    nh_ = nh;
    ns_ = ns;
    nh_.param("min_battery_pct", min_battery_pct_, 20.0);
    nh_.param("command_timeout", cmd_timeout_, 5.0);
}

bool SafetyMonitor::checkUnsafe(std::string& reason) {
    // placeholder -> always safe; expand to check battery, gps, etc.
    (void)reason;
    return false;
}
