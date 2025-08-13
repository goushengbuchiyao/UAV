#pragma once
#include <ros/ros.h>
#include <geometry_msgs/PoseStamped.h>

class SetpointPublisher {
public:
    SetpointPublisher() = default;
    void init(ros::NodeHandle& nh, const std::string& ns, double rate = 20.0);
    void start();
    void stop();
    void updatePose(const geometry_msgs::PoseStamped& p);

private:
    void timerCb(const ros::TimerEvent&);
    ros::NodeHandle nh_;
    ros::Publisher pub_;
    ros::Timer timer_;
    geometry_msgs::PoseStamped current_;
    bool active_{false};
    double rate_{20.0};
    std::string ns_;
};
