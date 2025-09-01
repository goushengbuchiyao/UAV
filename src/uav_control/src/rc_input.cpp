#include "uav_control/rc_input.h"
#include <iostream>

RCInput::RCInput() : 
    new_data_flag_(false)
{
    // 初始化通道值
    first_rc_channel_value_ = true;
    
    last_receive_time_ = ros::Time::now();
}

RCInput::~RCInput() {
    // 析构函数
}

void RCInput::initialize(ros::NodeHandle& nh) {
    // 订阅MAVROS的RC输入话题
    nh_.param<std::string>("uav_id", uav_id_, "uav1");
    prefix_ = "/" + uav_id_;
    
    // // 从参数服务器加载RC相关参数，使用默认值作为回退
    // nh_.param<double>("rc_dead_zone", dead_zone_, 0.05);
    // nh_.param<double>("rc_max_channel_value", max_channel_value_, 2000.0);
    // nh_.param<double>("rc_min_channel_value", min_channel_value_, 1000.0);
    // nh_.param<double>("rc_center_channel_value", center_channel_value_, 1000.0);
    nh_.param<double>("rc_threshold", rc_threshold_, 30.0);
    rc_subscriber_ = nh.subscribe<mavros_msgs::RCIn>(
        prefix_ + "/mavros/rc/in", 10, &RCInput::rcCallback, this);
    
    ROS_INFO("RC Input module initialized");
}

void RCInput::rcCallback(const mavros_msgs::RCIn::ConstPtr& msg) {
    std::lock_guard<std::mutex> lock(rc_mutex_);
    if (first_rc_channel_value_) {
        // 初始化通道值
        first_channels_[0] = msg->channels[0];
        first_channels_[1] = msg->channels[1];
        first_channels_[2] = msg->channels[2];
        first_channels_[3] = msg->channels[3];
        // // 将通道值归一化到0.0到1.0范围
        // double normalized_0 = (first_channels_[0] - center_channel_value_) / 1000.0;
        // double normalized_1 = (first_channels_[1] - center_channel_value_) / 1000.0;
        // double normalized_2 = (first_channels_[2] - center_channel_value_) / 1000.0;
        // double normalized_3 = (first_channels_[3] - center_channel_value_) / 1000.0;
        
        // // 应用死区处理
        // if (fabs(normalized_0) < dead_zone_) {
        //     channels_normalized_[0] = 0.0;
        // } else {
        //     // 死区外的线性映射
        //     channels_normalized_[0] = normalized_0 > 0 ? 
        //         (normalized_0 - dead_zone_) / (1.0 - dead_zone_) :
        //         (normalized_0 + dead_zone_) / (1.0 - dead_zone_);
        // }
        // if (fabs(normalized_1) < dead_zone_) {
        //     channels_normalized_[1] = 0.0;
        // } else {
        //     // 死区外的线性映射
        //     channels_normalized_[1] = normalized_1 > 0 ? 
        //         (normalized_1 - dead_zone_) / (1.0 - dead_zone_) :
        //         (normalized_1 + dead_zone_) / (1.0 - dead_zone_);
        // }
        // if (fabs(normalized_2) < dead_zone_) {
        //     channels_normalized_[2] = 0.0;
        // } else {
        //     // 死区外的线性映射
        //     channels_normalized_[2] = normalized_2 > 0 ? 
        //         (normalized_2 - dead_zone_) / (1.0 - dead_zone_) :
        //         (normalized_2 + dead_zone_) / (1.0 - dead_zone_);
        // }
        // if (fabs(normalized_3) < dead_zone_) {
        //     channels_normalized_[3] = 0.0;
        // } else {
        //     // 死区外的线性映射
        //     channels_normalized_[3] = normalized_3 > 0 ? 
        //         (normalized_3 - dead_zone_) / (1.0 - dead_zone_) :
        //         (normalized_3 + dead_zone_) / (1.0 - dead_zone_);
        // }

        first_rc_channel_value_ = false;
    } else
    {
    // 保存当前的通道值用于检测变化
        channels_[0] = msg->channels[0];
        channels_[1] = msg->channels[1];
        channels_[2] = msg->channels[2];
        channels_[3] = msg->channels[3];
        
        // // 将通道值归一化到0.0到1.0范围
        // double normalized = (channels_[i] - center_channel_value_) / 1000.0;
        
        // // 应用死区处理
        // if (fabs(normalized) < dead_zone_) {
        //     channels_normalized_[i] = 0.0;
        // } else {
        //     // 死区外的线性映射
        //     channels_normalized_[i] = normalized > 0 ? 
        //         (normalized - dead_zone_) / (1.0 - dead_zone_) :
        //         (normalized + dead_zone_) / (1.0 - dead_zone_);
        // }
        // if 
        new_data_flag_ = true;
        last_receive_time_ = ros::Time::now();
    }
    
}

int RCInput::getChannelRaw(int channel) const {
    if (channel < 1 || channel > 4) {
        ROS_WARN("Invalid RC channel: %d (must be 1-4)", channel);
        return 1500;  // 返回中心值作为默认值
    }
    
    std::lock_guard<std::mutex> lock(rc_mutex_);
    return channels_[channel - 1];
}

double RCInput::getChannelNormalized(int channel) const {
    if (channel < 1 || channel > 4) {
        ROS_WARN("Invalid RC channel: %d (must be 1-4)", channel);
        return 0.0;
    }
    
    std::lock_guard<std::mutex> lock(rc_mutex_);
    return channels_normalized_[channel - 1];
}

bool RCInput::isChannelChanged() const {
    std::lock_guard<std::mutex> lock(rc_mutex_);
    // 检查通道变化

    if (fabs(first_channels_[0] - channels_[0]) > rc_threshold_) {
        return true;
    }
    if (fabs(first_channels_[1] - channels_[1]) > rc_threshold_) {
        return true;
    }
    if (fabs(first_channels_[2] - channels_[2]) > rc_threshold_) {
        return true;
    }
    if (fabs(first_channels_[3] - channels_[3]) > rc_threshold_) {
        return true;
    }
    
    return false;
}

ros::Time RCInput::getLastReceiveTime() const {
    std::lock_guard<std::mutex> lock(rc_mutex_);
    return last_receive_time_;
}

bool RCInput::isRCSignalValid() const {
    std::lock_guard<std::mutex> lock(rc_mutex_);
    // 检查是否在过去的0.5秒内收到过RC数据
    return (ros::Time::now() - last_receive_time_).toSec() < 0.5;
}

bool RCInput::hasNewData() {
    std::lock_guard<std::mutex> lock(rc_mutex_);
    bool result = new_data_flag_;
    new_data_flag_ = false;  // 重置标志
    return result;
}