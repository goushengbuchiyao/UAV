#ifndef UAV_CONTROL_NODE_H
#define UAV_CONTROL_NODE_H

#include <ros/ros.h>
#include <std_msgs/String.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <sensor_msgs/BatteryState.h>
#include <mavros_msgs/State.h>
#include <mavros_msgs/GPSRAW.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/CommandTOL.h>
#include <mavros_msgs/CommandLong.h>
#include <mavros_msgs/RCIn.h>
#include <mavros_msgs/WaypointClear.h>
#include <mavros_msgs/WaypointReached.h>
#include <mavros_msgs/WaypointPush.h>
#include <mavros_msgs/WaypointSetCurrent.h>
#include <mavros_msgs/WaypointPull.h>
#include <uav_msgs/UAVControlCommand.h>
#include <uav_msgs/TargetsInFrame.h>

#include <yaml-cpp/yaml.h>
#include <thread>
#include <mutex>

class UAVControlNode
{
public:
    UAVControlNode(ros::NodeHandle& nh);
    void run();

private:
    ros::NodeHandle nh_;
    std::string uav_id_;
    std::string prefix_;

    // MAVROS Subscribers
    ros::Subscriber state_sub_;
    ros::Subscriber battery_sub_;
    ros::Subscriber gps_sub_;
    ros::Subscriber global_pos_sub_;
    ros::Subscriber local_pos_sub_;
    ros::Subscriber velocity_sub_;

    // UAVControlCommand Subscriber
    ros::Subscriber cmd_sub_;

    // MAVROS Service Clients
    ros::ServiceClient arming_client_;
    ros::ServiceClient set_mode_client_;
    // 抛弃，需要指定海拔高度飞行，否则高度达不到。
    // ros::ServiceClient takeoff_client_;
    ros::ServiceClient land_client_;

    // Mission Service Clients
    ros::ServiceClient mission_clear_client_;
    ros::ServiceClient mission_push_client_;
    ros::ServiceClient mission_set_current_client_;
    ros::ServiceClient mission_pull_client_;
    ros::Subscriber mission_reached_sub_;

    // MAVROS Publishers
    ros::Publisher local_pos_pub_;
    ros::Publisher local_vel_pub_;

    // UAV 状态缓存
    mavros_msgs::State current_state_;
    sensor_msgs::BatteryState battery_;
    mavros_msgs::GPSRAW gps_;
    geometry_msgs::PoseStamped local_pose_;
    geometry_msgs::TwistStamped velocity_;

    // 二维码降落位姿
    ros::Subscriber aruco_pose_sub_;
    geometry_msgs::PoseStamped current_pose_;
    uav_msgs::TargetsInFrame aruco_pose_;

    bool outer_marker_found_;
    bool inner_marker_found_;


    // 航点任务状态
    bool mission_active_ = false;
    int current_waypoint_ = -1;
    int total_waypoints_ = 0;


    // 地理围栏参数
    double fence_min_x_, fence_max_x_, fence_min_y_, fence_max_y_, fence_min_z_, fence_max_z_;

    // Mission verification methods
    bool verifyMissionPull();
    bool enable_px4_params_load_;
    bool reboot_px4_set_reset_ekf_;
    std::mutex state_mutex_;

    ros::Subscriber rc_sub_;                  // RC通道订阅者
    bool rc_check_enabled_;                   // RC检测开关
    std::vector<int> initial_rc_values_;      // 初始RC通道值
    std::vector<int> current_rc_values_;      // 当前RC通道值
    bool rc_changed_;                         // RC通道变化标志
    double rc_threshold_;                     // RC变化检测阈值
    
    // 二维码引导降落
    // 降落参数
    const double DESCENT_STEP_OUT = 0.2;
    const double DESCENT_STEP_IN = 0.1;
    const double MIN_ALTITUDE = 0.1;
    const double HOVER_ALTITUDE = 0.5;
    bool use_aruco_landing_;
    bool aruco_landing_active_;
    void handleOuterMarker();
    void handleInnerMarker();
    // 二维码降落位姿
    void arucoPoseCallback(const uav_msgs::TargetsInFrame::ConstPtr& msg);
    // 回调函数
    void stateCallback(const mavros_msgs::State::ConstPtr& msg);
    void batteryCallback(const sensor_msgs::BatteryState::ConstPtr& msg);
    void gpsCallback(const mavros_msgs::GPSRAW::ConstPtr& msg);
    void localPosCallback(const geometry_msgs::PoseStamped::ConstPtr& msg);
    void velocityCallback(const geometry_msgs::TwistStamped::ConstPtr& msg);
    void uavCommandCallback(const uav_msgs::UAVControlCommand::ConstPtr& msg);
    void rcCallback(const mavros_msgs::RCIn::ConstPtr& msg); // RC回调函数
    // 核心功能
    bool checkPreArmSafety();
    bool checkInFlightSafety();
    bool isInsideFence(double x, double y, double z);
    void executeCommand(const uav_msgs::UAVControlCommand& cmd);

    // 添加航点处理函数
    bool clearMission();
    bool pushMission(const std::vector<uav_msgs::Waypoint>& waypoints);
    bool setCurrentWaypoint(int wp_index);
    bool requestMissionCount();
    void missionReachedCallback(const mavros_msgs::WaypointReached::ConstPtr& msg);

    // MAVROS操作
    bool arm();
    bool setMode(const std::string& mode);
    bool takeoff(double altitude, double yaw);
    bool land(double yaw);
    void sendPositionSetpoint(double x, double y, double z, double yaw);
    void sendVelocitySetpoint(double vx, double vy, double vz, double yaw_rate);

    // 参数加载
    void loadPX4Params(const std::string& yaml_file);
};

#endif