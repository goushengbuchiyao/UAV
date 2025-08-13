#include "uav_control/px4_param_loader.h"

namespace uav_control {

PX4ParamLoader::PX4ParamLoader(ros::NodeHandle& nh) : nh_(nh) {
    nh_.param("reboot_px4_set_reset_ekf", reboot_px4_set_reset_ekf_, false);
}

bool PX4ParamLoader::loadParameters() {
    ROS_INFO("加载PX4参数到飞控...");
    // TODO: 实际调用 MAVROS param/set 服务
    return true; // 模拟成功
}

bool PX4ParamLoader::rebootWithResetEKF(bool enable) {
    ROS_INFO("重启PX4, reset EKF: %s", enable ? "true" : "false");
    // TODO: 调用 MAVROS param/set 或 reboot 服务
    return true;
}

} // namespace uav_control
