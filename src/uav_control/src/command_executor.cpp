#include "uav_control/command_executor.h"

CommandExecutor::CommandExecutor() {}

void CommandExecutor::init(ros::NodeHandle &nh, const std::string& ns) {
    nh_ = nh;
    ns_ = ns;
    takeoff_srv_ = nh_.serviceClient<mavros_msgs::CommandTOL>(ns_ + "mavros/cmd/takeoff");
    land_srv_ = nh_.serviceClient<mavros_msgs::CommandTOL>(ns_ + "mavros/cmd/land");
    set_mode_srv_ = nh_.serviceClient<mavros_msgs::SetMode>(ns_ + "mavros/set_mode");
    arming_srv_ = nh_.serviceClient<mavros_msgs::CommandBool>(ns_ + "mavros/cmd/arming");

    pos_pub_ = nh_.advertise<geometry_msgs::PoseStamped>(ns_ + "mavros/setpoint_position/local", 10);
    vel_pub_ = nh_.advertise<geometry_msgs::TwistStamped>(ns_ + "mavros/setpoint_velocity/cmd_vel", 10);
}

bool CommandExecutor::execute(const uav_msgs::UAVControlCommand& msg, std::string& out_reason) {
    const std::string &t = msg.command_type;
    if (t == "takeoff") return doTakeoff(msg.takeoff.altitude, msg.takeoff.yaw, out_reason);
    if (t == "land") return doLand(msg.land.yaw, out_reason);
    if (t == "position_control_ned") return doPositionNED(msg.pos_ned, out_reason);
    if (t == "velocity_control_ned") return doVelocityNED(msg.vel_ned, out_reason);
    if (t == "return_to_launch") return doRTL(msg.rtl.altitude, out_reason);
    if (t == "hover") return doHover(msg.hover.mode, out_reason);
    if (t == "set_mode") return doSetMode(msg.set_mode.mode, out_reason);
    out_reason = "unknown command_type";
    return false;
}

bool CommandExecutor::doTakeoff(double altitude, double yaw, std::string& out_reason) {
    mavros_msgs::CommandTOL srv;
    srv.request.altitude = altitude;
    srv.request.yaw = yaw;
    if (takeoff_srv_.call(srv)) return srv.response.success;
    out_reason = "takeoff call failed";
    return false;
}

bool CommandExecutor::doLand(double yaw, std::string& out_reason) {
    mavros_msgs::CommandTOL srv;
    srv.request.altitude = 0.0;
    srv.request.yaw = yaw;
    if (land_srv_.call(srv)) return srv.response.success;
    out_reason = "land call failed";
    return false;
}

bool CommandExecutor::doPositionNED(const uav_msgs::UAVControlCommand::_pos_ned_type &p, std::string& out_reason) {
    geometry_msgs::PoseStamped ps;
    ps.header.stamp = ros::Time::now();
    ps.pose.position.x = p.y; // ENU.x = east
    ps.pose.position.y = p.x; // ENU.y = north
    ps.pose.position.z = -p.z; // ENU.z = up
    pos_pub_.publish(ps);
    return true;
}

bool CommandExecutor::doVelocityNED(const uav_msgs::UAVControlCommand::_vel_ned_type &v, std::string& out_reason) {
    geometry_msgs::TwistStamped ts;
    ts.header.stamp = ros::Time::now();
    ts.twist.linear.x = v.vy;
    ts.twist.linear.y = v.vx;
    ts.twist.linear.z = -v.vz;
    ts.twist.angular.z = v.yaw_rate;
    vel_pub_.publish(ts);
    return true;
}

bool CommandExecutor::doRTL(double altitude, std::string& out_reason) {
    mavros_msgs::SetMode m;
    m.request.custom_mode = "AUTO.RTL";
    if (set_mode_srv_.call(m)) return m.response.mode_sent;
    out_reason = "RTL mode call failed";
    return false;
}

bool CommandExecutor::doHover(const std::string& mode, std::string& out_reason) {
    mavros_msgs::SetMode m;
    m.request.custom_mode = mode;
    if (set_mode_srv_.call(m)) return m.response.mode_sent;
    out_reason = "hover mode call failed";
    return false;
}

bool CommandExecutor::doSetMode(const std::string& mode, std::string& out_reason) {
    mavros_msgs::SetMode m;
    m.request.custom_mode = mode;
    if (set_mode_srv_.call(m)) return m.response.mode_sent;
    out_reason = "set mode call failed";
    return false;
}
