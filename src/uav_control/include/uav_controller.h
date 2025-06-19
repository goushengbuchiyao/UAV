#ifndef UAV_CONTROLLER_H
#define UAV_CONTROLLER_H

#include <ros/ros.h>
#include <bitset>
#include <Eigen/Eigen>

#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/State.h>
#include <mavros_msgs/PositionTarget.h>
#include <mavros_msgs/AttitudeTarget.h>
#include <mavros_msgs/GlobalPositionTarget.h>
#include <mavros_msgs/RCIn.h>
#include <mavros_msgs/CommandLong.h>
#include <mavros_msgs/CommandHome.h>
#include <mavros_msgs/ParamGet.h>
#include <mavros_msgs/ParamSet.h>
#include <mavros_msgs/ParamValue.h>

#include <std_msgs/Bool.h>

#include <px_uav_msgs/UAVState.h>
#include <px_uav_msgs/UAVSetup.h>
#include <px_uav_msgs/UAVControlState.h>
#include <px_uav_msgs/UAVCommand.h>
#include <px_uav_msgs/TextInfo.h>
#include <px_uav_msgs/OffsetPose.h>
#include <px_uav_msgs/ParamSettings.h>

#include <nav_msgs/Odometry.h>

#include "geometry_utils.h"
#include "printf_utils.h"
#include "rc_input.h"
#include "math_utils.h"
#include "controller_utils.h"
#include "pos_controller_PID.h"
#include "pos_controller_UDE.h"
#include "pos_controller_NE.h"

#include "param_manager.hpp"
#include "message_convert.hpp"

using namespace std;

class UAV_controller
{
public:
    UAV_controller(ros::NodeHandle &nh);
    void mainloop();

    // 订阅话题
    ros::Subscriber uav_cmd_sub;
    ros::Subscriber uav_state_sub;
    ros::Subscriber uav_setup_sub;
    ros::Subscriber px4_position_target_sub;
    ros::Subscriber px4_attitude_target_sub;
    ros::Subscriber px4_rc_sub;
    ros::Subscriber offset_pose_sub;
    // 地面站参数修改话题
    ros::Subscriber ros_param_set_sub;
    // 发布话题
    ros::Publisher px4_setpoint_raw_local_pub;
    ros::Publisher px4_setpoint_raw_global_pub;
    ros::Publisher px4_setpoint_raw_attitude_pub;
    ros::Publisher uav_control_state_pub;
    ros::Publisher ground_station_info_pub;
    ros::Publisher stop_control_state_pub;
    ros::Publisher serial_control_pub;
    // 服务
    ros::ServiceClient px4_arming_client;
    ros::ServiceClient px4_set_mode_client;
    ros::ServiceClient px4_reboot_client;
    ros::ServiceClient px4_emergency_client;
    // 飞控参数获取/修改服务
    ros::ServiceClient px4_param_get_client;
    ros::ServiceClient px4_param_set_client;

    px_uav_msgs::UAVCommand uav_command;      // 指令
    px_uav_msgs::UAVCommand uav_command_last; // 上一时刻指令
    px_uav_msgs::UAVState uav_state;      // 无人机状态
    px_uav_msgs::UAVState uav_state_last; // 无人机状态
    px_uav_msgs::UAVControlState uav_control_state;
    px_uav_msgs::UAVSetup uav_setup;
    px_uav_msgs::TextInfo text_info;
    px_uav_msgs::TextInfo last_text_info;
    px_uav_msgs::OffsetPose offset_pose;

    std_msgs::Bool stop_control_state;

    RC_Input rc_input;

    // 控制器
    enum POS_CONTOLLER
    {
        PX4_ORIGIN = 0, // PX4原生的控制算法
        PID = 1,        // PID算法
        UDE = 2,        // UDE算法
        NE = 3          // NE算法
    };

    // 执行状态
    enum CONTROL_STATE
    {
        INIT = 0,               // 初始模式      
        RC_POS_CONTROL = 1,     // 悬停状态
        COMMAND_CONTROL = 2,    // 指令控制
        LAND_CONTROL = 3        // 降落
    };
    CONTROL_STATE control_state;
    CONTROL_STATE last_control_state;
    struct geo_fence
    {
        float x_min;
        float x_max;
        float y_min;
        float y_max;
        float z_min;
        float z_max;
    };
    geo_fence uav_geo_fence;

    // 记录px4参数根据定位源不同值
    bool is_rebot_px4 = true;
    bool reboot_px4_set_reset_ekf = false;
    double mc_yawrate_max = 100.0;
    double mpc_xy_vel_max = 1.0;
    double mpc_acc_hor = 2.0;
    double mpc_vel_manual = 1.0;

    // 基本变量
    int uav_id;      // 无人机编号
    string uav_name; // 无人机名字
    string node_name;
    int pos_controller;
    bool enable_external_control;
    bool sim_mode;
    bool quick_land;
    float Takeoff_height; // 默认起飞高度
    float Disarm_height;  // 自动上锁高度
    float Land_speed;     // 降落速度
    double COMMAND_MPC_XY_VEL_MAX;
    double COMMAND_MPC_ACC_HOR;
    bool set_landing_des;

    // PX4参数 用于存储需要修改的PX4参数
    std::unordered_map<std::string, std::string> px4_params;
    ros::NodeHandle nh;

    // 无人机状态量
    Eigen::Vector3d uav_pos;     // 无人机位置
    Eigen::Vector3d uav_vel;     // 无人机速度
    Eigen::Quaterniond uav_quat; // 无人机四元数
    double uav_yaw;

    
    float vel_control_grap = 0.04f;
    float vel_control_Kp = 1.8f;
    float Speed_decision_range = 0.09f;
    float yaw_decision_range = 0.0349f;// 将0.0157(0.9°)以内的视为0°，由于自身误差
    bool vel_control = false;
    bool yaw_control = false;
    Eigen::Vector3d prev_vel_sp;
    Eigen::Vector3d current_pos;     // 控制中无人机当前位置
    double current_yaw;
    double prev_yaw_sp;
    int move_orient = 0;
    int prev_move_orient = 0;

    // 目标设定值
    Eigen::Vector3d pos_des;
    Eigen::Vector3d global_pos_des;
    Eigen::Vector3d vel_des;
    Eigen::Vector3d acc_des;
    Eigen::Vector4d u_att;      // 期望姿态角（rad）+期望油门（0-1）
    double yaw_des;
    double yaw_rate_des;

    // 辅助点
    Eigen::Vector3d Takeoff_position;
    double Takeoff_yaw;
    Eigen::Vector3d Hover_position;
    double Hover_yaw;
    ros::Time last_set_hover_pose_time;
    ros::Time last_check_px4_location_source_time;

    ros::Timer check_px4_location_source_timer;
    ros::Timer ground_station_info_timer;

    pos_controller_PID pos_controller_pid;
    pos_controller_UDE pos_controller_ude;
    pos_controller_NE pos_controller_ne;

    // PX4中的位置设定值（用于验证控制指令是否正确发送）
    Eigen::Vector3d px4_pos_target;
    // PX4中的速度设定值（用于验证控制指令是否正确发送）
    Eigen::Vector3d px4_vel_target;
    // PX4中的加速度设定值（用于验证控制指令是否正确发送）
    Eigen::Vector3d px4_acc_target;
    // PX4中的姿态设定值（用于验证控制指令是否正确发送）
    Eigen::Vector3d px4_att_target;
    Eigen::Vector3d px4_rates_target;
    // PX4中的推力设定值（用于验证控制指令是否正确发送）
    float px4_thrust_target;

    void printf_control_state();

private:
    void uav_cmd_cb(const px_uav_msgs::UAVCommand::ConstPtr &msg);
    void uav_state_cb(const px_uav_msgs::UAVState::ConstPtr &msg);
    void uav_setup_cb(const px_uav_msgs::UAVSetup::ConstPtr &msg);
    void px4_rc_cb(const mavros_msgs::RCIn::ConstPtr &msg);
    void px4_pos_target_cb(const mavros_msgs::PositionTarget::ConstPtr &msg);
    void px4_att_target_cb(const mavros_msgs::AttitudeTarget::ConstPtr &msg);
    void offset_pose_cb(const px_uav_msgs::OffsetPose::ConstPtr &msg);
    void param_set_cb(const px_uav_msgs::ParamSettings::ConstPtr &msg);
    void sendStationTextInfo(const ros::TimerEvent &e);

    void set_command_des();
    void set_command_des_for_pos_controller();

    int check_failsafe();
    void send_idle_cmd();
    void send_pos_cmd_to_px4_original_controller();
    void send_pos_setpoint(const Eigen::Vector3d &pos_sp, float yaw_sp);
    void send_vel_setpoint(const Eigen::Vector3d &vel_sp, float yaw_sp);
    void send_vel_setpoint_yaw_rate(const Eigen::Vector3d &vel_sp, float yaw_rate_sp);
    void send_vel_xy_pos_z_setpoint(const Eigen::Vector3d &pos_sp, const Eigen::Vector3d &vel_sp, float yaw_sp);
    void send_vel_xy_pos_z_setpoint_yaw_rate(const Eigen::Vector3d &pos_sp, const Eigen::Vector3d &vel_sp, float yaw_rate_sp);
    void send_pos_vel_xyz_setpoint(const Eigen::Vector3d &pos_sp, const Eigen::Vector3d &vel_sp, float yaw_sp);
    void send_acc_xyz_setpoint(const Eigen::Vector3d &accel_sp, float yaw_sp);
    void send_attitude_setpoint(Eigen::Vector4d &u_att);
    void send_global_setpoint(const Eigen::Vector3d &global_pos_sp, float yaw_sp);
    Eigen::Vector4d get_cmd_from_controller();
    void set_px4_mode_func(string mode);
    void rotation_yaw(double yaw_angle, float body_frame[2], float enu_frame[2]);
    void printf_param();
    void set_hover_pose_with_odom();
    void set_hover_pose_with_rc();
    void arm_disarm_func(bool on_or_off);
    void enable_emergency_func();
    void reboot_PX4();
    // MAVLINK 消息： SERIAL_CONTROL(126)的发布
    // 这里主要模拟一个QGC终端 MAVLINK CONSOLE 的实现
    void send_serial_control(const std::string &cmd);

    std::unordered_map<std::string, std::string> get_px4_params(ros::NodeHandle &nh);
    // 定时器检查当前定位源下飞控参数设置是否正确
    void timercb_check_px4_location_source(const ros::TimerEvent &e);
    bool px4_param_set(std::string param_id, int64_t param_value);
    bool px4_param_set(std::string param_id, double param_value);
};

#endif
