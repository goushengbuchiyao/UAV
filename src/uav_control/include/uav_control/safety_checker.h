#ifndef UAV_CONTROL_SAFETY_CHECKER_H
#define UAV_CONTROL_SAFETY_CHECKER_H

#include <ros/ros.h>
#include <sensor_msgs/NavSatFix.h>
#include <mavros_msgs/RCIn.h>
#include <mavros_msgs/BatteryStatus.h>
#include <geometry_msgs/PoseStamped.h>

class SafetyChecker {
public:
    SafetyChecker(ros::NodeHandle& nh);

    int checkGeofence(double lat, double lon);
    int checkOdom();
    int checkRC();
    int checkBattery();

    void batteryCallback(const mavros_msgs::BatteryStatus::ConstPtr& msg);
    void gpsCallback(const sensor_msgs::NavSatFix::ConstPtr& msg);
    void odomCallback(const geometry_msgs::PoseStamped::ConstPtr& msg);
    void rcCallback(const mavros_msgs::RCIn::ConstPtr& msg);

private:
    double haversine(double lat1, double lon1, double lat2, double lon2);

    ros::NodeHandle nh_;
    ros::Subscriber battery_sub_;
    ros::Subscriber gps_sub_;
    ros::Subscriber odom_sub_;
    ros::Subscriber rc_sub_;

    mavros_msgs::BatteryStatus last_battery_;
    sensor_msgs::NavSatFix last_gps_;
    ros::Time last_odom_time_;
    ros::Time last_rc_time_;

    // 添加电池状态接收标志
    bool got_battery_;
    bool got_gps_;
    bool got_rc_;
    bool got_odom_;
    double geofence_center_lat_;
    double geofence_center_lon_;
    double geofence_radius_m_;
    double min_battery_pct_;
    double odom_timeout_;
    double rc_timeout_;
};

#endif
