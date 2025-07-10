#include <ros/ros.h>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/image_encodings.h>
#include <opencv2/opencv.hpp>
#include <opencv2/aruco.hpp>

class ARQRDetector {
private:
    ros::NodeHandle nh_;
    image_transport::ImageTransport it_;
    image_transport::Subscriber image_sub_;
    image_transport::Publisher image_pub_;
    cv::Ptr<cv::aruco::Dictionary> dictionary_;
    // 相机内参矩阵
    cv::Mat cameraMatrix;
    // 畸变系数
    cv::Mat distCoeffs;
    // ArUco 标记的尺寸（单位：米）
    float markerLength = 0.8; 

public:
    ARQRDetector() : it_(nh_) {
        // 订阅图像话题
        image_sub_ = it_.subscribe("/iris/usb_cam/image_raw", 1, &ARQRDetector::imageCallback, this);
        // 发布检测结果图像话题
        image_pub_ = it_.advertise("/ar_qr_detection/result", 1);
        // 获取 ArUco 字典
        dictionary_ = cv::aruco::getPredefinedDictionary(cv::aruco::DICT_6X6_1000);

        // 初始化相机内参矩阵和畸变系数，这里需要根据实际标定结果修改
        cameraMatrix = (cv::Mat_<double>(3, 3) << 1000, 0, 320, 0, 1000, 240, 0, 0, 1);
        distCoeffs = cv::Mat::zeros(5, 1, CV_64F);
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
            parameters->adaptiveThreshWinSizeMin = 3;
            parameters->adaptiveThreshWinSizeMax = 33;
            parameters->adaptiveThreshWinSizeStep = 2;

            // 检测 ArUco 标记
            cv::aruco::detectMarkers(cv_ptr->image, dictionary_, corners, ids, parameters);

            std::vector<cv::Vec3d> rvecs, tvecs;
            if (ids.size() > 0) {
                // 估计标记的位姿
                cv::aruco::estimatePoseSingleMarkers(corners, markerLength, cameraMatrix, distCoeffs, rvecs, tvecs);

                // 在图像上绘制检测到的标记和坐标轴
                for (size_t i = 0; i < ids.size(); ++i) {
                    cv::aruco::drawDetectedMarkers(cv_ptr->image, corners, ids);
                    cv::aruco::drawAxis(cv_ptr->image, cameraMatrix, distCoeffs, rvecs[i], tvecs[i], markerLength * 0.5);
                    // 在终端输出标记检测信息和旋转向量
                    ROS_INFO("Detected ArUco Marker: ID=%d,  rvecs=(%.2f, %.2f, %.2f)", 
                             ids[i], rvecs[i][0], rvecs[i][1], rvecs[i][2]);
                    // 在终端输出标记检测信息和平移向量
                    ROS_INFO("Detected ArUco Marker: ID=%d, tvecs=(%.2f, %.2f, %.2f)", 
                             ids[i], tvecs[i][0], tvecs[i][1], tvecs[i][2]);
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