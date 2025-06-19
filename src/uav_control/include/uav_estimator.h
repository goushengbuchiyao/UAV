#ifndef UAV_ESTIMATOR_H
#define UAV_ESTIMATOR_H

// 头文件
#include <ros/ros.h>
#include <iostream>
#include <bitset>
#include <Eigen/Eigen>
#include <mavros/frame_tf.h>
#include <GeographicLib/Geocentric.hpp>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <px_uav_msgs/UAVState.h>
#include <px_uav_msgs/TextInfo.h>
#include <px_uav_msgs/OffsetPose.h>
#include <px_uav_msgs/GPSData.h>
#include <px_uav_msgs/LinktrackNodeframe2.h>
#include <px_uav_msgs/LinktrackNode2.h>
#include <px_uav_msgs/ParamSettings.h>

#include <mavros_msgs/State.h>
#include <mavros_msgs/GPSRAW.h>
#include <mavros_msgs/PositionTarget.h>
#include <sensor_msgs/BatteryState.h>
#include <sensor_msgs/Range.h>

#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <geometry_msgs/TransformStamped.h>
#include <visualization_msgs/Marker.h>

#include <sensor_msgs/Imu.h>
#include <sensor_msgs/NavSatFix.h>
#include <nav_msgs/Odometry.h>
#include <nav_msgs/Path.h>
#include <std_msgs/Float64.h>
#include <std_msgs/UInt32.h>

#include "tf2_ros/transform_broadcaster.h"  //发布动态坐标关系
#include "math_utils.h"
#include "printf_utils.h"


using namespace std;

// 宏定义
#define TRA_WINDOW 40                // 发布轨迹长度
#define MOCAP_TIMEOUT 0.35                 
#define GAZEBO_TIMEOUT 1.1                    
#define T265_TIMEOUT 0.3
#define VIOBOT_TIMEOUT 0.3
#define MID360_TIMEOUT 1.0
#define UWB_TIMEOUT 0.1
#define GPS_TIMEOUT 1.0
#define VINS_TIMEOUT 0.35
#define BSA_SLAM_TIMEOUT 0.3

// 传感器相对于飞控(base_link)的位置偏移量、姿态偏移量
struct Sensor_TF_Offset
{
    // 位置偏移量
    float x;
    float y;
    float z;
    // 姿态偏移量
    float roll;
    float pitch;
    float yaw;
};

class UAV_estimator
{
    public:
        UAV_estimator(ros::NodeHandle& nh);

        // 订阅话题
        ros::Subscriber px4_state_sub;
        ros::Subscriber px4_battery_sub;
        ros::Subscriber px4_position_sub;
        ros::Subscriber px4_velocity_sub;
        ros::Subscriber px4_attitude_sub;
        ros::Subscriber px4_range_sub;
        ros::Subscriber mocap_sub;
        ros::Subscriber t265_sub;
        ros::Subscriber viobot_sub;
        ros::Subscriber mid360_sub;
        ros::Subscriber gazebo_sub;
        ros::Subscriber uwb_sub;
        ros::Subscriber vins_sub;
        ros::Subscriber fake_odom_sub;
        ros::Subscriber px4_global_position_sub;
        ros::Subscriber px4_rel_alt_sub;
        ros::Subscriber gps_status_sub;
        ros::Subscriber set_local_pose_offset_sub;
        ros::Subscriber gps_satellites_sub;
        ros::Subscriber BSA_SLAM_sub;
        // 地面站参数修改话题
        ros::Subscriber ros_param_set_sub;
        // 发布话题
        ros::Publisher uav_state_pub;
        ros::Publisher px4_vision_pose_pub;
        ros::Publisher uav_odom_pub;
        ros::Publisher camera_odom_pub;
        ros::Publisher uav_trajectory_pub;
        ros::Publisher uav_mesh_pub;
        ros::Publisher gps_status_pub;
        ros::Publisher ground_station_info_pub;
        ros::Publisher local_pose_offset_pub;
        // 定时器
        ros::Timer timer_px4_vision_pub;
        ros::Timer timer_uav_state_pub;
        ros::Timer timer_rviz_pub;
        ros::Timer ground_station_info_timer;

        px_uav_msgs::UAVState uav_state;    // 无人机状态
        nav_msgs::Odometry uav_odom;                 // 无人机里程计
        nav_msgs::Odometry camera_odom;                 // 相机(d435i)里程计
        std::vector<geometry_msgs::PoseStamped> pos_vector;    // 无人机轨迹容器,用于rviz显示
        geometry_msgs::PoseStamped vision_pose;        // vision_pose for px4
        px_uav_msgs::TextInfo text_info;
        px_uav_msgs::TextInfo last_text_info;
        px_uav_msgs::OffsetPose offset_pose;

        ros::NodeHandle nh;

        Sensor_TF_Offset d435i_offset;
        Sensor_TF_Offset lidar_offset;
        Sensor_TF_Offset t265_offset;
        Sensor_TF_Offset uwb_offset;
        Sensor_TF_Offset BSA_SLAM_offset;
        int j=0;

        geometry_msgs::PoseStamped mocap_pose;         // mocap pose
        geometry_msgs::PoseStamped gazebo_pose;        // gazebo pose
        geometry_msgs::PoseStamped t265_pose;          // t265 pose
        geometry_msgs::PoseStamped BSA_SLAM_pose;          // BSA_SLAM pose
        geometry_msgs::PoseStamped viobot_pose;         // viobot pose
        geometry_msgs::PoseStamped mid360_pose;          // mid360 pose
        // geometry_msgs::PoseStamped uwb_pose;           // uwb pose
        geometry_msgs::PoseStamped vins_pose;           // vins pose
        //---------------------------------------UWB定位相关------------------------------------------
        Eigen::Vector3d pos_drone_uwb; //无人机当前位置 (UWB)
        Eigen::Quaterniond q_uwb;
        Eigen::Vector3d Euler_uwb; //无人机当前姿态 (UWB)

        Eigen::Quaterniond q_viobot;
        Eigen::Vector3d Euler_viobot; //无人机当前姿态 (viobot)

        Eigen::Vector3d last_pos_vision;


        int odom_state,last_odom_state{10};

        
        ros::Time get_mocap_stamp{0};
        ros::Time get_gazebo_stamp{0};
        ros::Time get_t265_stamp{0};
        ros::Time get_viobot_stamp{0};
        ros::Time get_mid360_stamp{0};
        ros::Time get_uwb_stamp{0};
        ros::Time get_gps_stamp{0};
        ros::Time get_vins_stamp{0};
        ros::Time get_BSA_SLAM_stamp{0};

        // 基本变量
        int uav_id;                   // 无人机编号
        string uav_name;                // 无人机名字
        string node_name;
        int location_source;    
        float maximum_safe_vel_xy;
        float maximum_safe_vel_z;
        float maximum_vel_error_for_vision;
        float maximum_vel_error_for_Odom;
        int last_gps_status;
        bool fake_odom;                 // Gazebo是否使用fake_odom
        bool uav_state_update{false};
        bool vision_pose_error{false};
        bool Odom_pose_error{false};
        bool odom_first_check{true};

        bool covariance_error{false};      // 协方差异常标志 (true=异常, false=正常)

        boost::array<double, 36> pose_cov;
        boost::array<double, 36> twist_cov;

        void printf_uav_state();

    private:

        void mocap_cb(const geometry_msgs::PoseStamped::ConstPtr &msg);
        void gazebo_cb(const nav_msgs::Odometry::ConstPtr &msg);
        void uwb_cb(const px_uav_msgs::LinktrackNodeframe2::ConstPtr &msg);
        void fake_odom_cb(const nav_msgs::Odometry::ConstPtr &msg);
        void t265_cb(const nav_msgs::Odometry::ConstPtr &msg);
        void BSA_SLAM_cb(const nav_msgs::Odometry::ConstPtr &msg);
        void viobot_cb(const nav_msgs::Odometry::ConstPtr &msg);
        void mid360_cb(const nav_msgs::Odometry::ConstPtr &msg);
        void vins_cb(const geometry_msgs::PoseStamped::ConstPtr &msg);
        void px4_state_cb(const mavros_msgs::State::ConstPtr &msg);
        void px4_battery_cb(const sensor_msgs::BatteryState::ConstPtr &msg);
        void px4_range_cb(const sensor_msgs::Range::ConstPtr &msg);
        void px4_global_pos_cb(const sensor_msgs::NavSatFix::ConstPtr &msg);
        void px4_global_rel_alt_cb(const std_msgs::Float64::ConstPtr &msg);
        void px4_pos_cb(const geometry_msgs::PoseStamped::ConstPtr &msg);
        void px4_vel_cb(const geometry_msgs::TwistStamped::ConstPtr &msg);
        void px4_att_cb(const sensor_msgs::Imu::ConstPtr& msg);
        void gps_status_cb(const mavros_msgs::GPSRAW::ConstPtr& msg);
        void set_local_pose_offset_cb(const px_uav_msgs::GPSData::ConstPtr& msg);
        void gps_satellites_cb(const std_msgs::UInt32::ConstPtr &msg);
        void param_set_cb(const px_uav_msgs::ParamSettings::ConstPtr &msg);

        void timercb_pub_vision_pose(const ros::TimerEvent &e);
        void timercb_pub_uav_state(const ros::TimerEvent &e);
        void timercb_rviz(const ros::TimerEvent &e);
        void sendStationTextInfo(const ros::TimerEvent &e);
        void check_uav_state();
        int check_uav_odom();
        
        void printf_gps_status();
        void printf_param();

        void switch_location_source(int old_location_source, int new_location_source);
};


#endif
