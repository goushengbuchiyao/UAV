#include "uav_state_collector.h"
#include <tf2_geometry_msgs/tf2_geometry_msgs.h>
#include <tf2/LinearMath/Matrix3x3.h>
#include <cmath>
#include <chrono>
#include <ctime>

UAVStateCollector::UAVStateCollector(ros::NodeHandle& nh) {
    nh.param<std::string>("uav_id", uav_id_, "uav1");
    std::string prefix = "/" + uav_id_;
    fix_desc_ = "Unknown fix quality";
    state_sub_ = nh.subscribe(prefix + "/mavros/state", 10, &UAVStateCollector::stateCallback, this);
    battery_sub_ = nh.subscribe(prefix + "/mavros/battery", 10, &UAVStateCollector::batteryCallback, this);
    global_pos_sub_ = nh.subscribe(prefix + "/mavros/global_position/global", 10, &UAVStateCollector::globalPosCallback, this);
    local_pos_sub_ = nh.subscribe(prefix + "/mavros/local_position/pose", 10, &UAVStateCollector::localPosCallback, this);
    velocity_sub_ = nh.subscribe(prefix + "/mavros/local_position/velocity_local", 10, &UAVStateCollector::velocityCallback, this);
    gps_status_sub_ = nh.subscribe(prefix + "/mavros/gpsstatus/gps1/raw", 10, &UAVStateCollector::gpsStatusCallback, this);
}

void UAVStateCollector::stateCallback(const mavros_msgs::State::ConstPtr& msg) {
    flight_mode_ = msg->mode;
    // std::cout <<" ++++++++++++++++++++++++ " << std::endl;
    // std::cout << "connected_: " << std::boolalpha << static_cast<bool>(msg->connected) << std::endl;
}

void UAVStateCollector::batteryCallback(const sensor_msgs::BatteryState::ConstPtr& msg) {
    battery_percent_ = msg->percentage * 100.0f;
    battery_voltage_ = msg->voltage;
    battery_current_ = msg->current;
    battery_remaining_capacity_ = static_cast<int>(msg->capacity * msg->percentage);
}

void UAVStateCollector::globalPosCallback(const sensor_msgs::NavSatFix::ConstPtr& msg) {
    latitude_ = msg->latitude;
    longitude_ = msg->longitude;
    altitude_amsl_ = msg->altitude;
    // altitude_relative_ 可结合高度话题计算，这里简单示例
    // altitude_relative_ = msg->altitude - 120.0; // 假设起飞点海拔 120m
}

void UAVStateCollector::localPosCallback(const geometry_msgs::PoseStamped::ConstPtr& msg) {
    enu_x_ = msg->pose.position.x;
    enu_y_ = msg->pose.position.y;
    enu_z_ = msg->pose.position.z;

    ned_x_ = enu_y_;
    ned_y_ = enu_x_;
    ned_z_ = -enu_z_;

    qx_ = msg->pose.orientation.x;
    qy_ = msg->pose.orientation.y;
    qz_ = msg->pose.orientation.z;
    qw_ = msg->pose.orientation.w;

    tf2::Quaternion q(qx_, qy_, qz_, qw_);
    tf2::Matrix3x3(q).getRPY(roll_, pitch_, yaw_);
}

void UAVStateCollector::velocityCallback(const geometry_msgs::TwistStamped::ConstPtr& msg) {
    velocity_x_ = msg->twist.linear.x;
    velocity_y_ = msg->twist.linear.y;
    velocity_z_ = msg->twist.linear.z;
    ground_speed_ = std::sqrt(velocity_x_ * velocity_x_ + velocity_y_ * velocity_y_);
}

void UAVStateCollector::gpsStatusCallback(const mavros_msgs::GPSRAW::ConstPtr& msg) {
    fix_type_ = msg->fix_type;
    if(fix_type_ == 0) {
        fix_desc_ = "NO_GPS";
    } else if(fix_type_ == 1) {
        fix_desc_ = "NO_FIX";
    } else if(fix_type_ == 2) {
        fix_desc_ = "2D_FIX";
    }else if(fix_type_ == 3) {
        fix_desc_ = "3D_FIX";
    } else if(fix_type_ == 4) {
        fix_desc_ = "DGPS";
    } else if(fix_type_ == 5) {
        fix_desc_ = "RTK_FLOAT";
    } else if(fix_type_ == 6) {
        fix_desc_ = "RTK_FIXED";
    } else if(fix_type_ == 7) {
        fix_desc_ = "STATIC";
    } else if(fix_type_ == 8) {
        fix_desc_ = "PPP";
    } else {
        fix_desc_ = "UNKNOWN";
    }
    satellites_visible_ = msg->satellites_visible;
    hdop_ = msg->eph;
    vdop_ = msg->epv;
}

std::string UAVStateCollector::getFlightModeJson() {
    
    nlohmann::json j = {
        {"state_type", "flight_mode"},
        {"timestamp", system_timestamp},
        {"target_system", uav_id_},
        {"params", {
            {"mode", flight_mode_},
        }}
    };
    return j.dump();
}

std::string UAVStateCollector::getBatteryStatusJson() {
    nlohmann::json j = {
        {"state_type", "battery_status"},
        {"timestamp", system_timestamp},
        {"target_system", uav_id_},
        {"params", {
            {"percentage", battery_percent_},
            {"voltage", battery_voltage_},
            {"current", battery_current_},
            {"remaining_capacity", battery_remaining_capacity_}
        }}
    };
    return j.dump();
}

std::string UAVStateCollector::getGPSPositionJson() {
    nlohmann::json j = {
        {"state_type", "gps_position"},
        {"timestamp", system_timestamp},
        {"target_system", uav_id_},
        {"params", {
            {"latitude", latitude_},
            {"longitude", longitude_},
            {"altitude_amsl", altitude_amsl_},
            // {"altitude_relative", altitude_relative_}
        }}
    };
    return j.dump();
}

std::string UAVStateCollector::getLocalPositionJson() {
    nlohmann::json j = {
        {"state_type", "local_position_enu"},
        {"timestamp", system_timestamp},
        {"target_system", uav_id_},
        {"params", {
            {"x", enu_x_}, {"y", enu_y_}, {"z", enu_z_}
        }}
    };
    return j.dump();
}

std::string UAVStateCollector::getNEDPositionJson() {
    nlohmann::json j = {
        {"state_type", "position_ned"},
        {"timestamp", system_timestamp},
        {"target_system", uav_id_},
        {"params", {
            {"north", ned_x_}, {"east", ned_y_}, {"down", ned_z_}
        }}
    };
    return j.dump();
}

std::string UAVStateCollector::getVelocityJson() {
    nlohmann::json j = {
        {"state_type", "velocity"},
        {"timestamp", system_timestamp},
        {"target_system", uav_id_},
        {"params", {
            {"vx", velocity_x_}, {"vy", velocity_y_}, {"vz", velocity_z_},
            {"ground_speed", ground_speed_}
        }}
    };
    return j.dump();
}

std::string UAVStateCollector::getGPSStatusJson() {
    // std::string fix_desc = fix_type_ == 0 ? "NO_FIX" : (fix_type_ == 1 ? "2D_FIX" : "3D_FIX");
    
    nlohmann::json j = {
        {"state_type", "gps_status"},
        {"timestamp", system_timestamp},
        {"target_system", uav_id_},
        {"params", {
            {"fix_type", fix_type_},
            {"fix_quality", fix_desc_},
            {"satellite_count", satellites_visible_},
            {"hdop", hdop_},
            {"vdop", vdop_}
        }}    };
    return j.dump();
}

std::string UAVStateCollector::getAttitudeJson() {
    nlohmann::json j = {
        {"state_type", "attitude"},
        {"timestamp", system_timestamp},
        {"target_system", uav_id_},
        {"params", {
            {"roll_deg", roll_ * 180.0 / M_PI},
            {"pitch_deg", pitch_ * 180.0 / M_PI},
            {"yaw_deg", yaw_ * 180.0 / M_PI},
            {"roll_rad", roll_},
            {"pitch_rad", pitch_},
            {"yaw_rad", yaw_},
            {"quaternion", {
                {"x", qx_}, {"y", qy_}, {"z", qz_}, {"w", qw_}
            }}
        }}
    };
    return j.dump();
}
std::string UAVStateCollector::getStateJson() {
    
    nlohmann::json j;
    j["state_type"] = "uav_state";
    j["timestamp"] = system_timestamp;
    j["target_system"] = uav_id_;

    j["params"] = {
        {"mode", flight_mode_},
        {"battery", {"percentage", battery_percent_},
            {"voltage", battery_voltage_},
            {"current", battery_current_},
            {"remaining_capacity", battery_remaining_capacity_}},
        {"position", {
            {"latitude", latitude_},
            {"longitude", longitude_},
            {"altitude_amsl_", altitude_amsl_}
        }},
        {"local_position", {{"x", enu_x_}, {"y", enu_y_}, {"z", enu_z_}}},
        {"ned_position",   {{"north", ned_x_}, {"east", ned_y_}, {"down", ned_z_}}},
        {"velocity",       {{"north", velocity_x_}, {"east", velocity_y_}, {"down", velocity_z_},{"ground_speed", ground_speed_}}},
        {"euler",          {{"roll_deg", roll_ * 180.0 / M_PI},
            {"pitch_deg", pitch_ * 180.0 / M_PI},
            {"yaw_deg", yaw_ * 180.0 / M_PI},
            {"roll_rad", roll_},
            {"pitch_rad", pitch_},
            {"yaw_rad", yaw_},
            {"quaternion", {
                {"x", qx_}, {"y", qy_}, {"z", qz_}, {"w", qw_}
            }}
        }},
        {"gps_status",     {{"fix_type", fix_type_},
            {"fix_quality", fix_desc_},
            {"satellite_count", satellites_visible_},
            {"hdop", hdop_},
            {"vdop", vdop_}}}
    };

    return j.dump();
}