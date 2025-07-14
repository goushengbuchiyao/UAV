#include <ros/ros.h>
#include <mavros_msgs/State.h>
#include <mavros_msgs/PositionTarget.h>
#include <mavros_msgs/CommandBool.h>
#include <mavros_msgs/SetMode.h>
#include <geometry_msgs/PoseStamped.h>
#include <px_uav_msgs/TargetsInFrame.h>

class ArucoLandingController {
private:
    ros::NodeHandle nh_;
    // 订阅无人机状态
    ros::Subscriber state_sub_;
    // 订阅无人机当前位置
    ros::Subscriber local_pose_sub_;
    // 订阅嵌套二维码目标位置信息
    ros::Subscriber aruco_pose_sub_;
    // 发布位置指令
    ros::Publisher setpoint_pub_;
    // 服务客户端：解锁上锁
    ros::ServiceClient arming_client_;
    // 服务客户端：模式切换
    ros::ServiceClient set_mode_client_;

    mavros_msgs::State current_state_;
    geometry_msgs::PoseStamped current_pose_;
    px_uav_msgs::TargetsInFrame aruco_pose_;

    bool outer_marker_found_ = false;
    bool inner_marker_found_ = false;

    // 降落参数
    const double DESCENT_STEP_OUT = 0.1;
    const double DESCENT_STEP_IN = 0.05;
    const double MIN_ALTITUDE = 0.1;
    const double HOVER_ALTITUDE = 0.5;
    
public:
    ArucoLandingController() {
        state_sub_ = nh_.subscribe<mavros_msgs::State>("/uav1/mavros/state", 1, &ArucoLandingController::stateCallback, this);
        local_pose_sub_ = nh_.subscribe<geometry_msgs::PoseStamped>("/uav1/mavros/local_position/pose", 1, &ArucoLandingController::localPoseCallback, this);
        aruco_pose_sub_ = nh_.subscribe<px_uav_msgs::TargetsInFrame>("/ar_qr_detection/aruco_land_pose", 1, &ArucoLandingController::arucoPoseCallback, this);
        setpoint_pub_ = nh_.advertise<mavros_msgs::PositionTarget>("/uav1/mavros/setpoint_raw/local", 1);
        arming_client_ = nh_.serviceClient<mavros_msgs::CommandBool>("/uav1/mavros/cmd/arming");
        set_mode_client_ = nh_.serviceClient<mavros_msgs::SetMode>("/uav1/mavros/set_mode");

        // // 初始化位置指令
        // mavros_msgs::PositionTarget pos_target;
        // pos_target.coordinate_frame = mavros_msgs::PositionTarget::FRAME_LOCAL_NED;
        // pos_target.type_mask = mavros_msgs::PositionTarget::IGNORE_VX |
        //                        mavros_msgs::PositionTarget::IGNORE_VY |
        //                        mavros_msgs::PositionTarget::IGNORE_VZ |
        //                        mavros_msgs::PositionTarget::IGNORE_AFX |
        //                        mavros_msgs::PositionTarget::IGNORE_AFY |
        //                        mavros_msgs::PositionTarget::IGNORE_AFZ |
        //                        mavros_msgs::PositionTarget::FORCE |
        //                        mavros_msgs::PositionTarget::IGNORE_YAW_RATE;

        // // 先发送一些位置指令，避免模式切换失败
        // for(int i = 100; ros::ok() && i > 0; --i){
        //     setpoint_pub_.publish(pos_target);
        //     ros::spinOnce();
        //     ros::Rate(100).sleep();
        // }
    }
    // 飞机状态回调函数
    void stateCallback(const mavros_msgs::State::ConstPtr& msg) {
        current_state_ = *msg;
        // 检查飞机是否上锁
        if (!current_state_.armed) { 
            ROS_INFO("Vehicle is disarmed, shutting down...");
            ros::shutdown();
        }
    }

    void localPoseCallback(const geometry_msgs::PoseStamped::ConstPtr& msg) {
        current_pose_ = *msg;
    }

    void arucoPoseCallback(const px_uav_msgs::TargetsInFrame::ConstPtr& msg) {
        aruco_pose_ = *msg;
        outer_marker_found_ = false;
        inner_marker_found_ = false;

        for (const auto& target : aruco_pose_.targets) {
            if (target.tracked_id == 18) {
                outer_marker_found_ = true;
            } else if (target.tracked_id == 1) {
                inner_marker_found_ = true;
                outer_marker_found_ = false;
            }
        }

        if (inner_marker_found_) {
            handleInnerMarker();
        } else if (outer_marker_found_) {
            handleOuterMarker();
        }
    }

    void handleOuterMarker() {
        // 切换到 OFFBOARD 模式
        if (current_state_.mode != "OFFBOARD") {
            if (!setMode("OFFBOARD")) {
                return;
            }
        }

        // 找到外层标记的目标位置
        for (const auto& target : aruco_pose_.targets) {
            
            if (target.tracked_id == 18) {
                double target_x = target.px;
                double target_y = target.py;
                double target_z = current_pose_.pose.position.z;
                
                target_z -= DESCENT_STEP_OUT;
                if (target_z < HOVER_ALTITUDE) {
                    target_z = HOVER_ALTITUDE;
                }
                ROS_INFO("===========================landing-first=============================");
                ROS_INFO("Descending to height: %.2f", target_z);
                ROS_INFO("Current UAV Pose: (%.2f, %.2f, %.2f)",
                            current_pose_.pose.position.x,
                            current_pose_.pose.position.y,
                            current_pose_.pose.position.z);
                ROS_INFO("Target ArUco Pose: (%.2f, %.2f, %.2f)",
                            target_x, target_y, target_z);
                // 发送位置设定点
                sendPositionSetpoint(target_x, target_y, target_z, 0.0);
                ros::spinOnce();
                ros::Rate(20).sleep();
            }
        }
    }

    void handleInnerMarker() {
        // 切换到 OFFBOARD 模式
        if (current_state_.mode != "OFFBOARD") {
            if (!setMode("OFFBOARD")) {
                return;
            }
        }


        // 找到内层标记的目标位置
        for (const auto& target : aruco_pose_.targets) {
            if (target.tracked_id == 1) {

                double target_z = current_pose_.pose.position.z;
                target_z -= DESCENT_STEP_IN;
                if(target_z >= MIN_ALTITUDE) {
                    ROS_INFO("===========================landing-second=============================");
                    ROS_INFO("Descending to height: %.2f", target_z);
                    ROS_INFO("Current UAV Pose: (%.2f, %.2f, %.2f)",
                            current_pose_.pose.position.x,
                            current_pose_.pose.position.y,
                            current_pose_.pose.position.z);
                    ROS_INFO("Target ArUco Pose: (%.2f, %.2f, %.2f)",
                            target.px, target.py, target_z);
                    sendPositionSetpoint(target.px, target.py, target_z, 0.0);
                    
                    ros::spinOnce();
                    ros::Rate(10).sleep();
                }
                if (target_z<=0.1){
                    // 切换到 LAND 模式
                    if (setMode("AUTO.LAND")) {
                        ROS_INFO("Switched to AUTO.LAND mode");
                    } else {
                        ROS_ERROR("Failed to switch to AUTO.LAND mode");
                    }
                    // break;
                }
                
                
            }
        }
    }

    bool setMode(const std::string& mode) {
        mavros_msgs::SetMode set_mode_srv;
        set_mode_srv.request.custom_mode = mode;
        if (set_mode_client_.call(set_mode_srv) && set_mode_srv.response.mode_sent) {
            ROS_INFO("Mode set to %s", mode.c_str());
            return true;
        }
        ROS_ERROR("Failed to set mode to %s", mode.c_str());
        return false;
    }

    bool armDrone() {
        mavros_msgs::CommandBool arm_srv;
        arm_srv.request.value = true;
        if (arming_client_.call(arm_srv) && arm_srv.response.success) {
            ROS_INFO("Drone armed");
            return true;
        }
        ROS_ERROR("Failed to arm drone");
        return false;
    }

    bool disarmDrone() {
        mavros_msgs::CommandBool disarm_srv;
        disarm_srv.request.value = false;
        if (arming_client_.call(disarm_srv) && disarm_srv.response.success) {
            ROS_INFO("Drone disarmed");
            return true;
        }
        ROS_ERROR("Failed to disarm drone");
        return false;
    }

    void sendPositionSetpoint(double x, double y, double z, double yaw) {
        mavros_msgs::PositionTarget pos_target;
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
        setpoint_pub_.publish(pos_target);
    }
};

int main(int argc, char **argv) {
    ros::init(argc, argv, "aruco_landing_controller");
    ArucoLandingController controller;
    ros::spin();
    return 0;
}