#pragma once

#include <ros/ros.h>

namespace uav_control {

class SafetyChecker {
public:
    SafetyChecker(ros::NodeHandle& nh);

    // 起飞前安全检查
    bool checkPreTakeoff(); 

    // 飞行中安全检查
    bool checkInFlight();    

    // 更新状态信息
    void updateBatteryStatus(float percentage);
    void updatePosition(double x, double y, double z);
    void updateRCStatus(bool connected);

private:
    float battery_percentage_ = 100.0;
    double pos_x_, pos_y_, pos_z_;
    bool rc_connected_ = true;

    // 地理围栏参数
    double geo_x_min_, geo_x_max_, geo_y_min_, geo_y_max_, geo_z_min_, geo_z_max_;
};

} // namespace uav_control
