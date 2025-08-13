#include "uav_control/uav_control_node.h"

namespace uav_control {

UAVControlNode::UAVControlNode(ros::NodeHandle& nh)
    : nh_(nh),
      safety_checker_(nh),
      param_loader_(nh),
      cmd_executor_(nh) {

    // 订阅UAVControlCommand
    cmd_sub_ = nh_.subscribe("/mqtt_ros_bridge/uav1/ros/uavcontrol/command", 10, 
                             &UAVControlNode::uavControlCmdCallback, this);
    // 发布状态
    status_pub_ = nh_.advertise<std_msgs::String>("uav_control/status", 10);

    // 是否启用PX4参数加载
    nh_.param("enable_px4_params_load", enable_px4_params_load_, false);

    // MAVROS连接检查定时器
    connection_timer_ = nh_.createTimer(ros::Duration(1.0), 
                  &UAVControlNode::mavrosConnectionCheck, this);
}

// 检查MAVROS连接并加载PX4参数
void UAVControlNode::mavrosConnectionCheck(const ros::TimerEvent&) {
    if (!mavros_connected_) {
        ROS_INFO_THROTTLE(5, "等待MAVROS与FCU连接...");
        // TODO: 实际应订阅 /mavros/state 检查 connected 字段
        static int retry_count = 0;
        retry_count++;
        if (retry_count > 10) {
            ROS_ERROR("PX4飞控连接失败");
            ros::shutdown();
        }
        mavros_connected_ = true; // 模拟成功
        if (enable_px4_params_load_) {
            bool loaded = param_loader_.loadParameters();
            if (!loaded) {
                ROS_WARN("PX4参数加载失败，继续初始化");
            }
        }
    }
}

// UAVControlCommand回调
void UAVControlNode::uavControlCmdCallback(const uav_msgs::UAVControlCommand::ConstPtr& msg) {
    if (!safety_checker_.checkInFlight()) {
        ROS_WARN("飞行中安全检查未通过，拒绝执行命令");
        return;
    }

    if (!cmd_executor_.executeCommand(*msg)) {
        ROS_ERROR("执行命令失败，切换安全模式");
        // TODO: 回退安全模式逻辑
    }
}

void UAVControlNode::run() {
    ros::spin();
}

} // namespace uav_control

int main(int argc, char** argv) {
    ros::init(argc, argv, "uav_control_node");
    ros::NodeHandle nh("~");
    uav_control::UAVControlNode node(nh);
    node.run();
    return 0;
}
