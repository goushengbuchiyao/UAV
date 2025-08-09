#pragma once
#include <string>
#include <nlohmann/json.hpp>

class UAVCommandParser {
public:
    struct CommandData {
        std::string command_type;
        uint64_t timestamp;
        int target_system;
        nlohmann::json params;
    };

    UAVCommandParser() = default;

    bool parse(const std::string& json_str, CommandData& cmd_out, std::string& err_msg);

private:
    bool validateBaseFields(const nlohmann::json& j, std::string& err_msg);
    bool validateParams(const std::string& cmd_type, const nlohmann::json& params, std::string& err_msg);
};
