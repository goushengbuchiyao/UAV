#include "uav_control/uav_control_node.h"

UAVControlNode::UAVControlNode(ros::NodeHandle& pnh)
    : pnh_(pnh), nh_(), safety_checker_(pnh) {

    std::string cmd_topic;
    pnh_.param<std::string>("ros_command_topic", cmd_topic, "/mqtt_bridge/uav1/ros/uavcontrol/command");
    pnh_.param<double>("offboard_rate", offboard_rate_, 20.0);

    cmd_sub_ = nh_.subscribe(cmd_topic, 10, &UAVControlNode::cmdCallback, this);

    local_pos_pub_ = nh_.advertise<geometry_msgs::PoseStamped>("/mavros/setpoint_position/local", 10);
    vel_pub_ = nh_.advertise<geometry_msgs::TwistStamped>("/mavros/setpoint_velocity/cmd_vel", 10);

    arming_client_ = nh_.serviceClient<mavros_msgs::CommandBool>("/mavros/cmd/arming");
    set_mode_client_ = nh_.serviceClient<mavros_msgs::SetMode>("/mavros/set_mode");
    takeoff_client_ = nh_.serviceClient<mavros_msgs::CommandTOL>("/mavros/cmd/takeoff");
    land_client_ = nh_.serviceClient<mavros_msgs::CommandTOL>("/mavros/cmd/land");

    ROS_INFO("UAV Control Node initialized");
}

bool UAVControlNode::performSafetyCheck() {
    if (safety_checker_.checkGeofence(
            safety_checker_.last_gps_.latitude,
            safety_checker_.last_gps_.longitude) != 0) return false;
    if (safety_checker_.checkOdom() != 0) return false;
    if (safety_checker_.checkRC() != 0) return false;
    if (safety_checker_.checkBattery() != 0) return false;
    return true;
}

bool UAVControlNode::arm(bool arm_it) {
    mavros_msgs::CommandBool arm_cmd;
    arm_cmd.request.value = arm_it;
    return arming_client_.call(arm_cmd) && arm_cmd.response.success;
}

bool UAVControlNode::setMode(const std::string& mode) {
    mavros_msgs::SetMode mode_cmd;
    mode_cmd.request.custom_mode = mode;
    return set_mode_client_.call(mode_cmd) && mode_cmd.response.mode_sent;
}

bool UAVControlNode::takeoff(double alt, double yaw) {
    mavros_msgs::CommandTOL cmd;
    cmd.request.altitude = alt;
    cmd.request.yaw = yaw;
    return takeoff_client_.call(cmd) && cmd.response.success;
}

bool UAVControlNode::land(double yaw) {
    mavros_msgs::CommandTOL cmd;
    cmd.request.yaw = yaw;
    return land_client_.call(cmd) && cmd.response.success;
}

void UAVControlNode::cmdCallback(const uav_msgs::UAVControlCommand::ConstPtr& msg) {
    if (!performSafetyCheck()) {
        ROS_ERROR("Safety check failed, aborting command");
        return;
    }

    ROS_INFO("Executing command: %s", msg->command_type.c_str());

    if (msg->command_type == "takeoff") {
        setMode("OFFBOARD");
        arm(true);
        takeoff(msg->takeoff.altitude, msg->takeoff.yaw);
    }
    else if (msg->command_type == "land") {
        setMode("AUTO.LAND");
        land(msg->land.yaw);
    }
    else if (msg->command_type == "position_control_ned") {
        geometry_msgs::PoseStamped pose;
        pose.header.stamp = ros::Time::now();
        pose.pose.position.x = msg->pos_ned.x;
        pose.pose.position.y = msg->pos_ned.y;
        pose.pose.position.z = -msg->pos_ned.z; // NED 下方向为正，这里取反
        local_pos_pub_.publish(pose);
    }
    else if (msg->command_type == "velocity_control_ned") {
        geometry_msgs::TwistStamped vel;
        vel.header.stamp = ros::Time::now();
        vel.twist.linear.x = msg->vel_ned.vx;
        vel.twist.linear.y = msg->vel_ned.vy;
        vel.twist.linear.z = msg->vel_ned.vz;
        vel_pub_.publish(vel);
    }
    else if (msg->command_type == "set_mode") {
        setMode(msg->set_mode.mode);
    }
    else if (msg->command_type == "return_to_launch") {
        setMode("AUTO.RTL");
    }
    else if (msg->command_type == "hover") {
        setMode(msg->hover.mode);
    }
}

void UAVControlNode::run() {
    ros::Rate rate(offboard_rate_);
    while (ros::ok()) {
        ros::spinOnce();
        rate.sleep();
    }
}
