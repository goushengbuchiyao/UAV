#pragma once
#include <ros/ros.h>
#include <uav_msgs/UAVControlCommand.h>
#include <mavros_msgs/CommandTOL.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/SetMode.h>
#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>


class CommandDispatcher {
public:
    CommandDispatcher() = default;
    void init(ros::NodeHandle& nh, const std::string& ns);

    // execute command, returns true if dispatched OK
    bool execute(const uav_msgs::UAVControlCommand& cmd, std::string& out_reason);

private:
    ros::NodeHandle nh_;
    std::string ns_; // e.g. "/uav1"

    ros::ServiceClient takeoff_srv_;
    ros::ServiceClient land_srv_;
    ros::ServiceClient arming_srv_;
    ros::ServiceClient set_mode_srv_;

    ros::Publisher pos_pub_;
    ros::Publisher vel_pub_;

    // helper methods
    bool callTakeoff(double alt, double yaw);
    bool callLand(double yaw);
    bool publishPositionENU(double x_east, double y_north, double z_up);
    bool publishVelocityENU(double vx, double vy, double vz, double yaw_rate);
    bool callSetMode(const std::string& mode);
};
