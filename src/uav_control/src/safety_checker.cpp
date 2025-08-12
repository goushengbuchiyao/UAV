#include "uav_control/safety_checker.h"
#include <ros/ros.h>

SafetyChecker::SafetyChecker(ros::NodeHandle& nh) : nh_(nh), got_battery_(false), got_gps_(false), got_rc_(false), got_odom_(false) {
    nh_.param("geofence_center_lat", geofence_center_lat_, 0.0);
    nh_.param("geofence_center_lon", geofence_center_lon_, 0.0);
    nh_.param("geofence_radius_m", geofence_radius_m_, 1000.0);
    nh_.param("min_battery_pct", min_battery_pct_, 20.0);
    nh_.param("odom_timeout", odom_timeout_, 1.0);
    nh_.param("rc_timeout", rc_timeout_, 2.0);

    battery_sub_ = nh_.subscribe("/mavros/battery", 1, &SafetyChecker::batteryCallback, this);
    gps_sub_ = nh_.subscribe("/mavros/global_position/global", 1, &SafetyChecker::gpsCallback, this);
    rc_sub_ = nh_.subscribe("/mavros/rc/in", 1, &SafetyChecker::rcCallback, this);
    odom_sub_ = nh_.subscribe("/mavros/local_position/odom", 1, &SafetyChecker::odomCallback, this);
}

void SafetyChecker::batteryCallback(const mavros_msgs::BatteryStatus::ConstPtr& msg) {
    last_battery_ = *msg;
    got_battery_ = true;
}

void SafetyChecker::gpsCallback(const sensor_msgs::NavSatFix::ConstPtr& msg) {
    last_gps_ = *msg;
    got_gps_ = true;
}

void SafetyChecker::rcCallback(const mavros_msgs::RCIn::ConstPtr& msg) {
    last_rc_time_ = ros::Time::now();
    got_rc_ = true;
}

void SafetyChecker::odomCallback(const uav_msgs::Odometry::ConstPtr& msg) {
    last_odom_time_ = ros::Time::now();
    got_odom_ = true;
}

int SafetyChecker::checkBattery() {
    if (!got_battery_) return 0; // 没有数据，不拦截

    double pct = 0.0;
    if (last_battery_.capacity > 0.0) {
        pct = (last_battery_.remaining / last_battery_.capacity) * 100.0;
    }

    if (pct < min_battery_pct_) {
        ROS_WARN("Battery low: %.1f%% < %.1f%%", pct, min_battery_pct_);
        return 4; // 电池低电量
    }
    return 0;
}

int SafetyChecker::checkGeofence() {
    if (geofence_center_lat_ == 0.0 && geofence_center_lon_ == 0.0) {
        return 0; // 不启用围栏检查
    }
    if (!got_gps_) return 0;

    double dist = haversineDistance(geofence_center_lat_, geofence_center_lon_,
                                    last_gps_.latitude, last_gps_.longitude);
    if (dist > geofence_radius_m_) {
        ROS_WARN("Geofence breach: distance=%.2f m > %.2f m", dist, geofence_radius_m_);
        return 1;
    }
    return 0;
}

int SafetyChecker::checkOdom() {
    if (!got_odom_) return 0;
    if ((ros::Time::now() - last_odom_time_).toSec() > odom_timeout_) {
        ROS_WARN("Odom data timeout!");
        return 2;
    }
    return 0;
}

int SafetyChecker::checkRC() {
    if (!got_rc_) return 0;
    if ((ros::Time::now() - last_rc_time_).toSec() > rc_timeout_) {
        ROS_WARN("RC signal lost!");
        return 3;
    }
    return 0;
}

int SafetyChecker::performAllChecks() {
    int ret;
    if ((ret = checkGeofence()) != 0) return ret;
    if ((ret = checkBattery()) != 0) return ret;
    if ((ret = checkOdom()) != 0) return ret;
    if ((ret = checkRC()) != 0) return ret;
    return 0;
}

double SafetyChecker::haversineDistance(double lat1, double lon1, double lat2, double lon2) {
    double R = 6371000.0; // 地球半径，米
    double dLat = (lat2 - lat1) * M_PI / 180.0;
    double dLon = (lon2 - lon1) * M_PI / 180.0;
    double a = sin(dLat / 2) * sin(dLat / 2) +
               cos(lat1 * M_PI / 180.0) * cos(lat2 * M_PI / 180.0) *
               sin(dLon / 2) * sin(dLon / 2);
    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return R * c;
}
