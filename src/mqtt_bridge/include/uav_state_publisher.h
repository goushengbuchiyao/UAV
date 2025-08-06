#ifndef UAV_STATE_PUBLISHER_H
#define UAV_STATE_PUBLISHER_H

#include <ros/ros.h>
#include <mavros_msgs/State.h>
#include <sensor_msgs/BatteryState.h>
#include <sensor_msgs/NavSatFix.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <mavros_msgs/GPSRAW.h>
#include <tf/transform_datatypes.h>
#include "mqtt_client.h"
#include "jsoncpp/json/json.h"

// 无人机状态数据结构
struct UAVData {
    std::string flight_mode;          // 飞行模式
    float battery_percentage;        // 电池电量百分比
    double gps_latitude;             // GPS纬度
    double gps_longitude;            // GPS经度
    double gps_altitude;             // GPS高度
    float local_x;                   // 本地坐标系X
    float local_y;                   // 本地坐标系Y
    float local_z;                   // 本地坐标系Z
    float ned_x;                     // NED坐标系X(北)
    float ned_y;                     // NED坐标系Y(东)
    float ned_z;                     // NED坐标系Z(地)
    float vel_x;                     // X方向速度
    float vel_y;                     // Y方向速度
    float vel_z;                     // Z方向速度
    int gps_fix_type;                // GPS信号状态
    int gps_satellite_count;         // GPS卫星数量
    float attitude_roll;             // 横滚角(弧度)
    float attitude_pitch;            // 俯仰角(弧度)
    float attitude_yaw;              // 偏航角(弧度)
};

class UAVStatePublisher {
public:
    UAVStatePublisher(ros::NodeHandle& nh, mqtt_bridge::MqttClient& mqtt_client);
    ~UAVStatePublisher() = default;

private:
    void state_cb(const mavros_msgs::State::ConstPtr& msg);
    void battery_cb(const sensor_msgs::BatteryState::ConstPtr& msg);
    void gps_cb(const sensor_msgs::NavSatFix::ConstPtr& msg);
    void gps_raw_cb(const mavros_msgs::GPSRAW::ConstPtr& msg);
    void local_pos_cb(const geometry_msgs::PoseStamped::ConstPtr& msg);
    void velocity_cb(const geometry_msgs::TwistStamped::ConstPtr& msg);
    void publish_timer_cb(const ros::TimerEvent& event);
    std::string convert_to_json(const UAVData& data);

    ros::NodeHandle nh_;
    mqtt_bridge::MqttClient& mqtt_client_;
    std::string mqtt_topic_;
    UAVData uav_data_;
    ros::Timer publish_timer_;
    
    // ROS订阅者
    ros::Subscriber state_sub_;
    ros::Subscriber battery_sub_;
    ros::Subscriber gps_sub_;
    ros::Subscriber gps_raw_sub_;
    ros::Subscriber local_pos_sub_;
    ros::Subscriber velocity_sub_;
};

#endif // UAV_STATE_PUBLISHER_H