#ifndef UAV_CONTROL_COMMAND_EXECUTOR_H
#define UAV_CONTROL_COMMAND_EXECUTOR_H

#include <ros/ros.h>
#include <uav_msgs/UAVControlCommand.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/CommandTOL.h>
#include <mavros_msgs/PositionTarget.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <sensor_msgs/NavSatFix.h>

/**
 * @brief CommandExecutor 负责接收 UAVControlCommand 指令并执行 MAVROS 控制操作
 * 
 * 功能：
 *  1. 订阅云端 UAV 指令
 *  2. 根据 command_type 执行对应飞控指令
 *  3. 支持起飞、降落、悬停、返航、位置控制（NED/Global）、速度控制、模式切换
 */
class CommandExecutor
{
public:
    CommandExecutor(ros::NodeHandle& nh);
    ~CommandExecutor() = default;

private:
    // === ROS Subscriber ===
    ros::Subscriber command_sub_;

    // === ROS Publishers ===
    ros::Publisher local_pos_pub_;   // 发布本地位置
    ros::Publisher vel_pub_;         // 发布速度
    ros::Publisher global_pos_pub_;  // 发布全局位置

    // === ROS Service Clients ===
    ros::ServiceClient arming_client_;
    ros::ServiceClient set_mode_client_;
    ros::ServiceClient takeoff_client_;
    ros::ServiceClient land_client_;
    ros::ServiceClient rtl_client_;

    // === 回调函数 ===
    void commandCallback(const uav_msgs::UAVControlCommand::ConstPtr& msg);

    // === 指令执行函数 ===
    bool armUAV(bool arm);
    bool setFlightMode(const std::string& mode);
    bool executeTakeoff(double altitude, double yaw);
    bool executeLand(double yaw);
    bool executeReturnToLaunch(double altitude);
    void executeHover(const std::string& mode);
    void executePositionNED(double x, double y, double z, double yaw);
    void executePositionGlobal(double lat, double lon, double alt, double yaw);
    void executeVelocityNED(double vx, double vy, double vz, double yaw_rate);
};

#endif // UAV_CONTROL_COMMAND_EXECUTOR_H
