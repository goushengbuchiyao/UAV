#pragma once

#include <ros/ros.h>

namespace uav_control {

class PX4ParamLoader {
public:
    PX4ParamLoader(ros::NodeHandle& nh);

    // 加载PX4参数到飞控
    bool loadParameters();  

    // 重启PX4并选择是否重置EKF
    bool rebootWithResetEKF(bool enable);

private:
    ros::NodeHandle nh_;
    bool reboot_px4_set_reset_ekf_;
};

} // namespace uav_control
