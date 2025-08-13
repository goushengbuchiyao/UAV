#include "uav_control/safety_checker.h"

namespace uav_control {

SafetyChecker::SafetyChecker(ros::NodeHandle& nh) {
    nh.param("geo_fence/x_min", geo_x_min_, -100.0);
    nh.param("geo_fence/x_max", geo_x_max_, 100.0);
    nh.param("geo_fence/y_min", geo_y_min_, -100.0);
    nh.param("geo_fence/y_max", geo_y_max_, 100.0);
    nh.param("geo_fence/z_min", geo_z_min_, -0.5);
    nh.param("geo_fence/z_max", geo_z_max_, 100.0);
}

bool SafetyChecker::checkPreTakeoff() {
    if (battery_percentage_ < 30.0) {
        ROS_WARN("电池电量低，无法起飞");
        return false;
    }
    if (pos_x_ < geo_x_min_ || pos_x_ > geo_x_max_ ||
        pos_y_ < geo_y_min_ || pos_y_ > geo_y_max_ ||
        pos_z_ < geo_z_min_ || pos_z_ > geo_z_max_) {
        ROS_WARN("当前位置超出地理围栏，无法起飞");
        return false;
    }
    if (!rc_connected_) {
        ROS_WARN("遥控器未连接，无法起飞");
        return false;
    }
    return true;
}

bool SafetyChecker::checkInFlight() {
    // 飞行中安全检查可扩展
    return checkPreTakeoff();
}

void SafetyChecker::updateBatteryStatus(float percentage) {
    battery_percentage_ = percentage;
}

void SafetyChecker::updatePosition(double x, double y, double z) {
    pos_x_ = x;
    pos_y_ = y;
    pos_z_ = z;
}

void SafetyChecker::updateRCStatus(bool connected) {
    rc_connected_ = connected;
}

} // namespace uav_control
