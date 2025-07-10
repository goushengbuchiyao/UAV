#include <ros/ros.h>
#include <geometry_msgs/PoseStamped.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/PositionTarget.h>
#include <px_uav_msgs/UAVState.h>
#include <cmath>

class ArucoLandingController {
private:
    ros::NodeHandle nh_;
    ros::Subscriber aruco_pose_sub_;
    ros::Subscriber uav_state_sub_;
    ros::Publisher setpoint_raw_local_pub_;
    ros::ServiceClient arming_client_;
    ros::ServiceClient set_mode_client_;

    px_uav_msgs::UAVState uav_state_;
    geometry_msgs::PoseStamped aruco_pose_;
    bool new_aruco_pose_received_ = false;

    // 位置误差阈值
    const double POSITION_ERROR_THRESHOLD = 0.2;
    // 高度误差阈值
    const double ALTITUDE_ERROR_THRESHOLD = 0.1; 
    // 上锁重试次数
    const int ARMING_RETRY_TIMES = 3;
    // 切换 LAND 模式的高度
    const double LAND_MODE_ALTITUDE = 0.3; 

public:
    ArucoLandingController() {
        aruco_pose_sub_ = nh_.subscribe<geometry_msgs::PoseStamped>(
            "/ar_qr_detection/aruco_land_pose", 1,
            &ArucoLandingController::arucoPoseCallback, this);
        uav_state_sub_ = nh_.subscribe<px_uav_msgs::UAVState>(
            "/uav1/px_uav/state", 1,
            &ArucoLandingController::uavStateCallback, this);
        setpoint_raw_local_pub_ = nh_.advertise<mavros_msgs::PositionTarget>(
            "/uav1/mavros/setpoint_raw/local", 1);
        arming_client_ = nh_.serviceClient<mavros_msgs::CommandBool>(
            "/uav1/mavros/cmd/arming");
        set_mode_client_ = nh_.serviceClient<mavros_msgs::SetMode>(
            "/uav1/mavros/set_mode");
    }

    void arucoPoseCallback(const geometry_msgs::PoseStamped::ConstPtr& msg) {
        aruco_pose_ = *msg;
        new_aruco_pose_received_ = true;
    }

    void uavStateCallback(const px_uav_msgs::UAVState::ConstPtr& msg) {
        uav_state_ = *msg;
    }

    void sendPositionSetpoint(double x, double y, double z, double yaw) {
        mavros_msgs::PositionTarget pos_target;
        pos_target.header.stamp = ros::Time::now();
        pos_target.header.frame_id = "base_footprint";
        pos_target.coordinate_frame = mavros_msgs::PositionTarget::FRAME_LOCAL_NED;
        pos_target.type_mask = mavros_msgs::PositionTarget::IGNORE_VX |
                               mavros_msgs::PositionTarget::IGNORE_VY |
                               mavros_msgs::PositionTarget::IGNORE_VZ |
                               mavros_msgs::PositionTarget::IGNORE_AFX |
                               mavros_msgs::PositionTarget::IGNORE_AFY |
                               mavros_msgs::PositionTarget::IGNORE_AFZ |
                               mavros_msgs::PositionTarget::FORCE |
                               mavros_msgs::PositionTarget::IGNORE_YAW_RATE;
        pos_target.position.x = x;
        pos_target.position.y = y;
        pos_target.position.z = z;
        pos_target.yaw = yaw;

        setpoint_raw_local_pub_.publish(pos_target);
    }

    bool setMode(const std::string& mode) {
        mavros_msgs::SetMode set_mode_srv;
        set_mode_srv.request.custom_mode = mode;

        if (set_mode_client_.call(set_mode_srv)) {
            if (set_mode_srv.response.mode_sent) {
                ROS_INFO("Mode set to %s successfully", mode.c_str());
                return true;
            } else {
                ROS_ERROR("Failed to set mode to %s. Response: mode not sent", mode.c_str());
            }
        } else {
            ROS_ERROR("Failed to call set mode service for %s", mode.c_str());
        }
        return false;
    }

    bool armDisarm(bool arm) {
        for (int i = 0; i < ARMING_RETRY_TIMES; ++i) {
            mavros_msgs::CommandBool arm_cmd;
            arm_cmd.request.value = arm;

            if (arming_client_.call(arm_cmd)) {
                if (arm_cmd.response.success) {
                    ROS_INFO("Vehicle %s successfully", arm ? "armed" : "disarmed");
                    return true;
                } else {
                    ROS_ERROR("Failed to %s vehicle (attempt %d/%d). Response: operation failed", 
                            arm ? "arm" : "disarm", i + 1, ARMING_RETRY_TIMES);
                }
            } else {
                ROS_ERROR("Failed to call arm/disarm service for %s (attempt %d/%d)", 
                        arm ? "arm" : "disarm", i + 1, ARMING_RETRY_TIMES);
            }
            ros::Duration(0.5).sleep(); // 等待 0.5 秒后重试
        }
        return false;
    }

    // 判断无人机是否到达指定位置
    bool isAtPosition(double target_x, double target_y, double target_z) {
        double current_x = uav_state_.position[0];
        double current_y = uav_state_.position[1];
        double current_z = uav_state_.position[2];

        double xy_error = std::hypot(target_x - current_x, target_y - current_y);
        double z_error = std::abs(target_z - current_z);

        return xy_error < POSITION_ERROR_THRESHOLD && z_error < ALTITUDE_ERROR_THRESHOLD;
    }

    void mainLoop() {
        ros::Rate rate(20.0);

        // 在切换模式前先发送一段时间的指令
        for(int i = 100; ros::ok() && i > 0; --i){
            sendPositionSetpoint(0, 0, 0, 0);
            ros::spinOnce();
            rate.sleep();
        }

        while (ros::ok()) {
            if (new_aruco_pose_received_) {
                new_aruco_pose_received_ = false;

                double target_x = aruco_pose_.pose.position.x;
                double target_y = aruco_pose_.pose.position.y;
                double target_z = 2.0; 
                double target_yaw = 0.0;

                // 确保无人机已经解锁
                if (!uav_state_.armed) {
                    if (!armDisarm(true)) {
                        continue;
                    }
                }

                // 切换到 OFFBOARD 模式
                if (uav_state_.mode != "OFFBOARD") {
                    if (!setMode("OFFBOARD")) {
                        continue;
                    }
                }

                double current_z = uav_state_.position[2];
                if (current_z < LAND_MODE_ALTITUDE) {
                    // 高度小于 0.3m，直接进入 LAND 模式
                    ROS_INFO("Current altitude is below %.2f m, switching to LAND mode directly", LAND_MODE_ALTITUDE);
                    if (!setMode("LAND")) {
                        ROS_ERROR("Failed to switch to LAND mode");
                        continue;
                    }
                } else {
                    // 发送位置设定值，移动到二维码上方
                    sendPositionSetpoint(target_x, target_y, target_z, target_yaw);
                    
                    // 等待无人机到达指定位置
                    int max_wait_iterations = 100;
                    int wait_count = 0;
                    while (wait_count < max_wait_iterations && !isAtPosition(target_x, target_y, target_z)) {
                        sendPositionSetpoint(target_x, target_y, target_z, target_yaw); // 持续发送指令
                        ros::spinOnce();
                        rate.sleep();
                        wait_count++;
                    }

                    if (wait_count >= max_wait_iterations) {
                        ROS_ERROR("Timed out waiting to reach the target position above the marker");
                        continue;
                    }

                    // 开始降落
                    target_z = LAND_MODE_ALTITUDE; 
                    sendPositionSetpoint(target_x, target_y, target_z, target_yaw);
                    
                    // 等待到达 0.3 米高度
                    wait_count = 0;
                    while (wait_count < max_wait_iterations && !isAtPosition(target_x, target_y, target_z)) {
                        sendPositionSetpoint(target_x, target_y, target_z, target_yaw); // 持续发送指令
                        ros::spinOnce();
                        rate.sleep();
                        wait_count++;
                    }

                    if (wait_count >= max_wait_iterations) {
                        ROS_ERROR("Timed out waiting to reach 0.3m above the marker");
                        continue;
                    }
                    
                    // 切换到 LAND 模式
                    if (!setMode("LAND")) {
                        ROS_ERROR("Failed to switch to LAND mode");
                        continue;
                    }
                }

                // 等待飞控完成降落
                while (ros::ok() && uav_state_.armed) {
                    ros::spinOnce();
                    rate.sleep();
                }

                // 确保上锁
                if (uav_state_.armed) {
                    if (!armDisarm(false)) {
                        ROS_ERROR("Failed to disarm the vehicle after landing");
                    }
                }

                // 完成降落流程，跳出循环
                break;
            }

            ros::spinOnce();
            rate.sleep();
        }
    }
};

int main(int argc, char **argv) {
    ros::init(argc, argv, "aruco_landing_controller");
    ArucoLandingController controller;
    controller.mainLoop();
    return 0;
}