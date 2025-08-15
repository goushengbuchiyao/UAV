#pragma once

#include <ros/ros.h>
#include <ros/param.h>
#include <std_msgs/String.h>
#include <mavros_msgs/State.h>
#include <mavros_msgs/RCIn.h>
#include <mavros_msgs/ParamSet.h>
#include <mavros_msgs/ParamValue.h>
#include <mavros_msgs/CommandLong.h>
#include <sensor_msgs/BatteryState.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <sensor_msgs/NavSatFix.h>
#include <mavros_msgs/GPSRAW.h>
#include <string>
#include <unordered_map>
#include <optional>
#include <vector>

/**
 * @brief 安全检查器：起飞前与飞行中安全监控 + 可选PX4参数写入 + 写后重启
 *
 * 使用方法（示例）：
 *   SafetyChecker checker(nh);
 *   checker.loadParameters();            // 读取本地安全参数 + 收集PX4参数
 *   if (checker.enablePX4ParamsLoad()) {
 *       checker.loadPX4ParamsToFCU();    // 批量写入PX4；若 reboot_px4_set_reset_ekf=true 则完成后重启
 *   }
 *   if (!checker.preFlightCheck()) { ... }
 *   if (!checker.inFlightCheck())  { ... }
 */
class SafetyChecker {
public:
    explicit SafetyChecker(ros::NodeHandle& nh);

    // ============ 参数加载与PX4参数写入 ============
    void loadParameters();                 ///< 从ROS参数服务器加载所有检查相关参数
    bool loadPX4ParamsToFCU();             ///< 若开启，按px4_params字典写入PX4（MAVROS /mavros/param/set）

    // ============ 起飞前安全检查（流程图A3） ============
    bool preFlightCheck();                 ///< 起飞前安全检查入口（依次调用各子检查）

    // ============ 飞行中安全检查（流程图E1） ============
    bool inFlightCheck();                  ///< 飞行中安全检查入口（依次调用各子检查）

    // ============ 状态/工具 ============
    int  getSafetyFlag() const { return safety_flag_; }  ///< 0正常，非0异常
    void publishSafetyStatus();                           ///< 发布JSON安全状态

    bool enablePX4ParamsLoad() const { return enable_px4_params_load_; }
    
    bool waitMavrosConnected(double timeout_sec); ///< 等待 /mavros/state 连接FCU
private:
    // ====== 工具函数 ======
    void collectPX4ParamsFromROS();        ///< 遍历节点命名空间，把需推送到PX4的参数收集到 px4_params_*_
    
    bool rebootPX4();                      ///< 使用 CommandLong 发送 MAV_CMD_PREFLIGHT_REBOOT_SHUTDOWN

    // ====== 起飞前子检查 ======
    bool checkPX4Params();                 ///< PX4 参数是否符合预期（与px4_params做对比，允许缺省）
    bool checkBatteryHealth();             ///< 电池电压/百分比/电流等判定
    bool checkGeoFence();                  ///< 当前位置是否在围栏内（ENU）
    bool checkLocalization();              ///< 定位有效性（GPS/VIO/里程计时间戳）
    bool checkRCConnection();              ///< RC 信号时延/是否存在

    // ====== 飞行中子检查 ======
    bool checkVelocityAndPositionLimits(); ///< 速度、位置跳变等
    // bool checkLinkStatus();                ///< 链路心跳（MQTT/地面站）是否超时

    // ====== 回调 ======
    void stateCb(const mavros_msgs::State::ConstPtr& msg);
    void batteryCb(const sensor_msgs::BatteryState::ConstPtr& msg);
    void poseCb(const geometry_msgs::PoseStamped::ConstPtr& msg);
    void velCb(const geometry_msgs::TwistStamped::ConstPtr& msg);
    void rcCb(const mavros_msgs::RCIn::ConstPtr& msg);
    void gpsFixCb(const sensor_msgs::NavSatFix::ConstPtr& msg);
    void gpsRawCb(const mavros_msgs::GPSRAW::ConstPtr& msg);
    // void heartbeatCb(const std_msgs::String::ConstPtr& msg);

    // ====== 工具 ======
    static double planarSpeed(double vx, double vy) { return std::sqrt(vx*vx + vy*vy); }
    bool withinFence(double x, double y, double z) const;

private:
    ros::NodeHandle nh_;

    // ---------- 运行期状态 ----------
    std::string uav_id_{"uav1"};
    std::string prefix_{"/uav1"}; // = "/" + uav_id_

    bool current_state_;
    double battery_state_remaining;
    double battery_state_voltage;
    geometry_msgs::Pose   current_pose_;
    geometry_msgs::Twist  current_velocity_;
    std::vector<uint16_t>            rc_input_;
    // sensor_msgs::NavSatFix       gps_fix_;
    int gps_raw_fix_type;
    int gps_raw_satellites_visible;

    bool has_pose_{false};
    bool has_vel_{false};
    bool has_batt_{false};
    bool has_rc_{false};
    bool has_gps_fix_{false};
    bool has_gps_raw_{false};

    geometry_msgs::Pose   last_pose_;
    bool has_last_pose_{false};

    ros::Time last_rc_input_time_;
    // ros::Time last_link_heartbeat_;

    int safety_flag_{0}; // 0正常，1围栏，2定位，3RC，4速度/位置，5电池，6参数

    // ---------- ROS通道 ----------
    ros::Subscriber state_sub_;
    ros::Subscriber battery_sub_;
    ros::Subscriber pose_sub_;
    ros::Subscriber vel_sub_;
    ros::Subscriber rc_sub_;
    // ros::Subscriber gps_fix_sub_;
    ros::Subscriber gps_raw_sub_;
    // ros::Subscriber heartbeat_sub_; // 可选

    ros::Publisher  safety_pub_;    // JSON状态

    ros::ServiceClient param_set_cli_;
    ros::ServiceClient cmd_long_cli_;  ///< /mavros/cmd/command

    // ---------- 参数（从ROS服务器加载） ----------
    bool enable_param_from_ros_{true};       ///< 是否从参数服务器加载（总开关）
    bool enable_px4_params_load_{false};     ///< 是否向飞控写入px4_params
    bool reboot_px4_set_reset_ekf_{false};   ///< 重启PX4时是否重置EKF（不直接在此实现重启，仅作为意图参数）

    struct GeoFence {
        double x_min{-100.0}, x_max{100.0};
        double y_min{-100.0}, y_max{100.0};
        double z_min{-0.5},   z_max{100.0};
    } fence_;

    // 飞行限制/安全参数
    // double takeoff_altitude_{5.0};         ///< 起飞目标高度（校验/提示使用）
    // double landing_speed_{0.7};            ///< 期望降落速度（m/s），仅检查用
    // double disarm_altitude_{0.3};          ///< 期望落地自动上锁高度（m）
    // int    localization_source_{0};        ///< 0=Auto, 1=GPS, 2=VIO/Odom，仅提示/判定策略
    double max_flight_speed_{5.0};         ///< 最大飞行水平速度（m/s）
    double max_vertical_speed_{2.0};       ///< 最大垂直速度（m/s）

    // 预警阈值
    double battery_min_voltage_{10.5};     ///< 电压下限（示例）
    double battery_min_percentage_{20.0};  ///< 电量百分比下限（%）
    double rc_timeout_sec_{1.0};           ///< RC输入超时判定阈值
    double heartbeat_timeout_sec_{2.0};    ///< 链路心跳超时阈值
    double position_jump_thresh_{4.0};     ///< 单周期位置跳变阈值（m）

    // 链路心跳订阅话题（可选）
    // std::string heartbeat_topic_{""};

    // 需要写入PX4的参数（从ROS param获取的字典）
    // key: PX4参数名, value: double/int/string（这里仅处理数值与字符串）
    std::unordered_map<std::string, std::string>  px4_params_str_; // 若为字符串
    std::unordered_map<std::string, double>       px4_params_num_; // 若为数字
};
