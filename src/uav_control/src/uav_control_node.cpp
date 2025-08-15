#include "uav_control/uav_control_node.h"

UAVControlNode::UAVControlNode(ros::NodeHandle& nh) : nh_(nh)
{
    initParameters();

    // 初始化 SafetyChecker
    safety_checker_ = new SafetyChecker(nh_);
    waitForMavrosConnection();

    // 初始化 CommandExecutor
    command_executor_ = new CommandExecutor(nh_);

    ROS_INFO("[UAVControlNode] Initialization is complete.");
}

void UAVControlNode::initParameters()
{
    nh_.param<std::string>("uav_id", uav_id_, "uav1");
    nh_.param("loop_rate_hz", loop_rate_hz_, 20.0);  // 默认 20 Hz
    ROS_INFO("[UAVControlNode] UAV ID: %s, loop_rate: %.1f Hz", uav_id_.c_str(), loop_rate_hz_);
}

void UAVControlNode::waitForMavrosConnection()
{
    ROS_INFO("[UAVControlNode] Waiting for MAVROS connection...");
    ros::Rate r(1.0);
    while (ros::ok() && !safety_checker_->waitMavrosConnected(10.0)) {
        ROS_WARN("[UAVControlNode] MAVROS is not connected, waiting...");
        r.sleep();
    }
    ROS_INFO("[UAVControlNode] MAVROS is connected.");
}

void UAVControlNode::run()
{
    ros::Rate rate(loop_rate_hz_);

    // 起飞前安全检查
    ROS_INFO("[UAVControlNode] Performing pre-flight safety check...");
    if (!safety_checker_->preFlightCheck()) {
        ROS_ERROR("[UAVControlNode] Pre-flight safety check failed, node will stop!");
        return;
    }
    ROS_INFO("[UAVControlNode] Pre-flight safety check passed.");

    while (ros::ok()) {
        ros::spinOnce();

        // 飞行中安全检查
        if (!safety_checker_->inFlightCheck()) {
            ROS_WARN_THROTTLE(5.0, "[UAVControlNode] In-flight safety check failed, please pay attention!");
        }

        rate.sleep();
    }
}

// ===================== main =====================
int main(int argc, char** argv)
{
    ros::init(argc, argv, "uav_control_node");
    ros::NodeHandle nh("~");

    UAVControlNode node(nh);
    node.run();

    return 0;
}
