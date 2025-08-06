#include "uav_state_publisher.h"
#include <cmath>

UAVStatePublisher::UAVStatePublisher(ros::NodeHandle& nh, mqtt_bridge::MqttClient& mqtt_client)
    : nh_(nh), mqtt_client_(mqtt_client) {
    
    // 从参数服务器获取MQTT话题，默认使用uav1/flight_controller/state
    nh_.param<std::string>("uav_state_mqtt_topic", mqtt_topic_, "uav1/flight_controller/state");
    
    // 订阅各个话题
    std::string uav_name;
    nh_.param<std::string>("uav_name", uav_name, "/uav1");
    
    state_sub_ = nh_.subscribe<mavros_msgs::State>(
        uav_name + "/mavros/state", 10, &UAVStatePublisher::state_cb, this);
    
    battery_sub_ = nh_.subscribe<sensor_msgs::BatteryState>(
        uav_name + "/mavros/battery", 10, &UAVStatePublisher::battery_cb, this);
    
    gps_sub_ = nh_.subscribe<sensor_msgs::NavSatFix>(
        uav_name + "/mavros/global_position/global", 10, &UAVStatePublisher::gps_cb, this);
    
    gps_raw_sub_ = nh_.subscribe<mavros_msgs::GPSRAW>(
        uav_name + "/mavros/global_position/raw/gps", 10, &UAVStatePublisher::gps_raw_cb, this);
    
    local_pos_sub_ = nh_.subscribe<geometry_msgs::PoseStamped>(
        uav_name + "/mavros/local_position/pose", 10, &UAVStatePublisher::local_pos_cb, this);
    
    velocity_sub_ = nh_.subscribe<geometry_msgs::TwistStamped>(
        uav_name + "/mavros/local_position/velocity_local", 10, &UAVStatePublisher::velocity_cb, this);
    
    // 设置发布定时器，10Hz
    publish_timer_ = nh_.createTimer(ros::Duration(0.1), &UAVStatePublisher::publish_timer_cb, this);
    
    ROS_INFO("UAV state publisher initialized, MQTT topic: %s", mqtt_topic_.c_str());
}

void UAVStatePublisher::state_cb(const mavros_msgs::State::ConstPtr& msg) {
    uav_data_.flight_mode = msg->mode;
}

void UAVStatePublisher::battery_cb(const sensor_msgs::BatteryState::ConstPtr& msg) {
    uav_data_.battery_percentage = msg->percentage * 100.0f;
}

void UAVStatePublisher::gps_cb(const sensor_msgs::NavSatFix::ConstPtr& msg) {
    uav_data_.gps_latitude = msg->latitude;
    uav_data_.gps_longitude = msg->longitude;
    uav_data_.gps_altitude = msg->altitude;
    uav_data_.gps_fix_type = msg->status.status;
}

void UAVStatePublisher::gps_raw_cb(const mavros_msgs::GPSRAW::ConstPtr& msg) {
    uav_data_.gps_satellite_count = msg->satellites_visible;
}

void UAVStatePublisher::local_pos_cb(const geometry_msgs::PoseStamped::ConstPtr& msg) {
    uav_data_.local_x = msg->pose.position.x;
    uav_data_.local_y = msg->pose.position.y;
    uav_data_.local_z = msg->pose.position.z;
    
    // 转换为NED坐标系(ENU到NED的转换)
    uav_data_.ned_x = msg->pose.position.x;
    uav_data_.ned_y = -msg->pose.position.y;
    uav_data_.ned_z = -msg->pose.position.z;
    
    // 提取姿态信息
    tf::Quaternion quat(
        msg->pose.orientation.x,
        msg->pose.orientation.y,
        msg->pose.orientation.z,
        msg->pose.orientation.w
    );
    double roll, pitch, yaw;
    tf::Matrix3x3(quat).getRPY(roll, pitch, yaw);
    uav_data_.attitude_roll = static_cast<float>(roll);
    uav_data_.attitude_pitch = static_cast<float>(pitch);
    uav_data_.attitude_yaw = static_cast<float>(yaw);
}

void UAVStatePublisher::velocity_cb(const geometry_msgs::TwistStamped::ConstPtr& msg) {
    uav_data_.vel_x = msg->twist.linear.x;
    uav_data_.vel_y = msg->twist.linear.y;
    uav_data_.vel_z = msg->twist.linear.z;
}

std::string UAVStatePublisher::convert_to_json(const UAVData& data) {
    Json::Value root;
    
    // 基本状态
    root["flight_mode"] = data.flight_mode;
    root["battery_percentage"] = data.battery_percentage;
    
    // GPS信息
    root["gps"]["latitude"] = data.gps_latitude;
    root["gps"]["longitude"] = data.gps_longitude;
    root["gps"]["altitude"] = data.gps_altitude;
    root["gps"]["fix_type"] = data.gps_fix_type;
    root["gps"]["satellite_count"] = data.gps_satellite_count;
    
    // 位置信息
    root["position"]["local"]["x"] = data.local_x;
    root["position"]["local"]["y"] = data.local_y;
    root["position"]["local"]["z"] = data.local_z;
    
    root["position"]["ned"]["x"] = data.ned_x;
    root["position"]["ned"]["y"] = data.ned_y;
    root["position"]["ned"]["z"] = data.ned_z;
    
    // 速度信息
    root["velocity"]["x"] = data.vel_x;
    root["velocity"]["y"] = data.vel_y;
    root["velocity"]["z"] = data.vel_z;
    
    // 姿态信息(转换为度)
    root["attitude"]["roll_deg"] = data.attitude_roll * 180.0 / M_PI;
    root["attitude"]["pitch_deg"] = data.attitude_pitch * 180.0 / M_PI;
    root["attitude"]["yaw_deg"] = data.attitude_yaw * 180.0 / M_PI;
    
    // 添加时间戳
    root["timestamp"] = ros::Time::now().toSec();
    
    
    Json::FastWriter writer;
    return writer.write(root);
}

void UAVStatePublisher::publish_timer_cb(const ros::TimerEvent& event) {
    if (mqtt_client_.isConnected()) {
        std::string json_data = convert_to_json(uav_data_);
        mqtt_client_.publish(mqtt_topic_, json_data);
        ROS_DEBUG("Published UAV state to MQTT: %s", json_data.c_str());
    } else {
        ROS_WARN_THROTTLE(5, "MQTT not connected, cannot publish UAV state");
    }
}