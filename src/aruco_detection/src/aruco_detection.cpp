#include <ros/ros.h>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/image_encodings.h>
#include <opencv2/opencv.hpp>
#include <opencv2/aruco.hpp>
#include <eigen3/Eigen/Dense>
#include <geometry_msgs/PoseStamped.h>

class ARQRDetector {
private:
    ros::NodeHandle nh_;
    image_transport::ImageTransport it_;
    image_transport::Subscriber image_sub_;
    image_transport::Publisher image_pub_;
    // 新增：发布 ENU 坐标的发布器
    ros::Publisher aruco_land_pub_; 
    cv::Ptr<cv::aruco::Dictionary> dictionary_;
    // 相机内参矩阵
    cv::Mat cameraMatrix;
    // 畸变系数
    cv::Mat distCoeffs;
    // ArUco 标记的尺寸（单位：米）
    float markerLength = 0.1; 
    // 无人机相对于 ENU 坐标系的旋转矩阵
    Eigen::Matrix3d R_drone_to_enu;
    // 无人机相对于 ENU 坐标系的平移向量
    Eigen::Vector3d t_drone_to_enu;
    // 相机相对于无人机坐标系的旋转矩阵（绕 x 轴旋转 180 度）
    Eigen::Matrix3d R_camera_to_drone;
    // 相机相对于无人机坐标系的平移向量（假设为零）
    Eigen::Vector3d t_camera_to_drone = Eigen::Vector3d::Zero();
    // 订阅无人机位姿话题的订阅者
    ros::Subscriber drone_pose_sub;

public:
    ARQRDetector() : it_(nh_) {
        // 订阅图像话题
        image_sub_ = it_.subscribe("/iris/usb_cam/image_raw", 1, &ARQRDetector::imageCallback, this);
        // 发布检测结果图像话题
        image_pub_ = it_.advertise("/ar_qr_detection/result", 1);
        // 新增：初始化 ENU 坐标发布器
        aruco_land_pub_ = nh_.advertise<geometry_msgs::PoseStamped>("/ar_qr_detection/aruco_land_pose", 1); 
        // 获取 ArUco 字典
        dictionary_ = cv::aruco::getPredefinedDictionary(cv::aruco::DICT_6X6_1000);

        // 从 fpv_cam.sdf 文件中提取的相机内参
        double focalLength = 277.191356;
        double Cx = 320.5;
        double Cy = 240.5;
        double distortionK1 = 0.0;
        double distortionK2 = 0.0;
        double distortionK3 = 0.0;
        double distortionT1 = 0.0;
        double distortionT2 = 0.0;

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
        drone_pose_sub = nh_.subscribe("uav1/mavros/local_position/pose", 1, &ARQRDetector::dronePoseCallback, this);
    }

    void dronePoseCallback(const geometry_msgs::PoseStamped::ConstPtr& msg) {
        // 从消息中提取旋转矩阵
        Eigen::Quaterniond q(
            msg->pose.orientation.w,
            msg->pose.orientation.x,
            msg->pose.orientation.y,
            msg->pose.orientation.z
        );
        R_drone_to_enu = q.toRotationMatrix();

        // 从消息中提取平移向量
        t_drone_to_enu << 
            msg->pose.position.x,
            msg->pose.position.y,
            msg->pose.position.z;
        ROS_INFO("Drone Pose: ENU Coordinates=(%.2f, %.2f, %.2f)", 
                 t_drone_to_enu[0], t_drone_to_enu[1], t_drone_to_enu[2]);
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
            // cv::aruco::detectMarkers(cv_ptr->image, dictionary_, corners, ids);
            std::vector<cv::Vec3d> rvecs, tvecs;
            if (ids.size() > 0) {
                // 估计标记的位姿
                cv::aruco::estimatePoseSingleMarkers(corners, markerLength, cameraMatrix, distCoeffs, rvecs, tvecs);

                // 在图像上绘制检测到的标记和坐标轴
                for (size_t i = 0; i < ids.size(); ++i) {
                    cv::aruco::drawDetectedMarkers(cv_ptr->image, corners, ids);
                    cv::aruco::drawAxis(cv_ptr->image, cameraMatrix, distCoeffs, rvecs[i], tvecs[i], markerLength * 0.5);

                    // 将 OpenCV 的平移向量转换为 Eigen 向量
                    Eigen::Vector3d t_camera_marker(
                        tvecs[i][0],
                        tvecs[i][1],
                        tvecs[i][2]
                    );
                    // 在终端输出标记检测信息和旋转向量
                    ROS_INFO("Detected ArUco Marker: ID=%d,  rvecs=(%.2f, %.2f, %.2f)", 
                             ids[i], rvecs[i][0], rvecs[i][1], rvecs[i][2]);
                    // 在终端输出标记检测信息和平移向量
                    ROS_INFO("Detected ArUco Marker: ID=%d, tvecs=(%.2f, %.2f, %.2f)", 
                             ids[i], tvecs[i][0], tvecs[i][1], tvecs[i][2]);

                    // 先将相机坐标系下的坐标转换到无人机坐标系
                    Eigen::Vector3d t_drone_marker = R_camera_to_drone * t_camera_marker + t_camera_to_drone;
                    ROS_INFO("Detected ArUco Marker: ID=%d, UAV Coordinates=(%.2f, %.2f, %.2f)",
                             ids[i], t_drone_marker[0], t_drone_marker[1], t_drone_marker[2]);

                    // 再将无人机坐标系下的坐标转换到 ENU 坐标系
                    // Eigen::Vector3d t_enu_marker = R_drone_to_enu * t_drone_marker + t_drone_to_enu;

                    // 创建 PoseStamped 消息
                    geometry_msgs::PoseStamped aruco_land_msg;
                    aruco_land_msg.header.stamp = ros::Time::now();
                    aruco_land_msg.header.frame_id = "enu";
                    aruco_land_msg.pose.position.x = t_drone_marker[0];
                    aruco_land_msg.pose.position.y = t_drone_marker[1];
                    aruco_land_msg.pose.position.z = t_drone_marker[2];
                    // // 假设姿态为单位四元数，可根据实际情况修改
                    // aruco_land_msg.pose.orientation.w = 1.0;
                    // aruco_land_msg.pose.orientation.x = 0.0;
                    // aruco_land_msg.pose.orientation.y = 0.0;
                    // aruco_land_msg.pose.orientation.z = 0.0;

                    //发布 坐标消息
                    aruco_land_pub_.publish(aruco_land_msg);

                    // 在终端输出标记检测信息和 ENU 坐标系下的坐标
                    // ROS_INFO("Detected ArUco Marker: ID=%d, ENU Coordinates=(%.2f, %.2f, %.2f)",
                            //  ids[i], t_enu_marker[0], t_enu_marker[1], t_enu_marker[2]);
                }
            }

            // 发布处理后的图像
            image_pub_.publish(cv_ptr->toImageMsg());

            // 显示处理后的图像
            cv::namedWindow("AR QR Detection Result", cv::WINDOW_NORMAL);
            cv::resizeWindow("AR QR Detection Result", 800, 600);
            cv::imshow("AR QR Detection Result", cv_ptr->image);
            cv::waitKey(1); // 等待 1 毫秒，用于处理窗口事件

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
