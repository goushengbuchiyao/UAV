#include "uav_command_parser.h"

bool UAVCommandParser::parse(const std::string& json_str, CommandData& cmd_out, std::string& err_msg) {
    try {
        auto j = nlohmann::json::parse(json_str);

        if (!validateBaseFields(j, err_msg))
            return false;

        cmd_out.command_type = j.at("command_type").get<std::string>();
        cmd_out.timestamp = j.at("timestamp").get<uint64_t>();
        cmd_out.target_system = j.at("target_system").get<int>();
        cmd_out.params = j.at("params");

        if (!validateParams(cmd_out.command_type, cmd_out.params, err_msg))
            return false;

        return true;
    }
    catch (nlohmann::json::exception& e) {
        err_msg = std::string("JSON parse error: ") + e.what();
        return false;
    }
}

bool UAVCommandParser::validateBaseFields(const nlohmann::json& j, std::string& err_msg) {
    if (!j.contains("command_type") || !j["command_type"].is_string()) {
        err_msg = "Missing or invalid 'command_type'";
        return false;
    }
    if (!j.contains("timestamp") || !j["timestamp"].is_number_unsigned()) {
        err_msg = "Missing or invalid 'timestamp'";
        return false;
    }
    if (!j.contains("target_system") || !j["target_system"].is_number_integer()) {
        err_msg = "Missing or invalid 'target_system'";
        return false;
    }
    if (!j.contains("params") || !j["params"].is_object()) {
        err_msg = "Missing or invalid 'params'";
        return false;
    }
    return true;
}

bool UAVCommandParser::validateParams(const std::string& cmd_type, const nlohmann::json& params, std::string& err_msg) {
    auto require_fields = [&](std::initializer_list<std::pair<std::string, std::string>> fields) -> bool {
        for (auto& f : fields) {
            if (!params.contains(f.first)) {
                err_msg = "Missing param: " + f.first;
                return false;
            }
            if (f.second == "double" && !params[f.first].is_number()) {
                err_msg = "Invalid type for param: " + f.first + " (expected number)";
                return false;
            }
            if (f.second == "string" && !params[f.first].is_string()) {
                err_msg = "Invalid type for param: " + f.first + " (expected string)";
                return false;
            }
        }
        return true;
    };

    if (cmd_type == "takeoff")
        return require_fields({{"altitude", "double"}, {"yaw", "double"}});
    else if (cmd_type == "land")
        return require_fields({{"yaw", "double"}});
    else if (cmd_type == "position_control_ned")
        return require_fields({{"x", "double"}, {"y", "double"}, {"z", "double"}, {"yaw", "double"}});
    else if (cmd_type == "position_control_global")
        return require_fields({{"latitude", "double"}, {"longitude", "double"}, {"altitude", "double"}, {"yaw", "double"}});
    else if (cmd_type == "velocity_control_ned")
        return require_fields({{"vx", "double"}, {"vy", "double"}, {"vz", "double"}, {"yaw_rate", "double"}});
    else if (cmd_type == "return_to_launch")
        return require_fields({{"altitude", "double"}});
    else if (cmd_type == "hover")
        return require_fields({{"mode", "string"}});
    else if (cmd_type == "set_mode")
        return require_fields({{"mode", "string"}});
    else {
        err_msg = "Unknown command_type: " + cmd_type;
        return false;
    }
}
