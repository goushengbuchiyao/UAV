#include <ros/ros.h>
#include <mqtt_ros_node.h>

int main(int argc, char**argv) {
    // 初始化ROS节点
    ros::init(argc, argv, "mqtt_ros_bridge");
    ros::NodeHandle nh("~"); // 使用私有命名空间

    try {
        // 创建并初始化节点
        mqtt_bridge::MQTTROSNode node(nh);
        if (node.init()) {
            // 运行节点
            node.run();
        } else {
            ROS_ERROR("Failed to initialize MQTT-ROS bridge");
            return 1;
        }
    } catch (const std::exception& e) {
        ROS_FATAL("Unhandled exception: %s", e.what());
        return 1;
    }

    return 0;
}
