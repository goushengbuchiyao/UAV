#include "uav_control/uav_control_node.h"
#include <iostream>
#include <cmath>
#include <tf2/LinearMath/Quaternion.h>
#include <tf2/transform_datatypes.h>
#include <tf2/utils.h>
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
UAVControlNode::UAVControlNode(ros::NodeHandle& nh) : nh_(nh)
{
    nh_.param<std::string>("uav_id", uav_id_, "uav1");
    prefix_ = "/" + uav_id_;

    // RC检测参数
    nh_.param<bool>("enable_rc_check", rc_check_enabled_, true);
    nh_.param<double>("rc_threshold", rc_threshold_, 50.0);
    // 初始化遥控器更改标志
    rc_changed_ = false;

    // 订阅RC通道话题
    rc_sub_ = nh_.subscribe(prefix_ + "/mavros/rc/in", 10, &UAVControlNode::rcCallback, this);

    // 订阅 MAVROS 话题
    state_sub_ = nh_.subscribe(prefix_ + "/mavros/state", 10, &UAVControlNode::stateCallback, this);
    battery_sub_ = nh_.subscribe(prefix_ + "/mavros/battery", 10, &UAVControlNode::batteryCallback, this);
    gps_sub_ = nh_.subscribe(prefix_ + "/mavros/gpsstatus/gps1/raw", 10, &UAVControlNode::gpsCallback, this);
    local_pos_sub_ = nh_.subscribe(prefix_ + "/mavros/local_position/pose", 10, &UAVControlNode::localPosCallback, this);
    velocity_sub_ = nh_.subscribe(prefix_ + "/mavros/local_position/velocity_local", 10, &UAVControlNode::velocityCallback, this);
    // 订阅 UAVControlCommand 指令
    cmd_sub_ = nh_.subscribe("/mqtt_ros_bridge/" + prefix_ + "/ros/uavcontrol/command", 10, &UAVControlNode::uavCommandCallback, this);

    // 初始化 MAVROS 服务
    arming_client_ = nh_.serviceClient<mavros_msgs::CommandBool>(prefix_ + "/mavros/cmd/arming");
    set_mode_client_ = nh_.serviceClient<mavros_msgs::SetMode>(prefix_ + "/mavros/set_mode");
    // takeoff_client_ = nh_.serviceClient<mavros_msgs::CommandTOL>(prefix_ + "/mavros/cmd/takeoff");
    land_client_ = nh_.serviceClient<mavros_msgs::CommandTOL>(prefix_ + "/mavros/cmd/land");
    
    // 初始化Mission服务客户端
    mission_clear_client_ = nh_.serviceClient<mavros_msgs::WaypointClear>(prefix_ + "/mavros/mission/clear");
    mission_push_client_ = nh_.serviceClient<mavros_msgs::WaypointPush>(prefix_ + "/mavros/mission/push");
    mission_set_current_client_ = nh_.serviceClient<mavros_msgs::WaypointSetCurrent>(prefix_ + "/mavros/mission/set_current");
    // mission_request_list_client_ = nh_.serviceClient<mavros_msgs::WaypointRequestList>(prefix_ + "/mavros/mission/request_list");
    // 添加航点拉取客户端
    mission_pull_client_ = nh_.serviceClient<mavros_msgs::WaypointPull>(prefix_ + "/mavros/mission/pull");
    // 订阅航点到达话题
    mission_reached_sub_ = nh_.subscribe(prefix_ + "/mavros/mission/reached", 10, &UAVControlNode::missionReachedCallback, this);

    // MAVROS 发布器
    local_pos_pub_ = nh_.advertise<geometry_msgs::PoseStamped>(prefix_ + "/mavros/setpoint_position/local", 10);
    local_vel_pub_ = nh_.advertise<geometry_msgs::TwistStamped>(prefix_ + "/mavros/setpoint_velocity/cmd_vel", 10);
    
    // ros参数
    nh_.param<bool>("enable_px4_params_load", enable_px4_params_load_, false);
    nh_.param<bool>("reboot_px4_set_reset_ekf", reboot_px4_set_reset_ekf_, false);
    // 地理围栏示例参数
    nh_.param<double>("fence_min_x", fence_min_x_, -50.0);
    nh_.param<double>("fence_max_x", fence_max_x_, 50.0);
    nh_.param<double>("fence_min_y", fence_min_y_, -50.0);
    nh_.param<double>("fence_max_y", fence_max_y_, 50.0);
    nh_.param<double>("fence_min_z", fence_min_z_, -1.0);
    nh_.param<double>("fence_max_z", fence_max_z_, 50.0);

    // 加载 px4 参数
    if (enable_px4_params_load_){
        loadPX4Params("config/px4_params.yaml");
    }

    ROS_INFO("[%s] UAVControlNode initialized.", uav_id_.c_str());
}

void UAVControlNode::run()
{
    ros::Rate rate(20.0); // 20Hz
    ROS_INFO("[%s] Waiting for MAVROS connection...", uav_id_.c_str());

    // 等待与 PX4 通信
    while (ros::ok())
    {
        ros::spinOnce();
        if(current_state_.connected)
        {
            // ROS_INFO("[%s] MAVROS connected to PX4!", uav_id_.c_str());
            if(current_state_.armed)
            {
                if(checkInFlightSafety())
                {
                    ROS_INFO("[%s] UAV in flight safety check passed!", uav_id_.c_str());
                    // break;
                }
                else
                {
                    ROS_ERROR("[%s] UAV in flight safety check failed!", uav_id_.c_str());
                    // 进入返航模式
                    setMode("AUTO.RTL");
                    // break;
                }
            }
            else
            {
                setMode("POSCTL");
                ROS_INFO("[%s] UAV not armed, ready for commands.", uav_id_.c_str());
            }
        }
        else
        {
            ROS_INFO("[%s] MAVROS not connected to PX4!",uav_id_.c_str());
        }
        rate.sleep();
    }
    ROS_INFO("[%s] MAVROS connected to PX4!", uav_id_.c_str());
}

// -------------------- 回调函数 --------------------
void UAVControlNode::stateCallback(const mavros_msgs::State::ConstPtr& msg)
{
    // std::lock_guard<std::mutex> lock(state_mutex_);
    current_state_ = *msg;
}

void UAVControlNode::batteryCallback(const sensor_msgs::BatteryState::ConstPtr& msg)
{
    // std::lock_guard<std::mutex> lock(state_mutex_);
    battery_ = *msg;
}

void UAVControlNode::gpsCallback(const mavros_msgs::GPSRAW::ConstPtr& msg)
{
    // std::lock_guard<std::mutex> lock(state_mutex_);
    gps_ = *msg;
}

void UAVControlNode::localPosCallback(const geometry_msgs::PoseStamped::ConstPtr& msg)
{
    // std::lock_guard<std::mutex> lock(state_mutex_);
    local_pose_ = *msg;
}

void UAVControlNode::velocityCallback(const geometry_msgs::TwistStamped::ConstPtr& msg)
{
    // std::lock_guard<std::mutex> lock(state_mutex_);
    velocity_ = *msg;
}

// -------------------- UAVControlCommand 处理 --------------------
void UAVControlNode::uavCommandCallback(const uav_msgs::UAVControlCommand::ConstPtr& msg)
{
    ROS_INFO("[%s] Received UAVControlCommand: %s", uav_id_.c_str(), msg->command_type.c_str());
    executeCommand(*msg);
}

// -------------------- 核心执行 --------------------
void UAVControlNode::executeCommand(const uav_msgs::UAVControlCommand& cmd)
{
    if (rc_changed_) {
            ROS_INFO("[%s] RC input detected, stopping position control.", uav_id_.c_str());
            return;
        }
    if(cmd.command_type == "takeoff")
    {
        if(!checkPreArmSafety())
        {
            ROS_WARN("[%s] Pre-arm safety check failed! Aborting takeoff.", uav_id_.c_str());
            return;
        }
        
        if(arm())
        {
            // setMode("OFFBOARD");
            ROS_INFO("[%s] UAV armed, initiating takeoff.", uav_id_.c_str());
            // ROS_INFO("[%s] Takeoff altitude: %.2f, Yaw: %.2f", uav_id_.c_str(), cmd.takeoff.altitude, cmd.takeoff.yaw);
            // ROS_INFO("[%s] current altitude: %.2f, Yaw: %.2f", uav_id_.c_str(), cmd.takeoff.altitude, cmd.takeoff.yaw);
            takeoff(cmd.takeoff.altitude, cmd.takeoff.yaw);

            // // 起飞后循环飞行中安全检查
            // ros::Rate rate(10.0);
            // while (ros::ok())
            // {
            //     ros::spinOnce();
            //     if(!checkInFlightSafety())
            //     {
            //         ROS_ERROR("[%s] In-flight safety violated! Initiating emergency RTL.", uav_id_.c_str());
            //         setMode("AUTO.RTL");
            //         break;
            //     }
            //     rate.sleep();
            // }
        }
        else
        {
            ROS_ERROR("[%s] Failed to arm UAV!", uav_id_.c_str());
        }
    }
    else if(cmd.command_type == "land")
    {
        land(cmd.land.yaw);
    }
    else if(cmd.command_type == "position_control_ned")
    {
        sendPositionSetpoint(cmd.pos_ned.x, cmd.pos_ned.y, cmd.pos_ned.z, cmd.pos_ned.yaw);
    }
    else if(cmd.command_type == "velocity_control_ned")
    {
        sendVelocitySetpoint(cmd.vel_ned.vx, cmd.vel_ned.vy, cmd.vel_ned.vz, cmd.vel_ned.yaw_rate);
    }
    else if(cmd.command_type == "set_mode")
    {
        setMode(cmd.set_mode.mode);
    }
    else if(cmd.command_type == "return_to_launch")
    {
        setMode("AUTO.RTL");
    }
    else if(cmd.command_type == "hover")
    {
        setMode(cmd.hover.mode);
    }
    // 航线规划任务处理
    else if(cmd.command_type == "waypoint_mission")
    {
        ROS_INFO("[%s] Received waypoint mission with %ld points", uav_id_.c_str(), cmd.waypoints_cmd.waypoints.size());

        // 1. 清除现有任务
        if (cmd.waypoints_cmd.clear_existing) {
            if (!clearMission()) {
                ROS_ERROR("[%s] Failed to clear existing mission", uav_id_.c_str());
                return;
            }
        }

        // 2. 推送新航点
        if (!pushMission(cmd.waypoints_cmd.waypoints)) {
            ROS_ERROR("[%s] Failed to push new mission", uav_id_.c_str());
            return;
        }

        // // 3. 验证航点上传
        // if (!requestMissionCount()) {
        //     ROS_WARN("[%s] Could not verify mission count", uav_id_.c_str());
        // }

        // 4. 如果需要立即执行
        // if (cmd.start_immediately) {
        ROS_INFO("[%s] Starting mission execution", uav_id_.c_str());
        // setCurrentWaypoint(0);
        setMode("AUTO.MISSION");
        mission_active_ = true;
        // }
    }
    else
    {
        setMode("POSCTL");
        ROS_WARN("[%s] Unknown command_type: %s", uav_id_.c_str(), cmd.command_type.c_str());
    }
}

// -------------------- 安全检查 --------------------
bool UAVControlNode::checkPreArmSafety()
{
    std::lock_guard<std::mutex> lock(state_mutex_);
    if(!current_state_.connected)
    {
        ROS_ERROR("[%s] PX4 not connected.", uav_id_.c_str());
        return false;
    }

    if(battery_.percentage < 0.2)
    {
        ROS_ERROR("[%s] Battery too low: %.2f%%", uav_id_.c_str(), battery_.percentage*100.0);
        return false;
    }

    if(!isInsideFence(local_pose_.pose.position.x, local_pose_.pose.position.y, local_pose_.pose.position.z))
    {
        ROS_ERROR("[%s] UAV outside geofence!", uav_id_.c_str());
        return false;
    }

    if(gps_.fix_type < 3 || gps_.satellites_visible < 10)
    {
        ROS_ERROR("[%s] GPS fix invalid or insufficient satellites: fix=%d, sats=%d", uav_id_.c_str(), gps_.fix_type, gps_.satellites_visible);
        return false;
    }

    ROS_INFO("[%s] Pre-arm safety check passed.", uav_id_.c_str());
    return true;
}

bool UAVControlNode::checkInFlightSafety()
{
    std::lock_guard<std::mutex> lock(state_mutex_);
    if(!isInsideFence(local_pose_.pose.position.x, local_pose_.pose.position.y, local_pose_.pose.position.z))
    {
        ROS_ERROR("[%s] Geofence violation!", uav_id_.c_str());
        return false;
    }
    if(gps_.fix_type < 3 || gps_.satellites_visible < 10)
    {
        ROS_ERROR("[%s] GPS fix type: %d", uav_id_.c_str(), gps_.fix_type);
        ROS_ERROR("[%s] GPS satellites_visible: %d", uav_id_.c_str(), gps_.satellites_visible);
        ROS_ERROR("[%s] GPS lost or insufficient satellites!", uav_id_.c_str());
        return false;
    }
    return true;
}

bool UAVControlNode::isInsideFence(double x, double y, double z)
{
    ROS_INFO("[%s] fence_min_x_: %.2f, fence_max_x_: %.2f, fence_min_y_: %.2f, fence_max_y_: %.2f, fence_min_z_: %.2f, fence_max_z_: %.2f", uav_id_.c_str(), fence_min_x_, fence_max_x_, fence_min_y_, fence_max_y_, fence_min_z_, fence_max_z_);
    ROS_INFO("[%s] x: %.2f, y: %.2f, z: %.2f", uav_id_.c_str(), x, y, z);
    return x >= fence_min_x_ && x <= fence_max_x_ &&
           y >= fence_min_y_ && y <= fence_max_y_ &&
           z >= fence_min_z_ && z <= fence_max_z_;
}

// -------------------- MAVROS 操作 --------------------
bool UAVControlNode::arm()
{
    mavros_msgs::CommandBool srv;
    srv.request.value = true;
    if(arming_client_.call(srv) && srv.response.success)
    {
        ROS_INFO("[%s] UAV armed successfully.", uav_id_.c_str());
        return true;
    }
    ROS_ERROR("[%s] Arming failed.", uav_id_.c_str());
    return false;
}

bool UAVControlNode::setMode(const std::string& mode)
{
    mavros_msgs::SetMode srv;
    srv.request.custom_mode = mode;
    if(set_mode_client_.call(srv) && srv.response.mode_sent)
    {
        ROS_INFO("[%s] Mode set to %s.", uav_id_.c_str(), mode.c_str());
        return true;
    }
    ROS_ERROR("[%s] Failed to set mode %s.", uav_id_.c_str(), mode.c_str());
    return false;
}

// bool UAVControlNode::takeoff(double altitude, double yaw)
// {
//     mavros_msgs::CommandTOL srv;
//     srv.request.altitude = altitude;
//     srv.request.yaw = yaw;
//     srv.request.latitude = 0;
//     srv.request.longitude = 0;
//     srv.request.min_pitch = 0;
//     ROS_INFO("[%s] Takeoff altitude: %.2f, yaw: %.2f", uav_id_.c_str(), srv.request.altitude, srv.request.yaw);
//      if (takeoff_client_.waitForExistence(ros::Duration(5.0))) {
//         if (takeoff_client_.call(srv) && srv.response.success) {
//             ROS_INFO("[%s] The takeoff command sent successfully! Altitude: %.2f meters, Yaw: %.2f radians", uav_id_.c_str(), altitude, yaw);
//             return true;
//         } else {
//             ROS_ERROR("[%s] The takeoff command failed to send! Result code: %d", uav_id_.c_str(), srv.response.result);
//             return false;
//         }
//     } else {
//         ROS_ERROR("[%s] The /mavros/cmd/takeoff service is not available!", uav_id_.c_str());
//         return false;
//     }
// }
bool UAVControlNode::takeoff(double altitude, double yaw)
{
    // 1. 先切换到OFFBOARD模式
    if (!setMode("OFFBOARD")) {
        ROS_ERROR("[%s] Failed to switch to OFFBOARD mode, cannot execute takeoff", uav_id_.c_str());
        return false;
    }

    // 2. 获取当前位置作为起飞基准点
    geometry_msgs::PoseStamped current_pose;
    {
        std::lock_guard<std::mutex> lock(state_mutex_);
        current_pose = local_pose_;
    }

    // 3. 定义起飞目标位置（保持当前XY位置，Z轴为目标高度）
    geometry_msgs::PoseStamped target_pose = current_pose;
    target_pose.pose.position.z = altitude;  // 目标起飞高度
    // target_pose.pose.orientation = tf::createQuaternionMsgFromYaw(yaw);  // 目标偏航角
    tf2::Quaternion quaternion;
    quaternion.setRPY(0, 0, yaw);  // 滚转、俯仰、偏航
    quaternion.normalize();
    target_pose.pose.orientation = tf2::toMsg(quaternion);  // 转换为消息类型

    // 4. 持续发送位置指令直到达到目标高度（超时时间30秒）
    ros::Rate rate(50.0);  // 高频发送指令（至少10Hz）
    ros::Time start_time = ros::Time::now();
    const double height_tolerance = 0.2;  // 高度误差容忍度（米）
    bool takeoff_success = false;

    ROS_INFO("[%s] Start Offboard takeoff, target altitude: %.2f meters, yaw angle: %.2f radians", 
             uav_id_.c_str(), altitude, yaw);

    while (ros::ok() && (ros::Time::now() - start_time).toSec() < 30.0) {
        // 持续发送位置指令（Offboard模式必须持续接收指令，否则会进入 failsafe）
        local_pos_pub_.publish(target_pose);

        // 检查当前高度是否达到目标
        std::lock_guard<std::mutex> lock(state_mutex_);
        double current_z = local_pose_.pose.position.z;
        double z_error = std::abs(current_z - altitude);

        ROS_INFO_THROTTLE(1.0, "[%s] Offboard takeoff in progress: current height=%.2f meters, target height=%.2f meters, error=%.2f meters",
                         uav_id_.c_str(), current_z, altitude, z_error);

        if (z_error < height_tolerance) {
            takeoff_success = true;
            break;
        }

        rate.sleep();
        ros::spinOnce();
    }

    if (takeoff_success) {
        ROS_INFO("[%s] Offboard takeoff successful, reached target height: %.2f meters", uav_id_.c_str(), altitude);
        return true;
    } else {
        ROS_ERROR("[%s] Offboard takeoff timeout (30 seconds), did not reach target height", uav_id_.c_str());
        return false;
    }
}

bool UAVControlNode::land(double yaw)
{
    mavros_msgs::CommandTOL srv;
    srv.request.yaw = yaw;
    if(land_client_.call(srv) && srv.response.success)
    {
        ROS_INFO("[%s] Land command sent successfully.", uav_id_.c_str());
        return true;
    }
    ROS_ERROR("[%s] Land command failed.", uav_id_.c_str());
    return false;
}

// void UAVControlNode::sendPositionSetpoint(double x, double y, double z, double yaw)
// {
//     geometry_msgs::PoseStamped pose;
//     pose.header.stamp = ros::Time::now();
//     pose.pose.position.x = x;
//     pose.pose.position.y = y;
//     pose.pose.position.z = z;

//     // 四元数转换 yaw -> quaternion
//     tf2::Quaternion q;
//     q.setRPY(0, 0, yaw);
//     pose.pose.orientation.x = q.x();
//     pose.pose.orientation.y = q.y();
//     pose.pose.orientation.z = q.z();
//     pose.pose.orientation.w = q.w();

//     ros::Rate rate(20);
//     for(int i=0; i<20; ++i) // 循环发布1秒
//     {
//         pose.header.stamp = ros::Time::now();
//         local_pos_pub_.publish(pose);
//         rate.sleep();
//     }
// }
void UAVControlNode::sendPositionSetpoint(double x, double y, double z, double yaw)
{
    // 地理围栏安全检查
    if (x < fence_min_x_ || x > fence_max_x_ || 
        y < fence_min_y_ || y > fence_max_y_ || 
        z < fence_min_z_ || z > fence_max_z_)
    {
        ROS_WARN("[%s] Target position (%.2f, %.2f, %.2f) out of geofence", 
                 uav_id_.c_str(), x, y, z);
        return;
    }

    geometry_msgs::PoseStamped pose;
    pose.header.stamp = ros::Time::now();
    pose.pose.position.x = x;
    pose.pose.position.y = y;
    pose.pose.position.z = z;

    // 四元数转换 yaw -> quaternion
    tf2::Quaternion q;
    q.setRPY(0, 0, yaw);
    pose.pose.orientation.x = q.x();
    pose.pose.orientation.y = q.y();
    pose.pose.orientation.z = q.z();
    pose.pose.orientation.w = q.w();

    // 闭环控制参数
    const double pos_tolerance = 0.2; // 位置容差(米)
    const int max_attempts = 100;     // 最大尝试次数
    const double loop_rate = 20.0;    // 发布频率(Hz)
    ros::Rate rate(loop_rate);
    int attempts = 0;

    // 基于位置反馈的动态发布
    while (ros::ok() && attempts < max_attempts)
    {
        // 计算当前位置与目标位置的距离
        double dx = local_pose_.pose.position.x - x;
        double dy = local_pose_.pose.position.y - y;
        double dz = local_pose_.pose.position.z - z;
        double distance = sqrt(dx*dx + dy*dy + dz*dz);

        if (distance < pos_tolerance)
        {
            ROS_INFO("[%s] Reached target position (attempts: %d)", 
                     uav_id_.c_str(), attempts);
            break;
        }

        // 更新时间戳并发布
        pose.header.stamp = ros::Time::now();
        local_pos_pub_.publish(pose);

        attempts++;
        rate.sleep();
    }

    if (attempts >= max_attempts)
    {
        ROS_WARN("[%s] Failed to reach target position within %d attempts", 
                 uav_id_.c_str(), max_attempts);
    }
}

// void UAVControlNode::sendVelocitySetpoint(double vx, double vy, double vz, double yaw_rate)
// {
    
//     geometry_msgs::TwistStamped vel;
//     vel.header.stamp = ros::Time::now();
//     vel.twist.linear.x = vx;
//     vel.twist.linear.y = vy;
//     vel.twist.linear.z = vz;
//     vel.twist.angular.z = yaw_rate;

//     ros::Rate rate(20);
//     for(int i=0; i<20; ++i)
//     {
//         vel.header.stamp = ros::Time::now();
//         local_vel_pub_.publish(vel);
//         rate.sleep();
//     }
// }
void UAVControlNode::sendVelocitySetpoint(double vx, double vy, double vz, double yaw_rate)
{
    // 速度安全限制检查
    const double max_linear_vel = 3.0;  // 最大线速度(m/s)
    const double max_angular_vel = 1.0; // 最大角速度(rad/s)
    vx = (vx > max_linear_vel) ? max_linear_vel : (vx < -max_linear_vel ? -max_linear_vel : vx);
    vy = (vy > max_linear_vel) ? max_linear_vel : (vy < -max_linear_vel ? -max_linear_vel : vy);
    vz = (vz > max_linear_vel) ? max_linear_vel : (vz < -max_linear_vel ? -max_linear_vel : vz);
    yaw_rate = (yaw_rate > max_angular_vel) ? max_angular_vel : (yaw_rate < -max_angular_vel ? -max_angular_vel : yaw_rate);


    geometry_msgs::TwistStamped vel;
    vel.header.stamp = ros::Time::now();
    vel.twist.linear.x = vx;
    vel.twist.linear.y = vy;
    vel.twist.linear.z = vz;
    vel.twist.angular.z = yaw_rate;

    // 闭环控制参数
    const double vel_tolerance = 0.1;   // 速度容差
    const int max_attempts = 50;       // 最大尝试次数
    const double loop_rate = 20.0;      // 发布频率(Hz)
    ros::Rate rate(loop_rate);
    int attempts = 0;

    // 基于速度反馈的动态发布
    while (ros::ok() && attempts < max_attempts)
    {
        // 计算速度误差
        double dvx = velocity_.twist.linear.x - vx;
        double dvy = velocity_.twist.linear.y - vy;
        double dvz = velocity_.twist.linear.z - vz;
        double dyaw = velocity_.twist.angular.z - yaw_rate;
        double vel_error = sqrt(dvx*dvx + dvy*dvy + dvz*dvz + dyaw*dyaw);

        if (vel_error < vel_tolerance)
        {
            ROS_INFO("[%s] Reached target velocity (attempts: %d)", uav_id_.c_str(), attempts);
            break;
        }

        vel.header.stamp = ros::Time::now();
        local_vel_pub_.publish(vel);

        attempts++;
        rate.sleep();
    }

    if (attempts >= max_attempts)
    {
        ROS_WARN("[%s] Failed to reach target velocity within %d attempts", uav_id_.c_str(), max_attempts);
    }
}

// -------------------- RC通道回调函数 --------------------
void UAVControlNode::rcCallback(const mavros_msgs::RCIn::ConstPtr& msg)
{
    if (msg->channels.empty() || msg->rssi==255 || !rc_check_enabled_) return;
    // current_rc_values_.clear();
    // current_rc_values_ = msg->channels;
    for (const auto& channel : msg->channels) {
        current_rc_values_.push_back(static_cast<int>(channel));
    }
    // 初始化初始RC值
    if (initial_rc_values_.empty()) {
        initial_rc_values_ = current_rc_values_;
        return;
    }
    
    // 检测RC通道变化
    for (size_t i = 0; i < current_rc_values_.size() && i < initial_rc_values_.size(); ++i) {
        if (std::abs(current_rc_values_[i] - initial_rc_values_[i]) > rc_threshold_) {
            rc_changed_ = true;
            ROS_WARN("[%s] RC channel %ld changed from %d to %d. Stopping control.", 
                     uav_id_.c_str(), i+1, initial_rc_values_[i], current_rc_values_[i]);
            setMode("POSITION"); // 切换到位置模式
            break;
        }else{
            rc_changed_ = false;
        }
    }
}

// -------------------- 航点任务处理 --------------------
// -------------------- 清除航点任务 --------------------
bool UAVControlNode::clearMission() {
    mavros_msgs::WaypointClear srv;
    if (mission_clear_client_.call(srv) && srv.response.success) {
        ROS_INFO("[%s] Mission cleared successfully", uav_id_.c_str());
        total_waypoints_ = 0;
        current_waypoint_ = -1;
        mission_active_ = false;
        return true;
    }
    ROS_ERROR("[%s] Failed to clear mission", uav_id_.c_str());
    return false;
}

// -------------------- 推送航点任务 --------------------
bool UAVControlNode::pushMission(const std::vector<uav_msgs::Waypoint>& waypoints) {
    mavros_msgs::WaypointPush srv;
    for (size_t i = 0; i < waypoints.size(); ++i) {
        mavros_msgs::Waypoint wp;
        // 从waypoint字段获取参数（修复访问路径）
        wp.frame = waypoints[i].waypoint.frame;
        wp.command = waypoints[i].waypoint.command;
        wp.is_current = waypoints[i].waypoint.is_current;
        wp.autocontinue = waypoints[i].waypoint.autocontinue;
        // 补充完整参数映射
        wp.param1 = waypoints[i].waypoint.param1;
        wp.param2 = waypoints[i].waypoint.param2;
        wp.param3 = waypoints[i].waypoint.param3;
        wp.param4 = waypoints[i].waypoint.param4;
        wp.x_lat = waypoints[i].waypoint.x_lat;
        wp.y_long = waypoints[i].waypoint.y_long;
        wp.z_alt = waypoints[i].waypoint.z_alt;
        srv.request.waypoints.push_back(wp);
    }

    if (mission_push_client_.call(srv) && srv.response.success) {
        ROS_INFO("[%s] Pushed %ld waypoints successfully", uav_id_.c_str(), waypoints.size());
        total_waypoints_ = waypoints.size();
        return true;
    }
    ROS_ERROR("[%s] Failed to push mission", uav_id_.c_str());
    return false;
}

// -------------------- 航点任务完成回调 --------------------
void UAVControlNode::missionReachedCallback(const mavros_msgs::WaypointReached::ConstPtr& msg) {
    current_waypoint_ = msg->wp_seq;
    ROS_INFO("[%s] Reached waypoint %d/%d", uav_id_.c_str(), current_waypoint_ + 1, total_waypoints_);

    if (current_waypoint_ + 1 >= total_waypoints_) {
        ROS_INFO("[%s] Mission completed successfully", uav_id_.c_str());
        mission_active_ = false;
        // 任务完成后自动着陆
        // land(0.0); // 偏航角设为0
    }
}
// // -------------------- 拉取航点任务计数 --------------------
// bool UAVControlNode::requestMissionCount() {
//     mavros_msgs::MissionRequestList srv;
//     if (mission_request_list_client_.call(srv) && srv.response.success) {
//         ROS_INFO("[%s] Requested mission count: %d", uav_id_.c_str(), srv.response.count);
//         return srv.response.count == total_waypoints_;
//     }
//     ROS_ERROR("[%s] Failed to request mission count", uav_id_.c_str());
//     return false;
// }

// -------------------- 拉取航点任务 --------------------
bool UAVControlNode::verifyMissionPull() {
    mavros_msgs::WaypointPull srv;
    if (mission_pull_client_.call(srv) && srv.response.success) {
        ROS_INFO("[%s] Pulled %d waypoints from vehicle", uav_id_.c_str(), srv.response.wp_received);
        return srv.response.wp_received == total_waypoints_;
    }
    ROS_ERROR("[%s] Failed to pull mission", uav_id_.c_str());
    return false;
}
// -------------------- PX4 参数加载 --------------------
void UAVControlNode::loadPX4Params(const std::string& yaml_file)
{
    try
    {
        YAML::Node config = YAML::LoadFile(yaml_file);
        for (auto it = config.begin(); it != config.end(); ++it)
        {
            std::string param_name = it->first.as<std::string>();
            double param_value = it->second.as<double>();
            ROS_INFO("[%s] PX4 param %s = %f (load to PX4 service if needed)", uav_id_.c_str(), param_name.c_str(), param_value);
        }
    }
    catch(const std::exception& e)
    {
        ROS_WARN("[%s] Failed to load PX4 params: %s", uav_id_.c_str(), e.what());
    }
}

// -------------------- main --------------------
int main(int argc, char** argv)
{
    ros::init(argc, argv, "uav_control_node");
    ros::NodeHandle nh("~");
    UAVControlNode node(nh);
    node.run();

    return 0;
}