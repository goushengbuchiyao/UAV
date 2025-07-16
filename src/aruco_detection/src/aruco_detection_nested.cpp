#include <ros/ros.h>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/image_encodings.h>
#include <opencv2/opencv.hpp>
#include <opencv2/aruco.hpp>
#include <eigen3/Eigen/Dense>
#include <geometry_msgs/PoseStamped.h>
#include <px_uav_msgs/TargetsInFrame.h>
#include <mavros_msgs/State.h>
#include <yaml-cpp/yaml.h>
#include <ros/package.h>
class ARQRDetector {
private:
    ros::NodeHandle nh_;
    image_transport::ImageTransport it_;
    image_transport::Subscriber image_sub_;
    image_transport::Publisher image_pub_;
    // 发布 坐标的发布器
    ros::Publisher aruco_land_pub_; 
    cv::Ptr<cv::aruco::Dictionary> dictionary_;
    // 相机内参矩阵
    cv::Mat cameraMatrix;
    // 畸变系数
    cv::Mat distCoeffs;
    // // ArUco 标记的尺寸（单位：米）
    // float markerLength = 0.1; 
    // // 无人机相对于 ENU 坐标系的旋转矩阵
    // Eigen::Matrix3d R_drone_to_enu;
    // // 无人机相对于 ENU 坐标系的平移向量
    // Eigen::Vector3d t_drone_to_enu;
    Eigen::Vector3d uav_pose;
    // 相机相对于无人机坐标系的旋转矩阵（绕 x 轴旋转 180 度）
    Eigen::Matrix3d R_camera_to_drone;
    // 相机相对于无人机坐标系的平移向量（假设为零）
    Eigen::Vector3d t_camera_to_drone = Eigen::Vector3d::Zero();
    // 订阅无人机位姿话题的订阅者
    ros::Subscriber drone_pose_sub;
    // ArUco 外层标记的尺寸（单位：米）
    float outerMarkerLength = 0.1; 
    // ArUco 内层标记的尺寸（单位：米）
    float innerMarkerLength = 0.01; 
    // 订阅飞机状态话题的订阅者
    ros::Subscriber state_sub; 
    // 飞机当前状态
    mavros_msgs::State current_state; 

public:
    ARQRDetector() : it_(nh_) {

        // Load parameters from YAML file
        std::string pkg_path = ros::package::getPath("aruco_detection");
        std::string yaml_path = pkg_path + "/config/aruco_cam_params.yaml";
        YAML::Node config = YAML::LoadFile(yaml_path);
        outerMarkerLength = config["outerMarkerLength"].as<float>();
        innerMarkerLength = config["innerMarkerLength"].as<float>();

        // 订阅图像话题
        image_sub_ = it_.subscribe("/iris/usb_cam/image_raw", 1, &ARQRDetector::imageCallback, this);
        // 发布检测结果图像话题
        image_pub_ = it_.advertise("/ar_qr_detection/result", 1);
        // 初始化机体系坐标发布器
        aruco_land_pub_ = nh_.advertise<px_uav_msgs::TargetsInFrame>("/ar_qr_detection/aruco_land_pose", 1); 
        // 获取 ArUco 字典
        dictionary_ = cv::aruco::getPredefinedDictionary(cv::aruco::DICT_6X6_1000);

        // Camera parameters
        double focalLength = config["camera"]["focalLength"].as<double>();
        double Cx = config["camera"]["Cx"].as<double>();
        double Cy = config["camera"]["Cy"].as<double>();
        double distortionK1 = config["camera"]["distortion"]["k1"].as<double>();
        double distortionK2 = config["camera"]["distortion"]["k2"].as<double>();
        double distortionK3 = config["camera"]["distortion"]["k3"].as<double>();
        double distortionT1 = config["camera"]["distortion"]["t1"].as<double>();
        double distortionT2 = config["camera"]["distortion"]["t2"].as<double>();

        // 初始化相机内参矩阵
        cameraMatrix = (cv::Mat_<double>(3, 3) << focalLength, 0, Cx, 0, focalLength, Cy, 0, 0, 1);
        // 初始化畸变系数
        distCoeffs = (cv::Mat_<double>(5, 1) << distortionK1, distortionK2, distortionT1, distortionT2, distortionK3);

        // 初始化相机到无人机的旋转矩阵（绕 x 轴旋转 180 度）
        double theta = M_PI;
        R_camera_to_drone << 1, 0, 0,
                             0, cos(theta), -sin(theta),
                             0, sin(theta), cos(theta);

        // 订阅无人机位姿话题
        drone_pose_sub = nh_.subscribe("/uav1/mavros/local_position/pose", 1, &ARQRDetector::dronePoseCallback, this);
        state_sub = nh_.subscribe("/uav1/mavros/state", 1, &ARQRDetector::stateCallback, this); 

    }

    void dronePoseCallback(const geometry_msgs::PoseStamped::ConstPtr& msg) {
        // 从消息中提取旋转矩阵
        Eigen::Quaterniond q(
            msg->pose.orientation.w,
            msg->pose.orientation.x,
            msg->pose.orientation.y,
            msg->pose.orientation.z
        );
        // R_drone_to_enu = q.toRotationMatrix();

        // 从消息中提取平移向量
        uav_pose << 
            msg->pose.position.x,
            msg->pose.position.y,
            msg->pose.position.z;
    }
     // 飞机状态回调函数
    void stateCallback(const mavros_msgs::State::ConstPtr& msg) {
        current_state = *msg;
        // 检查飞机是否上锁
        if (!current_state.armed) { 
            ROS_INFO("Vehicle is disarmed, shutting down...");
            ros::shutdown();
        }
    }
    void imageCallback(const sensor_msgs::ImageConstPtr& msg) {
        try {
            // 将 ROS 图像消息转换为 OpenCV 图像
            cv_bridge::CvImagePtr cv_ptr = cv_bridge::toCvCopy(msg, sensor_msgs::image_encodings::BGR8);

            // 存储检测到的标记 ID 和角点
            std::vector<int> ids;
            std::vector<std::vector<cv::Point2f>> corners;

            // 创建检测参数
            cv::Ptr<cv::aruco::DetectorParameters> parameters = cv::aruco::DetectorParameters::create();
            // 调整自适应阈值窗口大小
            parameters->adaptiveThreshWinSizeMin = 3;
            parameters->adaptiveThreshWinSizeMax = 41; // 增大最大窗口大小
            parameters->adaptiveThreshWinSizeStep = 2;
            // 调整最小边缘长度，适应大尺寸二维码
            parameters->minMarkerPerimeterRate = 0.05; // 增大最小周长比例
            parameters->maxMarkerPerimeterRate = 4.0;
            // 调整多边形逼近精度
            parameters->polygonalApproxAccuracyRate = 0.02; // 减小逼近精度

            // 检测 ArUco 标记
            cv::aruco::detectMarkers(cv_ptr->image, dictionary_, corners, ids, parameters);

            if (ids.empty()){
                ROS_INFO("No arucos are deteted!!!");
            }else{
                
            std::vector<cv::Vec3d> out_rvecs, out_tvecs, in_rvecs, in_tvecs;


            // 初始化消息
            px_uav_msgs::TargetsInFrame aruco_land_msg;

            // 查找外层和内层标记
            bool outerMarkerFound = false;
            bool innerMarkerFound = false;
            size_t outerIndex = 0;
            size_t innerIndex = 0;

            for (size_t i = 0; i < ids.size(); ++i) {
                if (ids[i] == 18) {
                    outerMarkerFound = true;
                    outerIndex = i;
                } else if (ids[i] == 1) {
                    innerMarkerFound = true;
                    innerIndex = i;
                } 
            }

            if (outerMarkerFound) {
                
                // 估计外层标记的位姿
                cv::aruco::estimatePoseSingleMarkers(std::vector<std::vector<cv::Point2f>>{corners[outerIndex]}, outerMarkerLength, cameraMatrix, distCoeffs, out_rvecs, out_tvecs);

                // 在图像上绘制外层标记和坐标轴
                cv::aruco::drawDetectedMarkers(cv_ptr->image, std::vector<std::vector<cv::Point2f>>{corners[outerIndex]}, std::vector<int>{ids[outerIndex]});
                cv::aruco::drawAxis(cv_ptr->image, cameraMatrix, distCoeffs,  out_rvecs, out_tvecs, outerMarkerLength * 0.5);

                // 将 OpenCV 的平移向量转换为 Eigen 向量
                Eigen::Vector3d t_camera_outer(
                    out_tvecs[0][0],
                    out_tvecs[0][1],
                    out_tvecs[0][2]
                );

                // 先将相机坐标系下的坐标转换到无人机坐标系
                Eigen::Vector3d t_drone_outer = R_camera_to_drone * t_camera_outer + t_camera_to_drone;

                // 确保 targets 数组有足够的空间
                if (aruco_land_msg.targets.size() <= ids.size()) {
                    aruco_land_msg.targets.resize(ids.size());
                }
                aruco_land_msg.targets[outerIndex].tracked_id = ids[outerIndex]; // 添加标记 ID
                aruco_land_msg.targets[outerIndex].px = t_drone_outer[0];
                aruco_land_msg.targets[outerIndex].py = t_drone_outer[1];
                aruco_land_msg.targets[outerIndex].pz = t_drone_outer[2];
                aruco_land_msg.targets[outerIndex].yaw_a = 0.0;

                // 在终端输出外层标记检测信息
                ROS_INFO("Detected Outer ArUco Marker: ID=%d, UAV Coordinates=(%.2f, %.2f, %.2f)",
                         ids[outerIndex], t_drone_outer[0], t_drone_outer[1], t_drone_outer[2]);
            }

            if (innerMarkerFound) {
                // 估计内层标记的位姿
                cv::aruco::estimatePoseSingleMarkers(std::vector<std::vector<cv::Point2f>>{corners[innerIndex]}, innerMarkerLength, cameraMatrix, distCoeffs, in_rvecs, in_tvecs);

                // 在图像上绘制内层标记和坐标轴
                cv::aruco::drawDetectedMarkers(cv_ptr->image, std::vector<std::vector<cv::Point2f>>{corners[innerIndex]}, std::vector<int>{ids[innerIndex]});
                cv::aruco::drawAxis(cv_ptr->image, cameraMatrix, distCoeffs, in_rvecs, in_tvecs, innerMarkerLength * 0.5);

                // 将 OpenCV 的平移向量转换为 Eigen 向量
                Eigen::Vector3d t_camera_inner(
                    in_tvecs[0][0],
                    in_tvecs[0][1],
                    in_tvecs[0][2]
                );

                // 先将相机坐标系下的坐标转换到无人机坐标系
                Eigen::Vector3d t_drone_inner = R_camera_to_drone * t_camera_inner + t_camera_to_drone;

                // 确保 targets 数组有足够的空间
                if (aruco_land_msg.targets.size() <= ids.size()) {
                    aruco_land_msg.targets.resize(ids.size());
                }
                aruco_land_msg.targets[innerIndex].tracked_id = ids[innerIndex]; // 添加标记 ID
                aruco_land_msg.targets[innerIndex].px = t_drone_inner[0];
                aruco_land_msg.targets[innerIndex].py = t_drone_inner[1];
                aruco_land_msg.targets[innerIndex].pz = t_drone_inner[2];
                aruco_land_msg.targets[innerIndex].yaw_a = 0.0;

                // 在终端输出内层标记检测信息
                ROS_INFO("Detected Inner ArUco Marker: ID=%d, UAV Coordinates=(%.2f, %.2f, %.2f)",
                         ids[innerIndex], t_drone_inner[0], t_drone_inner[1], t_drone_inner[2]);
            }

            // 发布机体系坐标消息
            if (outerMarkerFound || innerMarkerFound) {
                aruco_land_pub_.publish(aruco_land_msg);
                // 发布处理后的图像
                image_pub_.publish(cv_ptr->toImageMsg());

                // 显示处理后的图像
                cv::namedWindow("AR QR Detection Result", cv::WINDOW_NORMAL);
                cv::resizeWindow("AR QR Detection Result", 800, 600);
                cv::imshow("AR QR Detection Result", cv_ptr->image);
                cv::waitKey(1); // 等待 1 毫秒，用于处理窗口事件
            }
            
            }

        } catch (cv_bridge::Exception& e) {
            ROS_ERROR("cv_bridge exception: %s", e.what());
        }
    }
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "ar_qr_detection");
    ARQRDetector detector;
    // 在程序退出时销毁所有 OpenCV 窗口
    cv::namedWindow("AR QR Detection Result", cv::WINDOW_NORMAL);
    cv::startWindowThread();
    ros::spin();
    cv::destroyAllWindows();
    return 0;
}