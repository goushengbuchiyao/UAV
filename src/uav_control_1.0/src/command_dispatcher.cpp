#include "uav_control/command_dispatcher.h"
#include <string>
#include <uav_msgs/UAVControlCommand.h>

void CommandDispatcher::init(ros::NodeHandle& nh, const std::string& ns) {
    nh_ = nh;
    ns_ = ns;
    std::string svc_prefix = ns_.empty() ? "/" : ns_;

    takeoff_srv_ = nh_.serviceClient<mavros_msgs::CommandTOL>(svc_prefix + "mavros/cmd/takeoff");
    land_srv_ = nh_.serviceClient<mavros_msgs::CommandTOL>(svc_prefix + "mavros/cmd/land");
    arming_srv_ = nh_.serviceClient<mavros_msgs::CommandBool>(svc_prefix + "mavros/cmd/arming");
    set_mode_srv_ = nh_.serviceClient<mavros_msgs::SetMode>(svc_prefix + "mavros/set_mode");

    pos_pub_ = nh_.advertise<geometry_msgs::PoseStamped>(svc_prefix + "mavros/setpoint_position/local", 10);
    vel_pub_ = nh_.advertise<geometry_msgs::TwistStamped>(svc_prefix + "mavros/setpoint_velocity/cmd_vel", 10);
}

bool CommandDispatcher::execute(const uav_msgs::UAVControlCommand& cmd, std::string& out_reason) {
    try {
        if (cmd.command_type == "takeoff") {
            ROS_INFO("++++++++++++++++++++++ takeoff ++++++++++++++++++++++");
            return callTakeoff(cmd.takeoff.altitude, cmd.takeoff.yaw);
        }
        if (cmd.command_type == "land") {
            return callLand(cmd.land.yaw);
        }
        if (cmd.command_type == "position_control_ned") {
            // NED → ENU
            double xN = cmd.pos_ned.x;
            double yE = cmd.pos_ned.y;
            double zDown = cmd.pos_ned.z;
            return publishPositionENU(yE, xN, -zDown);
        }
        if (cmd.command_type == "velocity_control_ned") {
            double vxN = cmd.vel_ned.vx;
            double vyE = cmd.vel_ned.vy;
            double vzDown = cmd.vel_ned.vz;
            return publishVelocityENU(vyE, vxN, -vzDown, cmd.vel_ned.yaw_rate);
        }
        if (cmd.command_type == "return_to_launch") {
            return callSetMode("AUTO.RTL");
        }
        if (cmd.command_type == "hover") {
            return callSetMode(cmd.hover.mode);
        }
        if (cmd.command_type == "set_mode") {
            if (cmd.set_mode.mode.empty()) { out_reason = "empty mode"; return false; }
            return callSetMode(cmd.set_mode.mode);
        }
    } catch (const std::exception& e) {
        out_reason = e.what();
        return false;
    }

    out_reason = "unknown command_type";
    return false;
}

bool CommandDispatcher::callTakeoff(double alt, double yaw) {
    mavros_msgs::CommandTOL srv;
    srv.request.altitude = alt;
    srv.request.yaw = yaw;
    if (takeoff_srv_.call(srv)) {
        return srv.response.success;
    }
    return false;
}

bool CommandDispatcher::callLand(double yaw) {
    mavros_msgs::CommandTOL srv;
    srv.request.altitude = 0.0;
    srv.request.yaw = yaw;
    if (land_srv_.call(srv)) {
        return srv.response.success;
    }
    return false;
}

bool CommandDispatcher::publishPositionENU(double x_east, double y_north, double z_up) {
    geometry_msgs::PoseStamped p;
    p.header.stamp = ros::Time::now();
    p.pose.position.x = x_east;
    p.pose.position.y = y_north;
    p.pose.position.z = z_up;
    pos_pub_.publish(p);
    return true;
}

bool CommandDispatcher::publishVelocityENU(double vx, double vy, double vz, double yaw_rate) {
    geometry_msgs::TwistStamped t;
    t.header.stamp = ros::Time::now();
    t.twist.linear.x = vx;
    t.twist.linear.y = vy;
    t.twist.linear.z = vz;
    t.twist.angular.z = yaw_rate;
    vel_pub_.publish(t);
    return true;
}

bool CommandDispatcher::callSetMode(const std::string& mode) {
    mavros_msgs::SetMode m;
    m.request.custom_mode = mode;
    if (set_mode_srv_.call(m)) return m.response.mode_sent;
    return false;
}
