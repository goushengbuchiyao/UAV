#ifndef RC_INPUT_H
#define RC_INPUT_H

#include <ros/ros.h>
#include <mavros_msgs/RCIn.h>
#include <mutex>

class RCInput {
public:
    RCInput();
    ~RCInput();
    
    /**
     * @brief 初始化RC输入模块
     * @param nh ROS节点句柄
     */
    void initialize(ros::NodeHandle& nh);
    
    // /**
    //  * @brief 获取指定通道的原始值 (1000-2000)
    //  * @param channel 通道号 (1-4)
    //  * @return 通道原始值
    //  */
    // int getChannelRaw(int channel) const;
    
    // /**
    //  * @brief 获取指定通道的归一化值 (-1.0 到 1.0)
    //  * @param channel 通道号 (1-4)
    //  * @return 归一化的通道值
    //  */
    // double getChannelNormalized(int channel) const;
    
    /**
     * @brief 检查指定通道的值是否有变化
     * @return 如果变化超过阈值，返回true
     */
    bool isChannelChanged() const;
    
    // /**
    //  * @brief 获取最近一次收到RC数据的时间戳
    //  * @return 时间戳
    //  */
    // ros::Time getLastReceiveTime() const;
    
    // /**
    //  * @brief 检查RC信号是否有效
    //  * @return 如果在过去的0.5秒内收到过RC数据，则返回true
    //  */
    // bool isRCSignalValid() const;
    
    // /**
    //  * @brief 检查是否有新的RC数据
    //  * @return 如果有新数据，返回true并重置标志
    //  */
    // bool hasNewData();
    
private:
    /**
     * @brief RC数据回调函数
     * @param msg RC输入消息
     */
    void rcCallback(const mavros_msgs::RCIn::ConstPtr& msg);
    
    ros::Subscriber rc_subscriber_;      // RC输入订阅者
    mutable std::mutex rc_mutex_;        // 互斥锁保护共享数据
    
    int channels_[4];                    // 1-4通道值 (1000-2000)
    // double channels_normalized_[4];      // 归一化的通道值 (-1.0 到 1.0)
    int first_channels_[4];               // 上一次的通道值，用于检测变化
    
    // double dead_zone_;                   // 死区阈值
    // double max_channel_value_;           // 通道最大值
    // double min_channel_value_;           // 通道最小值
    // double center_channel_value_;        // 通道中心值
    double rc_threshold_;                   // 通道变化检测阈值
    bool first_rc_channel_value_;        // 是否已接收到第一组RC数据
    std::string prefix_;                 // ROS命名空间前缀
    
    ros::Time last_receive_time_;        // 最后一次接收RC数据的时间戳
    bool new_data_flag_;                 // 新数据标志位
};

#endif // RC_INPUT_H