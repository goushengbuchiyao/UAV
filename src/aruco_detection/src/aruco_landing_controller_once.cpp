#include <ros/ros.h>
#include <geometry_msgs/PoseStamped.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/SetMode.h>
#include <mavros_msgs/PositionTarget.h>
#include <px_uav_msgs/UAVState.h>
#include <px_uav_msgs/TargetsInFrame.h>
#include <cmath>

class ArucoLandingController {
private:
    ros::NodeHandle nh_;
    ros::Subscriber aruco_pose_sub_;
    ros::Subscriber uav_state_sub_;
    ros::Subscriber mavros_pose_sub_;
    ros::Publisher setpoint_raw_local_pub_;
    ros::ServiceClient arming_client_;
    ros::ServiceClient set_mode_client_;

    geometry_msgs::PoseStamped mavros_pose_;
    px_uav_msgs::UAVState uav_state_;
    px_uav_msgs::TargetsInFrame aruco_pose_;
    bool new_aruco_pose_received_ = false;

    // 位置误差阈值
    const double POSITION_ERROR_THRESHOLD = 0.2;
    // 高度误差阈值
    const double ALTITUDE_ERROR_THRESHOLD = 0.1; 
    // 上锁重试次数
    const int ARMING_RETRY_TIMES = 3;

    // 降落时每次高度递减的步长
    const double DESCENT_STEP = 0.3; 
    // 最小降落高度
    const double MIN_ALTITUDE = 0.0; 

public:
    ArucoLandingController() {
        aruco_pose_sub_ = nh_.subscribe<px_uav_msgs::TargetsInFrame>(
            "/ar_qr_detection/aruco_land_pose", 1,
            &ArucoLandingController::arucoPoseCallback, this);
        uav_state_sub_ = nh_.subscribe<px_uav_msgs::UAVState>(
            "/uav1/px_uav/state", 1,
            &ArucoLandingController::uavStateCallback, this);
        mavros_pose_sub_ = nh_.subscribe<geometry_msgs::PoseStamped>(
            "/uav1/mavros/local_position/pose", 1,
            &ArucoLandingController::mavrosPoseCallback, this);
        setpoint_raw_local_pub_ = nh_.advertise<mavros_msgs::PositionTarget>(
            "/uav1/mavros/setpoint_raw/local", 1);
        arming_client_ = nh_.serviceClient<mavros_msgs::CommandBool>(
            "/uav1/mavros/cmd/arming");
        set_mode_client_ = nh_.serviceClient<mavros_msgs::SetMode>(
            "/uav1/mavros/set_mode");
    }
    void mavrosPoseCallback(const geometry_msgs::PoseStamped::ConstPtr& msg) {
        mavros_pose_ = *msg;
    }
<<<<<<< HEAD:src/aruco_detection/src/aruco_landing_controller_once.cpp
    void arucoPoseCallback(const px_uav_msgs::TargetsInFrame::ConstPtr& msg) {
=======
    void arucoPoseCallback(const geometry_msgs::PoseStamped::ConstPtr& msg) {
>>>>>>> fd5729b7abdf8e67000e384c931b8b349a92b806:src/aruco_detection/src/aruco_landing_controller.cpp
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
        double current_x = mavros_pose_.pose.position.x;
        double current_y = mavros_pose_.pose.position.y;
        double current_z = mavros_pose_.pose.position.z;

        double xy_error = std::hypot(target_x - current_x, target_y - current_y);
        double z_error = std::abs(target_z - current_z);
        ROS_DEBUG("Target pos: (%.2f, %.2f, %.2f), Current pos: (%.2f, %.2f, %.2f), xy_error=%.3f, z_error=%.3f",
        target_x, target_y, target_z, current_x, current_y, current_z, xy_error, z_error);

        return xy_error < POSITION_ERROR_THRESHOLD && z_error < ALTITUDE_ERROR_THRESHOLD;
    }

    void mainLoop() {
        ros::Rate rate(20.0);

<<<<<<< HEAD:src/aruco_detection/src/aruco_landing_controller_once.cpp
        // while (ros::ok()) {
        //     if (new_aruco_pose_received_) {
        //         new_aruco_pose_received_ = false;

        //         double target_x = aruco_pose_.pose.position.x;
        //         double target_y = aruco_pose_.pose.position.y;
        //         double target_z = mavros_pose_.pose.position.z; // 从当前高度开始
        //         double target_yaw = 0.0;

        //         // 切换到 OFFBOARD 模式
        //         if (uav_state_.mode != "OFFBOARD") {
        //             if (!setMode("OFFBOARD")) {
        //                 continue;
        //             }
        //         }

        //         ROS_INFO("========================================================");
        //         // 先飞到指定的 x, y 位置
        //         sendPositionSetpoint(target_x, target_y, target_z, target_yaw);
                

        //         // 开始降落
        //         while (ros::ok() && target_z >= MIN_ALTITUDE) {
        //             // 检查当前高度是否小于等于 0
        //             if (mavros_pose_.pose.position.z <= 0.1){
        //                 break;  // 如果高度小于等于 0.1，则停止降落
        //             }
        //             double target_x = aruco_pose_.pose.position.x;
        //             double target_y = aruco_pose_.pose.position.y;
        //             double target_z = mavros_pose_.pose.position.z;
        //             // ROS_INFO("Descending to height: %.2f", target_z);
        //             target_z -= DESCENT_STEP;
        //             if (target_z < MIN_ALTITUDE) {
        //                 target_z = MIN_ALTITUDE;
        //             }
        //             ROS_INFO("===========================landing=============================");
        //             ROS_INFO("Descending to height: %.2f", target_z);
        //             ROS_INFO("Current UAV Pose: (%.2f, %.2f, %.2f)",
        //                      mavros_pose_.pose.position.x,
        //                      mavros_pose_.pose.position.y,
        //                      mavros_pose_.pose.position.z);
        //             ROS_INFO("Target ArUco Pose: (%.2f, %.2f, %.2f)",
        //                      target_x, target_y, target_z);
        //             // 发送位置设定点
        //             sendPositionSetpoint(target_x, target_y, target_z, target_yaw);
        //             ros::spinOnce();
        //             rate.sleep();
                    
        //         }
        //         // 切换到 LAND 模式
        //         if (setMode("AUTO.LAND")) {
        //             ROS_INFO("Switched to AUTO.LAND mode");
        //         } else {
        //             ROS_ERROR("Failed to switch to AUTO.LAND mode");
        //         }

        //         // 降落完成后尝试上锁
        //         if (uav_state_.armed) {
        //             if (!armDisarm(false)) {
        //                 ROS_ERROR("Failed to disarm the vehicle after landing");
        //             }
        //         }
        //     }

        //     ros::spinOnce();
        //     rate.sleep();
        // }
=======
        while (ros::ok()) {
            if (new_aruco_pose_received_) {
                new_aruco_pose_received_ = false;

                double target_x = aruco_pose_.pose.position.x;
                double target_y = aruco_pose_.pose.position.y;
                double target_z = mavros_pose_.pose.position.z; // 从当前高度开始
                double target_yaw = 0.0;

                // 切换到 OFFBOARD 模式
                if (uav_state_.mode != "OFFBOARD") {
                    if (!setMode("OFFBOARD")) {
                        continue;
                    }
                }

                ROS_INFO("========================================================");
                // 先飞到指定的 x, y 位置
                sendPositionSetpoint(target_x, target_y, target_z, target_yaw);
                

                // 开始降落
                while (ros::ok() && target_z >= MIN_ALTITUDE) {
                    // 检查当前高度是否小于等于 0
                    if (mavros_pose_.pose.position.z <= 0.2){
                        break;  // 如果高度小于等于 0，则停止降落
                    }
                    double target_x = aruco_pose_.pose.position.x;
                    double target_y = aruco_pose_.pose.position.y;
                    double target_z = mavros_pose_.pose.position.z;
                    // ROS_INFO("Descending to height: %.2f", target_z);
                    target_z -= DESCENT_STEP;
                    if (target_z < MIN_ALTITUDE) {
                        target_z = MIN_ALTITUDE;
                    }
                    ROS_INFO("===========================landing=============================");
                    ROS_INFO("Descending to height: %.2f", target_z);
                    ROS_INFO("Current UAV Pose: (%.2f, %.2f, %.2f)",
                             mavros_pose_.pose.position.x,
                             mavros_pose_.pose.position.y,
                             mavros_pose_.pose.position.z);
                    ROS_INFO("Target ArUco Pose: (%.2f, %.2f, %.2f)",
                             target_x, target_y, target_z);
                    // 发送位置设定点
                    sendPositionSetpoint(target_x, target_y, target_z, target_yaw);
                    ros::spinOnce();
                    rate.sleep();
                    
                }
                // 切换到 LAND 模式
                if (setMode("AUTO.LAND")) {
                    ROS_INFO("Switched to AUTO.LAND mode");
                } else {
                    ROS_ERROR("Failed to switch to AUTO.LAND mode");
                }

                // 降落完成后尝试上锁
                if (uav_state_.armed) {
                    if (!armDisarm(false)) {
                        ROS_ERROR("Failed to disarm the vehicle after landing");
                    }
                }
            }

            ros::spinOnce();
            rate.sleep();
        }
>>>>>>> fd5729b7abdf8e67000e384c931b8b349a92b806:src/aruco_detection/src/aruco_landing_controller.cpp
    }
};

int main(int argc, char **argv) {
    ros::init(argc, argv, "aruco_landing_controller");
    ArucoLandingController controller;
    controller.mainLoop();
    return 0;
}
