#ifndef UAV_CONTROL_NODE_H
#define UAV_CONTROL_NODE_H

#include <ros/ros.h>
#include "uav_control/safety_checker.h"
#include "uav_msgs/UAVControlCommand.h"

#include <geometry_msgs/PoseStamped.h>
#include <geometry_msgs/TwistStamped.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/CommandTOL.h>

class UAVControlNode {
public:
    UAVControlNode(ros::NodeHandle& pnh);
    void run();

private:
    void cmdCallback(const uav_msgs::UAVControlCommand::ConstPtr& msg);
    bool performSafetyCheck();

    bool arm(bool arm);
    bool setMode(const std::string& mode);
    bool takeoff(double alt, double yaw);
    bool land(double yaw);

    ros::NodeHandle pnh_;
    ros::NodeHandle nh_;
    SafetyChecker safety_checker_;

    ros::Subscriber cmd_sub_;
    ros::Publisher local_pos_pub_;
    ros::Publisher vel_pub_;

    ros::ServiceClient arming_client_;
    ros::ServiceClient set_mode_client_;
    ros::ServiceClient takeoff_client_;
    ros::ServiceClient land_client_;

    double offboard_rate_;
};

#endif
