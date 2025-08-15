#include "uav_control/safety_checker.h"
#include <xmlrpcpp/XmlRpcValue.h>
#include <cmath>
#include <sstream>

// ===================== 构造与初始化 =====================
SafetyChecker::SafetyChecker(ros::NodeHandle& nh) : nh_(nh) {
    // 先装载基础参数（是否启用参数服务器加载、uav_id），再配置订阅/发布
    loadParameters();
    nh.param<std::string>("uav_id",uav_id_, "uav1");
    std::string prefix_ = "/" + uav_id_;
    // 订阅/发布话题均基于 prefix_ 组装
    state_sub_   = nh_.subscribe(prefix_ + "/mavros/state", 10, &SafetyChecker::stateCb, this);
    battery_sub_ = nh_.subscribe(prefix_ + "/mavros/battery", 10, &SafetyChecker::batteryCb, this);
    pose_sub_    = nh_.subscribe(prefix_ + "/mavros/local_position/pose", 10, &SafetyChecker::poseCb, this);
    vel_sub_     = nh_.subscribe(prefix_ + "/mavros/local_position/velocity_local", 10, &SafetyChecker::velCb, this);
    rc_sub_      = nh_.subscribe(prefix_ + "/mavros/rc/in", 10, &SafetyChecker::rcCb, this);
    // gps_fix_sub_ = nh_.subscribe(prefix_ + "/mavros/global_position/global", 10, &SafetyChecker::gpsFixCb, this);
    gps_raw_sub_ = nh_.subscribe(prefix_ + "/mavros/gpsstatus/gps1/raw", 10, &SafetyChecker::gpsRawCb, this);

    // if (!heartbeat_topic_.empty()) {
    //     heartbeat_sub_ = nh_.subscribe(heartbeat_topic_, 10, &SafetyChecker::heartbeatCb, this);
    //     ROS_INFO_STREAM("[SafetyChecker] Heartbeat topic: " << heartbeat_topic_);
    // }

    safety_pub_   = nh_.advertise<std_msgs::String>(prefix_ + "/safety/status", 10, true);

    // MAVROS参数设置服务（每台机需独立命名空间，否则默认 /mavros/param/set）
    param_set_cli_ = nh_.serviceClient<mavros_msgs::ParamSet>(prefix_ + "mavros/param/set");
    cmd_long_cli_  = nh_.serviceClient<mavros_msgs::CommandLong>(prefix_ + "mavros/cmd/command");
}

// ===================== 参数加载 =====================
void SafetyChecker::loadParameters() {
    // 是否开启从参数服务器加载
    nh_.param("enable_param_from_ros", enable_param_from_ros_, true);

    // UAV ID 以及命名空间前缀
    nh_.param<std::string>("uav_id", uav_id_, "uav1");
    prefix_ = "/" + uav_id_;
    ROS_INFO_STREAM("[SafetyChecker] uav_id=" << uav_id_ << "  prefix=" << prefix_);

    if (!enable_param_from_ros_) {
        ROS_WARN("[SafetyChecker] The parameter server loading is turned off (enable_param_from_ros=false), and the built-in default threshold is used."); 
        return;
    }

    // PX4参数写入开关与EKF重置意图
    nh_.param("enable_px4_params_load",      enable_px4_params_load_, false);
    nh_.param("reboot_px4_set_reset_ekf",    reboot_px4_set_reset_ekf_, false);

    // // 地理围栏（ENU）
    nh_.param("geo_fence/x_min", fence_.x_min, -100.0);
    nh_.param("geo_fence/x_max", fence_.x_max,  100.0);
    nh_.param("geo_fence/y_min", fence_.y_min, -100.0);
    nh_.param("geo_fence/y_max", fence_.y_max,  100.0);
    nh_.param("geo_fence/z_min", fence_.z_min,   -0.5);
    nh_.param("geo_fence/z_max", fence_.z_max,   100.0);

    // 飞行限制/安全参数
    // nh_.param("takeoff_altitude",   takeoff_altitude_,   5.0);
    // nh_.param("landing_speed",      landing_speed_,      0.7);
    // nh_.param("disarm_altitude",    disarm_altitude_,    0.3);
    // nh_.param("localization_source",localization_source_,0);
    nh_.param("max_flight_speed",   max_flight_speed_,   5.0);
    nh_.param("max_vertical_speed", max_vertical_speed_, 2.0);

    // 阈值
    nh_.param("battery_min_voltage",    battery_min_voltage_,   10.5);
    nh_.param("battery_min_percentage", battery_min_percentage_, 20.0);
    nh_.param("rc_timeout_sec",         rc_timeout_sec_,        1.0);
    nh_.param("heartbeat_timeout_sec",  heartbeat_timeout_sec_, 2.0);
    nh_.param("position_jump_thresh",   position_jump_thresh_,  4.0);

    // 收集需要推送到PX4的参数（自动兼容 <param file="px4_params.yaml"/> 加载结果）
    collectPX4ParamsFromROS();
    // 心跳话题（可选）
    // nh_.param<std::string>("heartbeat_topic", heartbeat_topic_, "");

    // ROS_INFO_STREAM("[SafetyChecker] px4_params collected: numeric=" << px4_params_num_.size()
    //                   << ", string=" << px4_params_str_.size());
    // // 读取 px4_params（任意键值对组成的字典）。可数值也可字符串
    // if (nh_.hasParam("px4_params")) {
    //     XmlRpc::XmlRpcValue dict;
    //     nh_.getParam("px4_params", dict);
    //     if (dict.getType() == XmlRpc::XmlRpcValue::TypeStruct) {
    //         for (auto it = dict.begin(); it != dict.end(); ++it) {
    //             const std::string key = it->first;
    //             const auto& val = it->second;
    //             if (val.getType() == XmlRpc::XmlRpcValue::TypeInt) {
    //                 px4_params_num_[key] = static_cast<int>(val);
    //             } else if (val.getType() == XmlRpc::XmlRpcValue::TypeDouble) {
    //                 px4_params_num_[key] = static_cast<double>(val);
    //             } else if (val.getType() == XmlRpc::XmlRpcValue::TypeString) {
    //                 px4_params_str_[key] = static_cast<std::string>(val);
    //             } else {
    //                 ROS_WARN_STREAM("[SafetyChecker] px4_params[" << key << "] 类型不支持，已忽略。");
    //             }
    //         }
    //         ROS_INFO_STREAM("[SafetyChecker] 读取px4_params：num=" << px4_params_num_.size()
    //                          << ", str=" << px4_params_str_.size());
    //     }
    // }
    // 尝试将参数写入飞控（如果启用）
    if (enable_px4_params_load_) {
        loadPX4ParamsToFCU();
    } else {
        ROS_INFO("[SafetyChecker] The PX4 parameter writing is turned off (enable_px4_params_load=false), and the parameters will not be written.");
    }
    
    if (reboot_px4_set_reset_ekf_) {
        ROS_INFO("[SafetyChecker] reboot_px4_set_reset_ekf=true (prompt): PX4 will reset EKF state when reboot.");
    }


    ROS_INFO("[SafetyChecker] Parameters loading is completed.");
}
// ===================== 从ROS参数服务器收集PX4参数 =====================
/**
 * 规则：
 * 1) 遍历节点命名空间下的所有参数（ros::param::getNames）。
 * 2) 只处理在本节点命名空间内的参数（例如 /uav_control_node/...）。
 * 3) 识别“应推送到PX4”的参数：
 *    - 叶子名（最后一段）是全大写+数字+下划线（如 MIS_TAKEOFF_ALT, MPC_XY_VEL_MAX, GF_ACTION）
 *    - geo_fence/GF_* 这种嵌套的，也取叶子 GF_* 推送到PX4
 * 4) 过滤掉本地安全参数（小写键，如 enable_*, max_flight_speed 等）。
 */
void SafetyChecker::collectPX4ParamsFromROS() {
    px4_params_num_.clear();
    px4_params_str_.clear();

    // 节点命名空间（如 /uav_control_node）
    const std::string my_ns = ros::this_node::getName(); // 返回 "/uav_control_node"
    std::vector<std::string> all_names;
    ros::param::getParamNames(all_names);

    auto is_upper_enum_key = [](const std::string& s)->bool {
        if (s.empty()) return false;
        for (char c : s) {
            if (!(std::isupper(static_cast<unsigned char>(c)) || std::isdigit(static_cast<unsigned char>(c)) || c=='_'))
                return false;
        }
        return true;
    };

    for (const auto& full_name : all_names) {
        // 仅处理当前节点命名空间下的参数
        if (full_name.rfind(my_ns + "/", 0) != 0) continue;

        // 提取叶子名
        const auto pos = full_name.find_last_of('/');
        const std::string leaf = (pos == std::string::npos) ? full_name : full_name.substr(pos + 1);

        // 叶子名需是大写风格（PX4参数名风格）；小写（本地安全配置）一律跳过
        if (!is_upper_enum_key(leaf)) continue;

        // 读取该参数值
        XmlRpc::XmlRpcValue v;
        if (!ros::param::get(full_name, v)) continue;

        // 推送到 PX4 时，用“叶子名”作为 param_id（例如 geo_fence/GF_ACTION -> "GF_ACTION"）
        if (v.getType() == XmlRpc::XmlRpcValue::TypeInt) {
            px4_params_num_[leaf] = static_cast<int>(v);
        } else if (v.getType() == XmlRpc::XmlRpcValue::TypeDouble) {
            px4_params_num_[leaf] = static_cast<double>(v);
        } else if (v.getType() == XmlRpc::XmlRpcValue::TypeBoolean) {
            px4_params_num_[leaf] = static_cast<bool>(v) ? 1.0 : 0.0;
        } else if (v.getType() == XmlRpc::XmlRpcValue::TypeString) {
            // PX4 参数基本都是数值型；字符串通常不被接受，这里仍然保留到 str，写入时会提示并跳过
            px4_params_str_[leaf] = static_cast<std::string>(v);
        } else {
            ROS_DEBUG_STREAM("[SafetyChecker] skip non-primitive param: " << full_name);
        }
    }
}
// ===================== 等待 MAVROS 连接 =====================
bool SafetyChecker::waitMavrosConnected(double timeout_sec) {
    const ros::Time t0 = ros::Time::now();
    ROS_INFO("[SafetyChecker] Waiting for MAVROS to connect to FCU ...");
    ros::Rate r(10.0);
    while (ros::ok()) {
        ros::spinOnce();

        std::cout <<" ++++++++++++++++++++++++ " << std::endl;
        std::cout << "current_state_: " << std::boolalpha << current_state_ << std::endl;
        if (current_state_) {
            ROS_INFO("[SafetyChecker] MAVROS has connected to FCU.");
            return true;
        }
        if ((ros::Time::now() - t0).toSec() > timeout_sec) {
            ROS_ERROR("[SafetyChecker] MAVROS connection timeout.");
            return false;
        }
        r.sleep();
    }
    return false;
}
// ===================== 将px4_params写入飞控（可选） =====================
bool SafetyChecker::loadPX4ParamsToFCU() {
    
    if (!enable_px4_params_load_) {
        ROS_INFO("[SafetyChecker] enable_px4_params_load=false, the PX4 parameter writing is turned off.");
        return true;
    }
    // 等待 MAVROS / FCU 连接
    if (!waitMavrosConnected(10.0)) {
        ROS_WARN("[SafetyChecker] FCU is not connected, and the PX4 parameter writing is turned off.");
        return false;
    }

    if (!param_set_cli_.exists()) {
        ROS_WARN("[SafetyChecker] The service /mavros/param/set is not available, and the PX4 parameter writing is turned off.");
        return false;
    }
    int ok_cnt = 0, fail_cnt = 0;
// 写入数值参数
    for (const auto& kv : px4_params_num_) {
        mavros_msgs::ParamSet srv;
        srv.request.param_id = kv.first;     // 例如 "MIS_TAKEOFF_ALT" 或 "GF_ACTION"
        srv.request.value.integer = 0;       // MAVROS 需要填充 integer/real
        srv.request.value.real    = kv.second;

        if (param_set_cli_.call(srv) && srv.response.success) {
            ++ok_cnt;
            ROS_INFO_STREAM("[SafetyChecker] PX4 parameter writing success: " << kv.first << " = " << kv.second);
        } else {
            ++fail_cnt;
            ROS_WARN_STREAM("[SafetyChecker] PX4 parameter writing failed: " << kv.first);
        }
    }

    // 字符串参数提示并跳过（PX4 基本不接受）
    for (const auto& kv : px4_params_str_) {
        ROS_WARN_STREAM("[SafetyChecker] The parameter " << kv.first
                        << " is a string (value=" << kv.second
                        << "), and PX4 usually does not support string parameters, so it is skipped.");
    }

    ROS_INFO_STREAM("[SafetyChecker] PX4 parameter writing is complete: success " << ok_cnt << " items, fail " << fail_cnt << " items.");

    // 如需写后重启（沿用你的开关 reboot_px4_set_reset_ekf）
    if (fail_cnt > 0) {
        ROS_INFO("[SafetyChecker] After writing the PX4 parameters, the PX4 will be rebooted (MAV_CMD_PREFLIGHT_REBOOT_SHUTDOWN).");
        if (!rebootPX4()) {
            ROS_WARN("[SafetyChecker] The reboot command sending failed.");
            return (fail_cnt == 0); // 视作部分成功
        }
    }

    return (fail_cnt == 0);

//     // 写入数字参数
//     for (const auto& kv : px4_params_num_) {
//         mavros_msgs::ParamSet srv;
//         srv.request.param_id = kv.first;
//         srv.request.value.integer = 0;         // 对齐 MAVROS 的 ParamValue 结构
//         srv.request.value.real = kv.second;
//         if (param_set_cli_.call(srv) && srv.response.success) {
//             ROS_INFO_STREAM("[SafetyChecker] PX4参数写入: " << kv.first << " = " << kv.second);
//         } else {
//             ROS_WARN_STREAM("[SafetyChecker] PX4参数写入失败: " << kv.first);
//             // 不直接失败返回，继续其他参数，以最大化覆盖
//         }
//     }

//     // 写入字符串参数（需要 MAVROS 支持字符串 ParamValue；部分PX4参数不支持字符串）
//     for (const auto& kv : px4_params_str_) {
//         mavros_msgs::ParamSet srv;
//         srv.request.param_id = kv.first;
//         // MAVROS 的 ParamValue 本身没有string字段，通常PX4参数也为数值型
//         // 若确需字符串，可约定将字符串映射为整数枚举，或在上层转换
//         ROS_WARN_STREAM("[SafetyChecker] 参数 " << kv.first << " 是字符串，PX4通常不支持字符串参数，已忽略（值=" << kv.second << "）。");
//     }

//     // reboot_px4_set_reset_ekf_ 仅作为运行策略参考，不在此处执行重启（重启通常通过 command_long 或者地面站）
//     if (reboot_px4_set_reset_ekf_) {
//         ROS_INFO("[SafetyChecker] reboot_px4_set_reset_ekf=true（提示）：如需重启并重置EKF，请在飞控管理流程中执行。");
//     }

//     return true;
}

// ===================== 发送 PX4 重启指令 =====================
bool SafetyChecker::rebootPX4() {
    if (!cmd_long_cli_.exists()) {
        ROS_WARN("[SafetyChecker] The service /uav1/mavros/cmd/command is not available, and the PX4 reboot command sending is turned off.");
        return false;
    }

    mavros_msgs::CommandLong cmd;
    cmd.request.broadcast = false;
    cmd.request.command   = 246;    // MAV_CMD_PREFLIGHT_REBOOT_SHUTDOWN
    cmd.request.confirmation = 0;
    // param1: 1=重启飞控；其余参数置0
    cmd.request.param1 = 1.0;  // reboot autopilot
    cmd.request.param2 = 0.0;
    cmd.request.param3 = 0.0;
    cmd.request.param4 = 0.0;
    cmd.request.param5 = 0.0;
    cmd.request.param6 = 0.0;
    cmd.request.param7 = 0.0;

    if (cmd_long_cli_.call(cmd) && cmd.response.success) {
        ROS_WARN("[SafetyChecker] The PX4 reboot command sending is successful (the FCU will be disconnected and rebooted).");
        return true;
    } else {
        ROS_WARN("[SafetyChecker] The PX4 reboot command sending failed.");
        return false;
    }
}

// ===================== 起飞前检查入口 =====================

bool SafetyChecker::preFlightCheck() {
    safety_flag_ = 0;

    if (!checkPX4Params())        { safety_flag_ = 6; publishSafetyStatus(); return false; }
    if (!checkBatteryHealth())    { safety_flag_ = 5; publishSafetyStatus(); return false; }
    if (!checkGeoFence())         { safety_flag_ = 1; publishSafetyStatus(); return false; }
    if (!checkLocalization())     { safety_flag_ = 2; publishSafetyStatus(); return false; }
    if (!checkRCConnection())     { safety_flag_ = 3; publishSafetyStatus(); return false; }

    publishSafetyStatus();
    return true;
}

// ===================== 飞行中检查入口 =====================
bool SafetyChecker::inFlightCheck() {
    safety_flag_ = 0;

    if (!checkGeoFence())                 { safety_flag_ = 1; }
    else if (!checkLocalization())        { safety_flag_ = 2; }
    else if (!checkRCConnection())        { safety_flag_ = 3; }
    else if (!checkVelocityAndPositionLimits()) { safety_flag_ = 4; }
    // else if (!checkLinkStatus())          { safety_flag_ = 5; }

    publishSafetyStatus();
    return safety_flag_ == 0;
}

// ===================== 各子检查实现 =====================
bool SafetyChecker::checkPX4Params() {
    // 仅在启用参数服务器时检查（与 px4_params 对比）
    if (!enable_param_from_ros_) return true;
    if (px4_params_num_.empty() && px4_params_str_.empty()) {
        // 未提供对标参数，则不做强制检查
        return true;
    }

    // 这里不调用 /mavros/param/get 做逐项对比（避免过多依赖/耗时）
    // 而是在启用写入时，已尽力写入；此处只给出提醒。
    // 如果需要强比较，可扩展：调用 /mavros/param/get 并对比 value，一致则OK，否则返回false。
    ROS_INFO("[SafetyChecker] The PX4 parameter checking is skipped: strict comparison is not implemented (/uav1/mavros/param/get check).");
    return true;
}

bool SafetyChecker::checkBatteryHealth() {
    // std::cout <<" ++++++++++++++++++++++++ " << std::endl;
    // std::cout << "has_batt_: " << std::boolalpha << has_batt_ << std::endl;
    // std::cout << "battery_state_percentage: " << battery_state_percentage << std::endl;
    // std::cout << "battery_state_voltage: " << battery_state_voltage << std::endl;
    if (!has_batt_) {
        // ROS_INFO("has_batt_: %s", has_batt_);
        ROS_WARN_THROTTLE(2.0, "[SafetyChecker] The battery state is not ready.");
        return false;
    }
    // 电量百分比优先，其次电压
    const double percent = battery_state_percentage * 100.0;
    if (percent > 0.0 && percent < battery_min_percentage_) {
        ROS_WARN_STREAM_THROTTLE(2.0, "[SafetyChecker] The battery percentage is too low " << percent << "% < " << battery_min_percentage_ << "%");
        return false;
    }
    if (battery_state_voltage > 1e-3 && battery_state_voltage < battery_min_voltage_) {
        ROS_WARN_STREAM_THROTTLE(2.0, "[SafetyChecker] The battery voltage is too low " << battery_state_voltage << "V < " << battery_min_voltage_ << "V");
        return false;
    }
    return true;
}

bool SafetyChecker::withinFence(double x, double y, double z) const {
    return (x >= fence_.x_min && x <= fence_.x_max &&
            y >= fence_.y_min && y <= fence_.y_max &&
            z >= fence_.z_min && z <= fence_.z_max);
}

bool SafetyChecker::checkGeoFence() {
    if (!has_pose_) {
        ROS_WARN_THROTTLE(2.0, "[SafetyChecker] The position data is not ready, and the fence checking is turned off.");
        return false;
    }
    const auto& p = current_pose_.position; // ENU: x东 y北 z上
    if (!withinFence(p.x, p.y, p.z)) {
        ROS_ERROR_STREAM_THROTTLE(1.0, "[SafetyChecker] The position is out of the fence: "
            << "pos=(" << p.x << "," << p.y << "," << p.z << ") "
            << "fence=[x:" << fence_.x_min << "," << fence_.x_max
            << " y:" << fence_.y_min << "," << fence_.y_max
            << " z:" << fence_.z_min << "," << fence_.z_max << "]");
        return false;
    }
    return true;
}

bool SafetyChecker::checkLocalization() {
    // 策略：1) 有GPSRAW则依据fix_type>=3；2) 无GPS则依据local pose时间戳是否新鲜
    const ros::Time now = ros::Time::now();

    if (has_gps_raw_) {
        // PX4 / MAVROS GPSRAW: 0..8（参见你的UAVStateCollector）
        const int fix_type = gps_raw_fix_type;
        if (fix_type <= 1) { // NO_GPS / NO_FIX
            ROS_WARN_THROTTLE(2.0, "[SafetyChecker] The GPS localization is invalid, fix_type=%d.", fix_type);
            // 若指定必须GPS（localization_source_==1），则失败
            // if (localization_source_ == 1) return false;
            return false;
        } else if (fix_type == 2) {
            ROS_WARN_THROTTLE(2.0, "[SafetyChecker] The GPS localization is valid, but only 2D_FIX, which is not recommended.");
            return false; // 仅2D_FIX，建议等待3D_FIX
        } else if (fix_type >= 3) {
            if (gps_raw_satellites_visible >= 15)
            {
                ROS_INFO_THROTTLE(2.0, "[SafetyChecker] The GPS localization is valid, fix_type=%d, satellites_visible=%d.", fix_type, gps_raw_satellites_visible);                
                return true;
            }else if (gps_raw_satellites_visible < 15)
            {
                ROS_WARN_THROTTLE(2.0, "[SafetyChecker] The GPS localization is valid, but the satellites_visible is too low: %d < 15.", gps_raw_satellites_visible);
                // 若指定必须GPS（localization_source_==1），则失败
                // if (localization_source_ == 1) return false;
                return false; // 卫星数少于15，建议等待更多卫星
            }
        }
    }

    // // 无GPSRAW时，检查local pose是否新鲜
    // if (has_pose_) {
    //     const double age = (now - current_pose_.header.stamp).toSec();
    //     if (age > 0.5) { // 500ms内更新
    //         ROS_WARN_THROTTLE(2.0, "[SafetyChecker] 本地定位超时(%.2fs)。", age);
    //         // 若指定必须VIO/Odom（localization_source_==2），此处失败
    //         if (localization_source_ == 2) return false;
    //     }
    //     return true;
    // }

    ROS_WARN_THROTTLE(2.0, "[SafetyChecker] The localization data is not ready.");
    return false;
}

bool SafetyChecker::checkRCConnection() {
    if (!has_rc_) {
        ROS_WARN_THROTTLE(2.0, "[SafetyChecker] The RC connection is not ready.");
        return false;
    }
    const double age = (ros::Time::now() - last_rc_input_time_).toSec();
    if (age > rc_timeout_sec_) {
        ROS_WARN_THROTTLE(2.0, "[SafetyChecker] The RC connection is timeout: %.2fs > %.2fs.", age, rc_timeout_sec_);
        return false;
    }
    
    return true;
}

bool SafetyChecker::checkVelocityAndPositionLimits() {
    if (!has_vel_) {
        ROS_WARN_THROTTLE(2.0, "[SafetyChecker] The velocity data is not ready.");
        return false;
    }

    const double vx = current_velocity_.linear.x;
    const double vy = current_velocity_.linear.y;
    const double vz = current_velocity_.linear.z;

    const double vxy = planarSpeed(vx, vy);

    if (vxy > max_flight_speed_ + 1e-3) {
        ROS_ERROR_STREAM_THROTTLE(1.0, "[SafetyChecker] The horizontal speed is too high: " << vxy << " m/s > "
                                           << max_flight_speed_ << " m/s");
        return false;
    }
    if (std::fabs(vz) > max_vertical_speed_ + 1e-3) {
        ROS_ERROR_STREAM_THROTTLE(1.0, "[SafetyChecker] The vertical speed is too high: " << std::fabs(vz) << " m/s > "
                                           << max_vertical_speed_ << " m/s");
        return false;
    }

    // 位置跳变检测（相邻两帧）
    if (has_pose_) {
        if (has_last_pose_) {
            // const auto& p  = current_pose_.position;
            // const auto& lp = last_pose_.position;
            const double dx = current_pose_.position.x - last_pose_.position.x;
            const double dy = current_pose_.position.y - last_pose_.position.y;
            const double dz = current_pose_.position.z - last_pose_.position.z;
            const double d  = std::sqrt(dx*dx + dy*dy + dz*dz);
            if (d > position_jump_thresh_) {
                ROS_ERROR_STREAM_THROTTLE(1.0, "[SafetyChecker] The position is jump: " << d << " m > "
                                               << position_jump_thresh_ << " m");
                last_pose_ = current_pose_;
                return false;
            }
        }
        last_pose_ = current_pose_;
        has_last_pose_ = true;
    }

    return true;
}

// bool SafetyChecker::checkLinkStatus() {
//     if (heartbeat_topic_.empty()) {
//         // 未配置心跳，视为通过
//         return true;
//     }
//     const double age = (ros::Time::now() - last_link_heartbeat_).toSec();
//     if (age > heartbeat_timeout_sec_) {
//         ROS_ERROR_STREAM_THROTTLE(1.0, "[SafetyChecker] 链路心跳超时: " << age << "s > "
//                                                << heartbeat_timeout_sec_ << "s");
//         return false;
//     }
//     return true;
// }

// ===================== 回调 =====================
void SafetyChecker::stateCb(const mavros_msgs::State::ConstPtr& msg) {
    // ROS_INFO("================================");
    current_state_ = static_cast<bool>(msg->connected);
    // std::cout <<" ++++++++++++++++++++++++ " << std::endl;
    // std::cout << "connected_: " << std::boolalpha << static_cast<bool>(msg->connected) << std::endl;
}

void SafetyChecker::batteryCb(const sensor_msgs::BatteryState::ConstPtr& msg) {
    battery_state_percentage = msg->percentage;
    battery_state_voltage = msg->voltage;
    has_batt_ = true;
    // ROS_INFO("has_batt_ ++++++++++++: %s", has_batt_);
}

void SafetyChecker::poseCb(const geometry_msgs::PoseStamped::ConstPtr& msg) {
    current_pose_ = msg->pose;
    has_pose_ = true;
}

void SafetyChecker::velCb(const geometry_msgs::TwistStamped::ConstPtr& msg) {
    current_velocity_ = msg->twist;
    has_vel_ = true;
}

void SafetyChecker::rcCb(const mavros_msgs::RCIn::ConstPtr& msg) {
    rc_input_ = msg->channels;
    last_rc_input_time_ = ros::Time::now();
    has_rc_ = true;
}

// void SafetyChecker::gpsFixCb(const sensor_msgs::NavSatFix::ConstPtr& msg) {
//     gps_fix_ = msg->fix;
//     has_gps_fix_ = true;
// }

void SafetyChecker::gpsRawCb(const mavros_msgs::GPSRAW::ConstPtr& msg) {
    gps_raw_fix_type = msg->fix_type;
    gps_raw_satellites_visible = msg->satellites_visible;
    has_gps_raw_ = true;
}

// void SafetyChecker::heartbeatCb(const std_msgs::String::ConstPtr& msg) {
//     (void)msg;
//     last_link_heartbeat_ = ros::Time::now();
// }

// ===================== 状态发布 =====================
void SafetyChecker::publishSafetyStatus() {
    std::ostringstream oss;
    oss << "{"
        << "\"uav_id\":\"" << uav_id_ << "\","
        << "\"flag\":" << safety_flag_ << ","
        << "\"batt\":{"
            << "\"pct\":" << (has_batt_ ? battery_state_percentage * 100.0 : -1.0) << ","
            << "\"volt\":" << (has_batt_ ? battery_state_voltage : -1.0)
        << "},"
        << "\"pose_ready\":" << (has_pose_ ? "true":"false") << ","
        << "\"vel_ready\":" << (has_vel_ ? "true":"false") << ","
        << "\"rc_ready\":"  << (has_rc_  ? "true":"false") << ","
        << "\"gps_raw_ready\":" << (has_gps_raw_ ? "true":"false") << ","
        << "\"fence\":{"
            << "\"xmin\":" << fence_.x_min << ",\"xmax\":" << fence_.x_max << ","
            << "\"ymin\":" << fence_.y_min << ",\"ymax\":" << fence_.y_max << ","
            << "\"zmin\":" << fence_.z_min << ",\"zmax\":" << fence_.z_max
        << "},"
        << "\"limits\":{"
            << "\"vxy\":" << max_flight_speed_ << ",\"vz\":" << max_vertical_speed_
        << "}"
        << "}";

    std_msgs::String msg;
    msg.data = oss.str();
    safety_pub_.publish(msg);
}