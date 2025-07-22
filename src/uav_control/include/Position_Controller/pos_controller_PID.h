#ifndef POS_CONTROLLER_PID_H
#define POS_CONTROLLER_PID_H

// 包含ROS相关头文件，用于节点句柄和消息传递
#include <ros/ros.h>
// 包含数学库头文件，提供数学函数
#include <math.h>
// 包含Eigen库头文件，用于矩阵和向量运算
#include <Eigen/Eigen>
// 包含自定义的无人机状态消息头文件
#include <px_uav_msgs/UAVState.h>

// 包含自定义的数学工具头文件
#include "math_utils.h"
// 包含自定义的控制器工具头文件
#include "controller_utils.h"
// 包含自定义的几何工具头文件
#include "geometry_utils.h"
// 包含自定义的打印工具头文件
#include "printf_utils.h"

// 使用标准命名空间
using namespace std;
 
/**
 * @brief 位置PID控制器类，用于计算无人机的期望姿态和油门
 */
class pos_controller_PID
{
    public:
        /**
         * @brief 默认构造函数
         */
        pos_controller_PID(){};

        /**
         * @brief 初始化控制器参数，从ROS参数服务器加载参数
         * 
         * @param nh ROS节点句柄，用于访问参数服务器
         */
        void init(ros::NodeHandle& nh);

        /**
         * @brief 设置无人机的期望状态
         * 
         * @param des 期望状态结构体，包含期望位置、速度、加速度、姿态和偏航角
         */
        void set_desired_state(const Desired_State& des)
        {
            // 将传入的期望状态赋值给类成员变量
            desired_state = des;
        }

        /**
         * @brief 设置无人机的当前状态
         * 
         * @param state 无人机当前状态消息，包含位置、速度和姿态信息
         */
        void set_current_state(const px_uav_msgs::UAVState& state)
        {
            // 将传入的无人机状态消息赋值给类成员变量
            uav_state = state;

            // 遍历三维向量，将无人机的位置和速度信息赋值给当前状态结构体
            for(int i=0; i<3; i++)
            {
                current_state.pos(i) = uav_state.position[i];
                current_state.vel(i) = uav_state.velocity[i];
            }
            // 将无人机的姿态四元数信息从消息结构体赋值给当前状态结构体
            current_state.q.w() = uav_state.attitude_q.w;
            current_state.q.x() = uav_state.attitude_q.x;
            current_state.q.y() = uav_state.attitude_q.y;
            current_state.q.z() = uav_state.attitude_q.z; 
            // 利用几何工具函数，从四元数中提取当前的偏航角并赋值给当前状态结构体
            current_state.yaw = geometry_utils::get_yaw_from_quaternion(current_state.q);
        }

        /**
         * @brief 打印控制器参数
         */
        void printf_param();
        /**
         * @brief 打印控制器结果
         */
        void printf_result();
        /**
         * @brief 更新控制器，计算期望的姿态和油门
         * 
         * @param controller_hz 控制器更新频率
         * @return Eigen::Vector4d 包含期望滚转角、俯仰角、偏航角和油门的四维向量
         */
        Eigen::Vector4d update(float controller_hz);

    private:
        // 控制器的参数结构体，存储PID控制参数、无人机质量等信息
        Ctrl_Param_PID ctrl_param;
        // 无人机的期望状态结构体，包含期望位置、速度、加速度、姿态和偏航角
        Desired_State desired_state;
        // 无人机的当前状态结构体，包含当前位置、速度、姿态和偏航角
        Current_State current_state;
        // 存储无人机当前状态的消息对象
        px_uav_msgs::UAVState uav_state; 
        // 期望的力向量，基于模型的位置控制器计算得到的三轴期望推力（惯性系），量纲为牛
        Eigen::Vector3d F_des;

        // 追踪误差评估对象，用于计算并记录无人机追踪过程中的位置和速度误差
        Tracking_Error_Evaluation tracking_error;
        // 误差积分项，用于PID控制器的积分环节
        Eigen::Vector3d int_e_v;            // 积分
        // 期望的姿态四元数，表示无人机期望的姿态
        Eigen::Quaterniond u_q_des;         // 期望姿态角（四元数）
        // 期望的姿态角和油门，包含滚转角、俯仰角、偏航角和油门
        Eigen::Vector4d u_att;              // 期望姿态角（rad）+期望油门（0-1）
};

/**
 * @brief 初始化位置PID控制器的参数，从ROS参数服务器加载相关参数
 * 
 * @param nh ROS节点句柄，用于访问ROS参数服务器
 */
void pos_controller_PID::init(ros::NodeHandle& nh)
{
    // 【参数】控制参数，将比例系数、速度反馈系数、速度积分反馈系数、加速度反馈系数矩阵初始化为零矩阵
    
    ctrl_param.Kp.setZero();//比例系数矩阵
    ctrl_param.Kv.setZero();//速度反馈系数矩阵
    ctrl_param.Kvi.setZero();//速度积分反馈系数矩阵
    ctrl_param.Ka.setZero();//加速度反馈系数矩阵
     // 【参数】从ROS参数服务器获取无人机质量，默认值为1.0f
    nh.param<float>("pid_gain/quad_mass" , ctrl_param.quad_mass, 1.0f);
    // 【参数】从ROS参数服务器获取悬停油门百分比，默认值为0.5f
    nh.param<float>("pid_gain/hov_percent" , ctrl_param.hov_percent, 0.5f);
    // 【参数】从ROS参数服务器获取XY轴积分上限，默认值为0.5
    nh.param<float>("pid_gain/pxy_int_max"  , ctrl_param.int_max[0], 0.5);
    nh.param<float>("pid_gain/pxy_int_max"  , ctrl_param.int_max[1], 0.5);
    // 【参数】从ROS参数服务器获取Z轴积分上限，默认值为0.5
    nh.param<float>("pid_gain/pz_int_max"   , ctrl_param.int_max[2], 0.5);
    // 【参数】从ROS参数服务器获取XY轴位置比例增益，默认值为2.0f
    nh.param<double>("pid_gain/Kp_xy", ctrl_param.Kp(0,0), 2.0f);
    nh.param<double>("pid_gain/Kp_xy", ctrl_param.Kp(1,1), 2.0f);
    // 【参数】从ROS参数服务器获取Z轴位置比例增益，默认值为2.0f
    nh.param<double>("pid_gain/Kp_z" , ctrl_param.Kp(2,2), 2.0f);
    // 【参数】从ROS参数服务器获取XY轴速度比例增益，默认值为2.0f
    nh.param<double>("pid_gain/Kv_xy", ctrl_param.Kv(0,0), 2.0f);
    nh.param<double>("pid_gain/Kv_xy", ctrl_param.Kv(1,1), 2.0f);
    // 【参数】从ROS参数服务器获取Z轴速度比例增益，默认值为2.0f
    nh.param<double>("pid_gain/Kv_z" , ctrl_param.Kv(2,2), 2.0f);
    // 【参数】从ROS参数服务器获取XY轴速度积分增益，默认值为0.3f
    nh.param<double>("pid_gain/Kvi_xy", ctrl_param.Kvi(0,0), 0.3f);
    nh.param<double>("pid_gain/Kvi_xy", ctrl_param.Kvi(1,1), 0.3f);
    // 【参数】从ROS参数服务器获取Z轴速度积分增益，默认值为0.3f
    nh.param<double>("pid_gain/Kvi_z" , ctrl_param.Kvi(2,2), 0.3f);
    // 【参数】从ROS参数服务器获取最大倾斜角度，默认值为10.0f
    nh.param<float>("pid_gain/tilt_angle_max" , ctrl_param.tilt_angle_max, 10.0f);
    // 重力加速度向量，单位：m/s²
    ctrl_param.g << 0.0, 0.0, 9.8;
    
    printf_param();
}

// 输入：
// 无人机位置、速度、偏航角
// 期望位置、速度、加速度、偏航角
// 输出：
// 期望姿态 + 期望油门
/**
 * @brief 更新位置PID控制器，计算期望的姿态和油门
 * 
 * @param controller_hz 控制器更新频率，用于积分计算
 * @return Eigen::Vector4d 包含期望滚转角、俯仰角、偏航角和油门的四维向量
 */
Eigen::Vector4d pos_controller_PID::update(float controller_hz)
{
    // 定点控制的时候才积分，即追踪轨迹或者速度追踪时不进行积分
    // 当期望速度在任一轴上不为 0 时，认为非定点控制，重置积分项
    if (desired_state.vel(0) != 0.0 || desired_state.vel(1) != 0.0 || desired_state.vel(2) != 0.0) 
    {
        // 输出警告信息，提示积分项已重置
        PCOUT(2, YELLOW, "Reset integration.");
        // 将误差积分项置零
        int_e_v.setZero();
    }

    // 计算位置误差，即期望位置与当前位置的差值
    Eigen::Vector3d pos_error = desired_state.pos - current_state.pos;
    // 计算速度误差，即期望速度与当前速度的差值
    Eigen::Vector3d vel_error = desired_state.vel - current_state.vel;
    
    // 将位置误差和速度误差输入到追踪误差评估对象中
    tracking_error.input_error(pos_error,vel_error);

    // 定义最大位置误差阈值，单位：米
    float max_pos_error = 3.0;
    // 定义最大速度误差阈值，单位：米/秒
    float max_vel_error = 3.0;

    // 遍历三维向量，对每个轴的误差进行限幅处理
    for (int i=0; i<3; i++)
    {
        // 若位置误差超过最大位置误差阈值
        if(abs(pos_error[i]) > max_pos_error)
        {            
            // 根据误差正负，将位置误差限制为 1 或 -1
            pos_error[i] = (pos_error[i] > 0) ? 1.0 : -1.0;
        }
        // 若速度误差超过最大速度误差阈值
        if(abs(vel_error[i]) > max_vel_error)
        {            
            // 根据误差正负，将速度误差限制为 2 或 -2
            vel_error[i] = (vel_error[i] > 0) ? 2.0 : -2.0;
        }
    }

    // 积分项 - XY 轴
    for (int i=0; i<2; i++)
    {
        // 定义积分启动的位置误差阈值，仅当位置误差小于该值时才启动积分
        float int_start_error = 0.2;
        // 当位置误差小于阈值且无人机处于 OFFBOARD 模式时
        if(abs(pos_error[i]) < int_start_error && uav_state.mode == "OFFBOARD")
        {
            // 对位置误差进行积分，积分步长为误差除以控制器更新频率
            int_e_v[i] += pos_error[i] / controller_hz;
            // 若积分项超过积分上限
            if(abs(int_e_v[i]) > ctrl_param.int_max[i])
            {
                // 输出警告信息，提示 XY 轴积分项饱和
                PCOUT(2, YELLOW, "int_e_v saturation [ xy ]");
                // 根据积分项正负，将积分项限制为积分上限或负积分上限
                int_e_v[i] = (int_e_v[i] > 0) ? ctrl_param.int_max[i] : -ctrl_param.int_max[i];
            }
        }
        else
        {
            // 不满足积分条件时，将积分项置零
            int_e_v[i] = 0;
        }
    }

    // 积分项 - Z 轴
    // 定义 Z 轴积分启动的位置误差阈值
    float int_start_error = 0.5;
    // 当 Z 轴位置误差小于阈值且无人机处于 OFFBOARD 模式时
    if(abs(pos_error[2]) < int_start_error && uav_state.mode == "OFFBOARD")
    {
        // 对 Z 轴位置误差进行积分
        int_e_v[2] += pos_error[2] / controller_hz;

        // 若 Z 轴积分项超过积分上限
        if(abs(int_e_v[2]) > ctrl_param.int_max[2])
        {
            // 输出警告信息，提示 Z 轴积分项饱和
            PCOUT(2, YELLOW, "int_e_v saturation [ z ]");
            // 根据积分项正负，将 Z 轴积分项限制为积分上限或负积分上限
            int_e_v[2] = (int_e_v[2] > 0) ? ctrl_param.int_max[2] : -ctrl_param.int_max[2];
        }
    }
    else
    {
        // 不满足积分条件时，将 Z 轴积分项置零
        int_e_v[2] = 0;
    }

    // 计算期望加速度，由期望加速度、位置误差比例项、速度误差比例项和积分项组成
    Eigen::Vector3d des_acc = desired_state.acc + ctrl_param.Kp * pos_error + ctrl_param.Kv * vel_error + ctrl_param.Kvi * int_e_v;

	// 期望力 = 质量*控制量 + 重力抵消
    // F_des是基于模型的位置控制器计算得到的三轴期望推力（惯性系），量纲为牛
    // u_att是用于PX4的姿态控制输入，u_att 前三位是roll pitch yaw， 第四位为油门值[0-1]
    // 计算期望力，基于模型的位置控制器计算得到的三轴期望推力（惯性系），量纲为牛
    // 期望力等于质量乘以控制量（期望加速度）再加上重力抵消项
    F_des = des_acc * ctrl_param.quad_mass + ctrl_param.quad_mass * ctrl_param.g;

    // 如果向上推力小于重力的一半
    if (F_des(2) < 0.5 * ctrl_param.quad_mass * ctrl_param.g(2))
    {
        // 按比例调整期望力，使其等于重力的一半
        F_des = F_des / F_des(2) * (0.5 * ctrl_param.quad_mass * ctrl_param.g(2));
    }
    // 如果向上推力大于重力的两倍
    else if (F_des(2) > 2 * ctrl_param.quad_mass * ctrl_param.g(2))
    {
        // 按比例调整期望力，使其等于重力的两倍
        F_des = F_des / F_des(2) * (2 * ctrl_param.quad_mass * ctrl_param.g(2));
    }

    // 角度限制幅度 - 俯仰角
    // 若 X 轴期望力与 Z 轴期望力的比值的绝对值超过最大倾斜角度的正切值
    if (std::fabs(F_des(0)/F_des(2)) > std::tan(geometry_utils::toRad(ctrl_param.tilt_angle_max)))
    {
        // 输出警告信息，提示俯仰角倾斜过大
        PCOUT(2, YELLOW, "pitch too tilt");
        // 根据 X 轴期望力的正负，将 X 轴期望力限制为最大倾斜角度对应的力
        F_des(0) = F_des(0)/std::fabs(F_des(0)) * F_des(2) * std::tan(geometry_utils::toRad(ctrl_param.tilt_angle_max));
    }

    // 角度限制幅度 - 滚转角
    // 若 Y 轴期望力与 Z 轴期望力的比值的绝对值超过最大倾斜角度的正切值
    if (std::fabs(F_des(1)/F_des(2)) > std::tan(geometry_utils::toRad(ctrl_param.tilt_angle_max)))
    {
        // 输出警告信息，提示滚转角倾斜过大
        PCOUT(2, YELLOW, "roll too tilt");
        // 根据 Y 轴期望力的正负，将 Y 轴期望力限制为最大倾斜角度对应的力
        F_des(1) = F_des(1)/std::fabs(F_des(1)) * F_des(2) * std::tan(geometry_utils::toRad(ctrl_param.tilt_angle_max));	
    }

    // F_des 是位于 ENU 坐标系的，F_c 是 FLU 坐标系
    // 通过绕 Z 轴旋转矩阵将惯性系下的期望力转换到机体系下
    Eigen::Matrix3d wRc = geometry_utils::rotz(current_state.yaw);
    Eigen::Vector3d F_c = wRc.transpose() * F_des;
    // 提取机体系下 X 轴期望力
    double fx = F_c(0);
    // 提取机体系下 Y 轴期望力
    double fy = F_c(1);
    // 提取机体系下 Z 轴期望力
    double fz = F_c(2);

    // 计算期望滚转角，根据机体系下 Y 轴和 Z 轴期望力计算
    u_att(0)  = std::atan2(-fy, fz);
    // 计算期望俯仰角，根据机体系下 X 轴和 Z 轴期望力计算
    u_att(1)  = std::atan2( fx, fz);
    // 期望偏航角直接使用期望状态中的偏航角
    u_att(2)  = desired_state.yaw;

    // 无人机姿态的矩阵形式，将当前姿态四元数转换为旋转矩阵
    Eigen::Matrix3d wRb_odom = current_state.q.toRotationMatrix();
    // 提取旋转矩阵的第三列，即机体系的 Z 轴在惯性系下的表示
    Eigen::Vector3d z_b_curr = wRb_odom.col(2);
    // 机体系下的电机推力 相当于Rb * F_enu 惯性系到机体系
    // 计算机体系下的电机推力，相当于惯性系下的期望力在机体系 Z 轴上的投影
    double u1 = F_des.dot(z_b_curr);
    // 悬停油门与电机参数有关系,也取决于质量
    // 计算最大推力，悬停油门与电机参数和质量有关
    double full_thrust = ctrl_param.quad_mass * ctrl_param.g(2) / ctrl_param.hov_percent;

    // 油门 = 期望推力/最大推力
    // 这里相当于认为油门是线性的,满足某种比例关系,即认为某个重量 = 悬停油门
    // 计算油门，油门等于期望推力除以最大推力
    // 这里假设油门与推力呈线性关系
    u_att(3) = u1 / full_thrust;

    // 若油门小于 0.1
    if(u_att(3) < 0.1)
    {
        // 将油门限制为 0.1
        u_att(3) = 0.1;
        // 输出警告信息，提示油门过低
        PCOUT(2, YELLOW, "throttle too low");
    }

    // 若油门大于 1.0
    if(u_att(3) > 1.0)
    {
        // 将油门限制为 1.0
        u_att(3) = 1.0;
        // 输出警告信息，提示油门过高
        PCOUT(2, YELLOW, "throttle too high");
    }

    // 返回包含期望滚转角、俯仰角、偏航角和油门的四维向量
    return u_att;
}

/**
 * @brief 打印控制器的计算结果信息
 */
void pos_controller_PID::printf_result()
{
    // 固定的浮点显示，确保输出的浮点数格式一致
    cout.setf(ios::fixed);
    // 左对齐输出内容
    cout.setf(ios::left);
    // 强制显示小数点
    cout.setf(ios::showpoint);
    // 强制显示符号
    cout.setf(ios::showpos);
    // 设置输出精度为 2 位小数
    cout<<setprecision(2);
    // 打印控制器调试信息的标题
    cout << BLUE << "----> PID Position Controller Debug Info      : " << TAIL << endl;
    // 打印期望位置信息
    cout << BLUE << "----> pos_des         : " << desired_state.pos(0) << " [ m ] " << desired_state.pos(1) << " [ m ] " << desired_state.pos(2) << " [ m ] "<< TAIL << endl;
    // 打印期望速度信息
    cout << BLUE << "----> vel_des         : " << desired_state.vel(0) << " [ m ] " << desired_state.vel(1) << " [ m ] " << desired_state.vel(2) << " [ m ] "<< TAIL << endl;
    // 打印期望加速度信息
    cout << BLUE << "----> acc_des         : " << desired_state.acc(0) << " [ m ] " << desired_state.acc(1) << " [ m ] " << desired_state.acc(2) << " [ m ] "<< TAIL << endl;
    // 打印当前位置信息
    cout << BLUE << "----> pos_now         : " << current_state.pos(0) << " [ m ] " << current_state.pos(1) << " [ m ] " << current_state.pos(2) << " [ m ] "<< TAIL << endl;
    // 打印当前速度信息
    cout << BLUE << "----> vel_now         : " << current_state.vel(0) << " [ m ] " << current_state.vel(1) << " [ m ] " << current_state.vel(2) << " [ m ] "<< TAIL << endl;
    
    // 打印误差积分项信息
    cout << BLUE << "----> int_e_v         : " << int_e_v(0) << " [N] "<< int_e_v(1) << " [N] "<< int_e_v(2) << " [N] "<< TAIL << endl;
    
    // 打印期望力信息
    cout << BLUE << "----> F_des           : " << F_des(0) << " [N] "<< F_des(1) << " [N] "<< F_des(2) << " [N] "<< TAIL << endl;
    
    // 打印期望姿态信息，将弧度转换为度
    cout << BLUE << "----> u_attitude      : " << u_att(0)*180/3.14 << " [deg] "<< u_att(1)*180/3.14 << " [deg] "<< u_att(2)*180/3.14 << " [deg] "<< TAIL << endl;
    // 打印期望油门信息
    cout << BLUE << "----> u_throttle      : " << u_att(3) << " [0-1] "<< TAIL << endl;
    // 打印位置误差均值信息
    cout << BLUE << "----> pos_error_mean  : " << tracking_error.pos_error_mean <<" [m] "<< TAIL <<endl;
    // 打印速度误差均值信息
    cout << BLUE << "----> vel_error_mean  : " << tracking_error.vel_error_mean <<" [m/s] "<< TAIL <<endl;
}

// 【打印参数函数】
/**
 * @brief 打印控制器的参数信息
 */
void pos_controller_PID::printf_param()
{
    // 打印参数信息的标题
    cout << GREEN << ">>>>>>>>>>>>>>>>>>>>>>>>>>PID Parameter <<<<<<<<<<<<<<<<<<<<<<<<<" << TAIL <<endl;
    // 打印无人机质量信息
    cout << GREEN <<  "ctrl_param.quad_mass     : "<< ctrl_param.quad_mass<< TAIL <<endl;
    // 打印悬停油门百分比信息
    cout << GREEN <<  "ctrl_param.hov_percent   : "<< ctrl_param.hov_percent<< TAIL <<endl;
    // 打印 XY 轴积分上限信息
    cout << GREEN <<  "pxy_int_max              : "<< ctrl_param.int_max[0]<< TAIL <<endl;
    // 打印 Z 轴积分上限信息
    cout << GREEN <<  "pz_int_max               : "<< ctrl_param.int_max[2]<< TAIL <<endl;

    // 打印 XY 轴位置比例增益信息
    cout << GREEN <<  "Kp_xy         : "<< ctrl_param.Kp(0,0) << TAIL <<endl;
    // 打印 Z 轴位置比例增益信息
    cout << GREEN <<  "Kp_z          : "<< ctrl_param.Kp(2,2) << TAIL <<endl;
    // 打印 XY 轴速度比例增益信息
    cout << GREEN <<  "Kv_xy         : "<< ctrl_param.Kv(0,0) << TAIL <<endl;
    // 打印 Z 轴速度比例增益信息
    cout << GREEN <<  "Kv_z          : "<< ctrl_param.Kv(2,2) << TAIL <<endl;
    // 打印 XY 轴速度积分增益信息
    cout << GREEN <<  "Kvi_xy        : "<< ctrl_param.Kvi(0,0) << TAIL <<endl;
    // 打印 Z 轴速度积分增益信息
    cout << GREEN <<  "Kvi_z         : "<< ctrl_param.Kvi(2,2) << TAIL <<endl;
    // 打印 XY 轴加速度增益信息
    cout << GREEN <<  "Ka_xy         : "<< ctrl_param.Ka(0,0) << TAIL <<endl;
    // 打印 Z 轴加速度增益信息
    cout << GREEN <<  "Ka_z          : "<< ctrl_param.Ka(2,2) << TAIL <<endl;
    // 打印最大倾斜角度信息
    cout << GREEN <<  "tilt_angle_max: "<< ctrl_param.tilt_angle_max << TAIL <<endl;
}
#endif