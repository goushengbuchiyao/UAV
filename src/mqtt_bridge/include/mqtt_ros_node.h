#ifndef MQTT_BRIDGE_MQTT_ROS_NODE_H
#define MQTT_BRIDGE_MQTT_ROS_NODE_H

#include <ros/ros.h>
#include <std_msgs/String.h>
#include <mqtt_client.h>
#include <string>
#include <memory>
#include "uav_state_collector.h"
namespace mqtt_bridge {

class MQTTROSNode {
public:
    /**
     * @brief 构造函数
     * @param nh ROS节点句柄
     */
    MQTTROSNode(ros::NodeHandle& nh);

    /**
     * @brief 初始化节点
     * @return 初始化是否成功
     */
    bool init();

    /**
     * @brief 运行节点
     */
    void run();

private:
    /**
     * @brief 从ROS参数服务器加载配置
     * @return 是否加载成功
     */
    bool loadParameters();

    /**
     * @brief 处理从MQTT接收的消息
     * @param topic 消息主题
     * @param payload 消息内容
     */
    void handleMQTTMessage(const std::string& topic, const std::string& payload);

    /**
     * @brief 处理从ROS接收的消息
     * @param msg ROS消息
     */
    void handleROSMessage(const std_msgs::String::ConstPtr& msg);

    /**
     * @brief 处理MQTT连接状态变化
     * @param connected 是否连接
     */
    void handleConnectionStatus(bool connected);

    // ROS相关
    ros::NodeHandle nh_;
    ros::Publisher mqtt_to_ros_pub_;  // MQTT到ROS的发布器
    ros::Subscriber ros_to_mqtt_sub_; // ROS到MQTT的订阅器
    
    // MQTT相关
    std::unique_ptr<MQTTClient> mqtt_client_;
    
    // 配置参数
    std::string mqtt_server_uri_;
    std::string mqtt_client_id_;
    std::string mqtt_ca_path_;
    std::string mqtt_username_;
    std::string mqtt_password_;
    int mqtt_port_;
    int mqtt_reconnect_interval_;
    
    // 主题映射
    std::string mqtt_subscribe_topic_;  // 要订阅的MQTT主题
    std::string mqtt_publish_topic_;    // 要发布的MQTT主题
    std::string ros_publish_topic_;     // 要发布的ROS主题
    std::string ros_subscribe_topic_;   // 要订阅的ROS主题

    // UAV状态采集器
    std::unique_ptr<UAVStateCollector> uav_collector_;
};

} // namespace mqtt_bridge

#endif // MQTT_BRIDGE_MQTT_ROS_NODE_H
