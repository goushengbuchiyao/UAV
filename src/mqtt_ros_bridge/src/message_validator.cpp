#include "mqtt_ros_bridge/message_validator.h"
#include <ros/ros.h>
#include <openssl/sha.h>
#include <iomanip>
#include <sstream>

namespace mqtt_ros_bridge {

MessageValidator::MessageValidator() {
    // 从参数服务器获取签名密钥
    if (!ros::param::get("~signature_secret", secret_key_)) {
        ROS_WARN("No signature key is set, and the message signature will not be verified.");
        secret_key_ = "";
    }
    last_error_ = "";
}

bool MessageValidator::validateFormat(const json& msg) {
    last_error_ = "";
    
    // 检查基本字段
    if (!msg.contains("type") || !msg["type"].is_string()) {
        last_error_ = "The message is missing the \"type\" field or the type is incorrect.";
        return false;
    }
    
    if (!msg.contains("timestamp") || !msg["timestamp"].is_number()) {
        last_error_ = "The message is missing the \"timestamp\" field or the type is incorrect.";
        return false;
    }
    
    if (!msg.contains("data") || !msg["data"].is_object()) {
        last_error_ = "The message is missing the \"data\" field or the type is incorrect.";
        return false;
    }
    
    // 根据消息类型检查数据结构
    std::string type = msg["type"];
    const json& data = msg["data"];
    
    if (type == "state") {
        return checkStateStructure(data);
    } else if (type == "battery") {
        return checkBatteryStructure(data);
    } else if (type == "gps_global") {
        return checkGpsGlobalStructure(data);
    } else if (type == "local_pose") {
        return checkLocalPoseStructure(data);
    } else if (type == "ned_odom") {
        return checkNedOdomStructure(data);
    } else if (type == "velocity") {
        return checkVelocityStructure(data);
    } else if (type == "gps_status") {
        return checkGpsStatusStructure(data);
    } else if (type == "attitude") {
        return checkAttitudeStructure(data);
    } else {
        last_error_ = "The message type is unknown: " + type;
        return false;
    }
}

bool MessageValidator::validateSignature(const json& msg) {
    // 如果未设置密钥，则不验证签名
    if (secret_key_.empty()) {
        return true;
    }
    
    // 检查是否包含签名
    if (!msg.contains("signature") || !msg["signature"].is_string()) {
        last_error_ = "The message is missing the signature field or the type is incorrect.";
        return false;
    }
    
    // 创建不包含签名的临时JSON用于验证
    json temp_msg = msg;
    temp_msg.erase("signature");
    
    // 生成待验证的签名
    std::string data_str = temp_msg.dump();
    std::string sign_str = data_str + secret_key_;
    
    unsigned char hash[SHA256_DIGEST_LENGTH];
    SHA256((const unsigned char*)sign_str.c_str(), sign_str.size(), hash);
    
    std::stringstream ss;
    for(int i = 0; i < SHA256_DIGEST_LENGTH; i++) {
        ss << std::hex << std::setw(2) << std::setfill('0') << (int)hash[i];
    }
    std::string computed_signature = ss.str();
    
    // 比较签名
    if (computed_signature != msg["signature"]) {
        last_error_ = "The message signature verification failed.";
        return false;
    }
    
    return true;
}

std::string MessageValidator::getLastError() const {
    return last_error_;
}

bool MessageValidator::checkStateStructure(const json& data) {
    if (!data.contains("connected") || !data["connected"].is_boolean()) {
        last_error_ = "The \"connected\" field is missing or has an incorrect type in the state message.";
        return false;
    }
    if (!data.contains("armed") || !data["armed"].is_boolean()) {
        last_error_ = "The \"armed\" field is missing or has an incorrect type in the state message.";
        return false;
    }
    if (!data.contains("mode") || !data["mode"].is_string()) {
        last_error_ = "The \"mode\" field is missing or has an incorrect type in the state message.";
        return false;
    }
    return true;
}

bool MessageValidator::checkBatteryStructure(const json& data) {
    if (!data.contains("voltage") || !data["voltage"].is_number()) {
        last_error_ = "The \"voltage\" field is missing or has an incorrect type in the battery message.";
        return false;
    }
    if (!data.contains("percentage") || !data["percentage"].is_number()) {
        last_error_ = "The \"percentage\" field is missing or has an incorrect type in the battery message.";
        return false;
    }
    return true;
}

bool MessageValidator::checkGpsGlobalStructure(const json& data) {
    if (!data.contains("latitude") || !data["latitude"].is_number()) {
        last_error_ = "The \"latitude\" field is missing or has an incorrect type in the gps_global message.";
        return false;
    }
    if (!data.contains("longitude") || !data["longitude"].is_number()) {
        last_error_ = "The \"longitude\" field is missing or has an incorrect type in the gps_global message.";
        return false;
    }
    if (!data.contains("altitude") || !data["altitude"].is_number()) {
        last_error_ = "The \"altitude\" field is missing or has an incorrect type in the gps_global message.";
        return false;
    }
    return true;
}

bool MessageValidator::checkLocalPoseStructure(const json& data) {
    if (!data.contains("position") || !data["position"].is_object()) {
        last_error_ = "The \"position\" field is missing or has an incorrect type in the local_pose message.";
        return false;
    }
    if (!data.contains("orientation") || !data["orientation"].is_object()) {
        last_error_ = "The \"orientation\" field is missing or has an incorrect type in the local_pose message.";
        return false;
    }
    return true;
}

bool MessageValidator::checkNedOdomStructure(const json& data) {
    if (!data.contains("position") || !data["position"].is_object()) {
        last_error_ = "The \"position\" field is missing or has an incorrect type in the ned_odom message.";
        return false;
    }
    if (!data["position"].contains("x") || !data["position"]["x"].is_number()) {
        last_error_ = "The \"x\" field is missing or has an incorrect type in the position field of the ned_odom message.";
        return false;
    }
    if (!data["position"].contains("y") || !data["position"]["y"].is_number()) {
        last_error_ = "The \"y\" field is missing or has an incorrect type in the position field of the ned_odom message.";
        return false;
    }
    if (!data["position"].contains("z") || !data["position"]["z"].is_number()) {
        last_error_ = "The \"z\" field is missing or has an incorrect type in the position field of the ned_odom message.";
        return false;
    }
    return true;
}

bool MessageValidator::checkVelocityStructure(const json& data) {
    if (!data.contains("linear") || !data["linear"].is_object()) {
        last_error_ = "The \"linear\" field is missing or has an incorrect type in the velocity message.";
        return false;
    }
    if (!data.contains("angular") || !data["angular"].is_object()) {
        last_error_ = "The \"angular\" field is missing or has an incorrect type in the velocity message.";
        return false;
    }
    return true;
}

bool MessageValidator::checkGpsStatusStructure(const json& data) {
    if (!data.contains("satellites_visible") || !data["satellites_visible"].is_number()) {
        last_error_ = "The \"satellites_visible\" field is missing or has an incorrect type in the gps_status message.";
        return false;
    }
    if (!data.contains("fix_type") || !data["fix_type"].is_number()) {
        last_error_ = "The \"fix_type\" field is missing or has an incorrect type in the gps_status message.";
        return false;
    }
    return true;
}

bool MessageValidator::checkAttitudeStructure(const json& data) {
    if (!data.contains("orientation") || !data["orientation"].is_object()) {
        last_error_ = "The \"orientation\" field is missing or has an incorrect type in the attitude message.";
        return false;
    }
    if (!data.contains("thrust") || !data["thrust"].is_number()) {
        last_error_ = "The \"thrust\" field is missing or has an incorrect type in the attitude message.";
        return false;
    }
    return true;
}

} // namespace mqtt_ros_bridge
    