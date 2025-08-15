#ifndef UAV_CONTROL_NODE_H
#define UAV_CONTROL_NODE_H

#include <ros/ros.h>
#include <ros/package.h>
#include <std_msgs/String.h>
#include <mavros_msgs/State.h>
#include <uav_msgs/UAVControlCommand.h>

#include <map>
#include <memory>
#include <string>

// 模块依赖
#include "command_executor.h"
#include "safety_checker.h"

/**
 * @brief UAVControlNode 是无人机控制的核心节点
 * - 初始化 MAVROS 连接
 * - 批量下发 PX4 参数（可选）
 * - 接收 UAV 云端指令并执行对应操作
 * - 定时进行安全检查
 */
class UAVControlNode {
public:
    UAVControlNode(ros::NodeHandle& nh, ros::NodeHandle& nh_private);
    ~UAVControlNode();

    // 启动主循环
    void run();

private:
    /**
     * @brief 初始化 ROS 参数、配置文件、内部变量
     */
    void initParams();

    /**
     * @brief 初始化订阅器
     */
    void initSubscribers();

    /**
     * @brief 初始化发布器
     */
    void initPublishers();

    /**
     * @brief 初始化安全检查和指令执行模块
     */
    void initModules();

    /**
     * @brief 等待与 PX4 FCU 建立连接
     */
    void waitForFCUConnection();

    /**
     * @brief 批量下发 PX4 参数
     */
    void loadPX4Params();

    /**
     * @brief 重启 PX4 并复位 EKF（可选）
     */
    void rebootPX4IfNeeded();

    /**
     * @brief 接收云端 UAV 控制指令的回调
     */
    void commandCallback(const uav_msgs::UAVControlCommand::ConstPtr& msg);

    /**
     * @brief 定时执行安全检测
     */
    void performSafetyCheck(const ros::TimerEvent&);

    /**
     * @brief 接收 MAVROS 状态回调
     */
    void stateCallback(const mavros_msgs::State::ConstPtr& msg);

private:
    ros::NodeHandle nh_;
    ros::NodeHandle nh_private_;

    ros::Subscriber command_sub_;
    ros::Subscriber state_sub_;
    ros::Timer safety_check_timer_;

    std::shared_ptr<SafetyChecker> safety_checker_;
    std::shared_ptr<CommandExecutor> command_executor_;

    // 参数
    bool enable_px4_params_load_;
    bool reboot_px4_set_reset_ekf_;
    std::map<std::string, double> px4_params_;

    // 状态
    mavros_msgs::State current_state_;
};

#endif // UAV_CONTROL_NODE_H
