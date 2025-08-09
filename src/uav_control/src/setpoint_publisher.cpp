#include "uav_control/setpoint_publisher.h"

void SetpointPublisher::init(ros::NodeHandle& nh, const std::string& ns, double rate) {
    nh_ = nh;
    ns_ = ns;
    rate_ = rate;
    std::string topic = (ns_.empty() ? "/mavros/setpoint_position/local" : ns_ + "/mavros/setpoint_position/local");
    pub_ = nh_.advertise<geometry_msgs::PoseStamped>(topic, 10);
}

void SetpointPublisher::start() {
    if (active_) return;
    timer_ = nh_.createTimer(ros::Duration(1.0 / rate_), &SetpointPublisher::timerCb, this);
    active_ = true;
}

void SetpointPublisher::stop() {
    if (!active_) return;
    timer_.stop();
    active_ = false;
}

void SetpointPublisher::updatePose(const geometry_msgs::PoseStamped& p) {
    current_ = p;
}

void SetpointPublisher::timerCb(const ros::TimerEvent&) {
    if (!active_) return;
    current_.header.stamp = ros::Time::now();
    pub_.publish(current_);
}
