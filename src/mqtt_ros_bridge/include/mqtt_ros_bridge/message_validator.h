#ifndef MESSAGE_VALIDATOR_H
#define MESSAGE_VALIDATOR_H

#include <nlohmann/json.hpp>
#include <string>

namespace mqtt_ros_bridge {

using json = nlohmann::json;

class MessageValidator {
public:
    MessageValidator();
    
    // 验证JSON消息格式
    bool validateFormat(const json& msg);
    
    // 验证消息签名
    bool validateSignature(const json& msg);
    
    // 获取最后一次验证错误信息
    std::string getLastError() const;
    
private:
    std::string secret_key_;  // 用于验证签名的密钥
    std::string last_error_;  // 最后一次验证错误信息
    
    // 检查特定类型消息的结构
    bool checkStateStructure(const json& data);
    bool checkBatteryStructure(const json& data);
    bool checkGpsGlobalStructure(const json& data);
    bool checkLocalPoseStructure(const json& data);
    bool checkNedOdomStructure(const json& data);
    bool checkVelocityStructure(const json& data);
    bool checkGpsStatusStructure(const json& data);
    bool checkAttitudeStructure(const json& data);
};

} // namespace mqtt_ros_bridge

#endif // MESSAGE_VALIDATOR_H
    