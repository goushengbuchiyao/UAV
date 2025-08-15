#include "uav_control/command_executor.h"

CommandExecutor::CommandExecutor(ros::NodeHandle& nh)
{
    std::string uav_id_ = nh.param<std::string>("uav_id", "uav1");
    std::string prefix_ = "/" + uav_id_;
    // === 订阅云端指令话题 ===
    command_sub_ = nh.subscribe("/mqtt_ros_bridge" + prefix_ + "/ros/uavcontrol/command", 10,
                                 &CommandExecutor::commandCallback, this);

    // === 发布 MAVROS 控制话题 ===
    local_pos_pub_   = nh.advertise<geometry_msgs::PoseStamped>(prefix_ + "/mavros/setpoint_position/local", 10);
    vel_pub_         = nh.advertise<geometry_msgs::TwistStamped>(prefix_ + "/mavros/setpoint_velocity/cmd_vel", 10);
    global_pos_pub_  = nh.advertise<sensor_msgs::NavSatFix>(prefix_ + "/mavros/global_position/set_gp_origin", 10);


    // === 服务客户端 ===
    arming_client_   = nh.serviceClient<mavros_msgs::CommandBool>(prefix_ + "/mavros/cmd/arming");
    set_mode_client_ = nh.serviceClient<mavros_msgs::SetMode>(prefix_ + "/mavros/set_mode");
    takeoff_client_  = nh.serviceClient<mavros_msgs::CommandTOL>(prefix_ + "/mavros/cmd/takeoff");
    land_client_     = nh.serviceClient<mavros_msgs::CommandTOL>(prefix_ + "/mavros/cmd/land");
}

void CommandExecutor::commandCallback(const uav_msgs::UAVControlCommand::ConstPtr& msg)
{
    ROS_INFO("Received command type: %s", msg->command_type.c_str());

    if (msg->command_type == "takeoff")
    {
        executeTakeoff(msg->takeoff.altitude, msg->takeoff.yaw);
    }
    else if (msg->command_type == "land")
    {
        executeLand(msg->land.yaw);
    }
    else if (msg->command_type == "position_control_ned")
    {
        executePositionNED(msg->pos_ned.x, msg->pos_ned.y, msg->pos_ned.z, msg->pos_ned.yaw);
    }
    else if (msg->command_type == "position_control_global")
    {
        executePositionGlobal(msg->pos_global.latitude, msg->pos_global.longitude, msg->pos_global.altitude, msg->pos_global.yaw);
    }
    else if (msg->command_type == "velocity_control_ned")
    {
        executeVelocityNED(msg->vel_ned.vx, msg->vel_ned.vy, msg->vel_ned.vz, msg->vel_ned.yaw_rate);
    }
    else if (msg->command_type == "return_to_launch")
    {
        executeReturnToLaunch(msg->rtl.altitude);
    }
    else if (msg->command_type == "hover")
    {
        executeHover(msg->hover.mode);
    }
    else if (msg->command_type == "set_mode")
    {
        setFlightMode(msg->set_mode.mode);
    }
    else
    {
        ROS_WARN("Unknown command type: %s", msg->command_type.c_str());
    }
}

bool CommandExecutor::armUAV(bool arm)
{
    mavros_msgs::CommandBool srv;
    srv.request.value = arm;
    if (arming_client_.call(srv) && srv.response.success)
    {
        ROS_INFO("UAV %s successfully", arm ? "unarmed" : "armed");
        return true;
    }
    ROS_ERROR("UAV %s failed", arm ? "unarmed" : "armed");
    return false;
}

bool CommandExecutor::setFlightMode(const std::string& mode)
{
    mavros_msgs::SetMode srv;
    srv.request.custom_mode = mode;
    if (set_mode_client_.call(srv) && srv.response.mode_sent)
    {
        ROS_INFO("UAV flight mode switched to: %s", mode.c_str());
        return true;
    }
    ROS_ERROR("UAV flight mode switch failed: %s", mode.c_str());
    return false;
}

// bool CommandExecutor::executeTakeoff(double altitude, double yaw)
// {
    
//     setFlightMode("OFFBOARD");
//     armUAV(true);

//     mavros_msgs::CommandTOL srv;
//     srv.request.altitude = altitude;
//     srv.request.yaw = yaw;
//     if (takeoff_client_.call(srv) && srv.response.success)
//     {
//         ROS_INFO("起飞成功，高度: %.2f m", altitude);
//         return true;
//     }
//     ROS_ERROR("起飞失败");
//     return false;
// }
bool CommandExecutor::executeTakeoff(double altitude, double yaw)
{
    ROS_INFO("UAV is ready to execute safe OFFBOARD takeoff, altitude: %.2f m, yaw: %.2f°", altitude, yaw);

    // 1. 先构造目标位置（这里使用当前位置的 x、y，目标 z 为 altitude）
    geometry_msgs::PoseStamped pose;
    // pose.header.frame_id = "map";
    pose.pose.position.x = 0.0;  // 可以改成当前 UAV 的位置
    pose.pose.position.y = 0.0;
    pose.pose.position.z = altitude;

    // 2. 连续发送若干个 setpoint（PX4 要求进入 OFFBOARD 前必须有连续流）
    ros::Rate rate(20); // 20Hz
    for (int i = 0; i < 20; ++i)  // 发布 1 秒左右
    {
        pose.header.stamp = ros::Time::now();
        local_pos_pub_.publish(pose);
        rate.sleep();
    }

    // 3. 切换模式为 OFFBOARD
    if (!setFlightMode("OFFBOARD"))
    {
        ROS_ERROR("UAV failed to switch to OFFBOARD mode, takeoff cancelled");
        return false;
    }

    // 4. 解锁无人机
    if (!armUAV(true))
    {
        ROS_ERROR("UAV failed to unarm, takeoff cancelled");
        return false;
    }

    ROS_INFO("UAV takeoff command sent");
    return true;
}

bool CommandExecutor::executeLand(double yaw)
{
    setFlightMode("AUTO.LAND");

    mavros_msgs::CommandTOL srv;
    srv.request.yaw = yaw;
    if (land_client_.call(srv) && srv.response.success)
    {
        ROS_INFO("UAV landed successfully");
        return true;
    }
    ROS_ERROR("UAV landing failed");
    return false;
}

bool CommandExecutor::executeReturnToLaunch(double altitude)
{
    setFlightMode("AUTO.RTL");
    ROS_INFO("UAV is ready to return to launch, altitude: %.2f m", altitude);
    return true;
}

void CommandExecutor::executeHover(const std::string& mode)
{
    ROS_INFO("UAV is ready to hover in mode: %s", mode.c_str());
    setFlightMode(mode);
}


void CommandExecutor::executePositionNED(double x, double y, double z, double yaw)
{
    geometry_msgs::PoseStamped pose;
    pose.pose.position.x = x;
    pose.pose.position.y = y;
    pose.pose.position.z = z;
    local_pos_pub_.publish(pose);
    ROS_INFO("UAV is ready to execute position control (NED) - x: %.2f, y: %.2f, z: %.2f, yaw: %.2f", x, y, z, yaw);
}

void CommandExecutor::executePositionGlobal(double lat, double lon, double alt, double yaw)
{
    sensor_msgs::NavSatFix pos;
    pos.latitude = lat;
    pos.longitude = lon;
    pos.altitude = alt;
    global_pos_pub_.publish(pos);
    ROS_INFO("UAV is ready to execute position control (Global) - lat: %.7f, lon: %.7f, alt: %.2f", lat, lon, alt);
}

void CommandExecutor::executeVelocityNED(double vx, double vy, double vz, double yaw_rate)
{
    geometry_msgs::TwistStamped vel;
    vel.twist.linear.x = vx;
    vel.twist.linear.y = vy;
    vel.twist.linear.z = vz;
    vel_pub_.publish(vel);
    ROS_INFO("UAV is ready to execute velocity control (NED) - vx: %.2f, vy: %.2f, vz: %.2f, yaw_rate: %.2f", vx, vy, vz, yaw_rate);
}
