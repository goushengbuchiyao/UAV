#ifndef __CONTROLLER_UTILS_H__
// 防止头文件被重复包含
#define __CONTROLLER_UTILS_H__

// 包含 Eigen 库，用于线性代数运算
#include <Eigen/Eigen>
// 包含数学库，提供常用的数学函数
#include <math.h>
// 包含数值算法库，提供累加等数值计算功能
#include <numeric>

// 使用标准命名空间，避免每次使用标准库中的类和函数时都要写 std::
using namespace std;

/**
 * @brief 期望状态结构体，存储无人机的期望位置、速度、加速度、姿态四元数和偏航角
 */
struct Desired_State
{
    Eigen::Vector3d pos;  // 期望位置，三维向量
    Eigen::Vector3d vel;  // 期望速度，三维向量
    Eigen::Vector3d acc;  // 期望加速度，三维向量
    Eigen::Quaterniond q; // 期望姿态，四元数表示
    double yaw;           // 期望偏航角
};

/**
 * @brief 当前状态结构体，存储无人机的当前位置、速度、姿态四元数和偏航角
 */
struct Current_State
{
    Eigen::Vector3d pos;  // 当前位置，三维向量
    Eigen::Vector3d vel;  // 当前速度，三维向量
    Eigen::Quaterniond q; // 当前姿态，四元数表示
    double yaw;           // 当前偏航角
};

/**
 * @brief PID 控制器参数结构体，存储 PID 控制器所需的各种参数
 */ 
struct Ctrl_Param_PID
{
    float quad_mass;      // 无人机质量
    float tilt_angle_max; // 最大倾斜角度
    float hov_percent;    // 悬停百分比
    Eigen::Vector3d g;    // 重力加速度向量
    Eigen::Vector3f int_max; // 积分项最大值
    Eigen::Matrix3d Kp;   // 比例系数矩阵
    Eigen::Matrix3d Kv;   // 速度反馈系数矩阵
    Eigen::Matrix3d Kvi;  // 速度积分反馈系数矩阵
    Eigen::Matrix3d Ka;   // 加速度反馈系数矩阵
};

/**
 * @brief 基于未知输入观测器（UDE）的控制器参数结构体
 */
struct Ctrl_Param_UDE
{
    double T_ude;         // UDE 控制器的时间常数
    float tilt_angle_max; // 无人机最大倾斜角度
    float quad_mass;      // 无人机质量
    float hov_percent;    // 悬停百分比
    Eigen::Vector3d g;    // 重力加速度向量
    Eigen::Vector3f int_max; // 积分项最大值
    Eigen::Matrix3d Kp;   // 比例控制系数矩阵
    Eigen::Matrix3d Kd;   // 微分控制系数矩阵
};

/**
 * @brief 基于噪声估计器（NE）的控制器参数结构体
 */
struct Ctrl_Param_NE
{
    Eigen::Matrix3d Kp;   // 比例控制系数矩阵
    Eigen::Matrix3d Kd;   // 微分控制系数矩阵
    double T_ude;         // UDE 控制器的时间常数
    double T_ne;          // 噪声估计器的时间常数
    float tilt_angle_max; // 无人机最大倾斜角度
    float quad_mass;      // 无人机质量
    float hov_percent;    // 悬停百分比
    Eigen::Vector3d g;    // 重力加速度向量
    Eigen::Vector3f int_max; // 积分项最大值
};

/**
 * @brief 追踪误差评估类，用于计算并记录无人机追踪过程中的位置和速度误差
 */
class Tracking_Error_Evaluation
{
public:
    /**
     * @brief 默认构造函数
     */
    Tracking_Error_Evaluation() {};

    std::vector<double> pos_error_vector; // 存储位置误差历史值的向量
    std::vector<double> vel_error_vector; // 存储速度误差历史值的向量

    double pos_error_mean{0}; // 位置误差的滑动窗口平均值
    double vel_error_mean{0}; // 速度误差的滑动窗口平均值

    /**
     * @brief 输入位置误差和速度误差，更新误差历史记录和平均值
     * 
     * @param pos_error 三维位置误差向量
     * @param vel_error 三维速度误差向量
     */
    void input_error(Eigen::Vector3d pos_error, Eigen::Vector3d vel_error)
    {
        // 计算位置误差的范数
        double track_error_pos = pos_error.norm();
        // 计算速度误差的范数
        double track_error_vel = vel_error.norm();
        // 将位置误差插入到向量头部
        pos_error_vector.insert(pos_error_vector.begin(), track_error_pos);
        // 将速度误差插入到向量头部
        vel_error_vector.insert(vel_error_vector.begin(), track_error_vel);
        
        // 若位置误差向量长度超过滑动窗口大小，移除末尾元素
        if (pos_error_vector.size() > Slide_window)
        {
            pos_error_vector.pop_back();
        }
        // 若速度误差向量长度超过滑动窗口大小，移除末尾元素
        if (vel_error_vector.size() > Slide_window)
        {
            vel_error_vector.pop_back();
        }
        
        // 计算速度误差的滑动窗口平均值
        vel_error_mean = std::accumulate(vel_error_vector.begin(), vel_error_vector.end(), 0.0) / vel_error_vector.size();
        // 计算位置误差的滑动窗口平均值
        pos_error_mean = std::accumulate(pos_error_vector.begin(), pos_error_vector.end(), 0.0) / pos_error_vector.size();
    }

private:
    int Slide_window = 100; // 滑动窗口大小，用于限制误差历史记录的数量
};

/**
 * @brief 控制器工具命名空间，用于组织相关的类、结构体和函数
 */
namespace controller_utils 
{

}

#endif