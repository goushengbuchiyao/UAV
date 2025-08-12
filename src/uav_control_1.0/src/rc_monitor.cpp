#include "uav_control/rc_monitor.h"

void RCMonitor::init(ros::NodeHandle& nh, const std::string& ns) {
    // topic like "/uav1/mavros/rc/in" or "/mavros/rc/in" if ns empty
    rc_topic_ = (ns.empty() ? "/mavros/rc/in" : ns + "/mavros/rc/in");
    rc_sub_ = nh.subscribe(rc_topic_, 10, &RCMonitor::rcCallback, this);
}

void RCMonitor::rcCallback(const mavros_msgs::RCIn::ConstPtr& msg) {
    // if first time, set channel_count_
    if (channel_count_ == 0) channel_count_ = msg->channels.size();

    // simple change detection: if any channel deviates from mid significantly
    rc_override_ = false;
    for (auto v : msg->channels) {
        if (v < 1000) continue; // ignore empty channels
        // mid approx 1500; detect large move
        if (v > 1500 + deadzone_ || v < 1500 - deadzone_) {
            rc_override_ = true;
            break;
        }
    }
    last_rc_time_ = ros::Time::now();
}

bool RCMonitor::isRCOverride() const {
    // if no update recently, treat as not overriding
    if ((ros::Time::now() - last_rc_time_).toSec() > 2.0) return false;
    return rc_override_;
}

void RCMonitor::resetOverride() {
    rc_override_ = false;
}

double RCMonitor::lastUpdateSec() const {
    return last_rc_time_.toSec();
}
