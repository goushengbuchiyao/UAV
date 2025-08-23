#include "uav_command_parser.h"

bool UAVCommandParser::parse(const std::string& json_str, CommandData& cmd_out, std::string& err_msg) {
    try {
        auto j = nlohmann::json::parse(json_str);

        if (!validateBaseFields(j, err_msg))
            return false;

        cmd_out.command_type = j.at("command_type").get<std::string>();
        cmd_out.timestamp = j.at("timestamp").get<double>();
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
    // 添加航线规划指令验证
    else if (cmd_type == "waypoint_mission") {
    // 验证顶层参数
        if (!params.contains("clear_existing") || !params["clear_existing"].is_boolean()) {
            err_msg = "Missing or invalid 'clear_existing' boolean";
            return false;
        }
        if (!params.contains("waypoints") || !params["waypoints"].is_array()) {
            err_msg = "Missing or invalid 'waypoints' array";
            return false;
        }
        if (!params.contains("start_immediately") || !params["start_immediately"].is_boolean()) {
            err_msg = "Missing or invalid 'start_immediately' boolean";
            return false;
        }

        // 验证每个航点
        for (size_t i = 0; i < params["waypoints"].size(); ++i) {
            const auto& wp = params["waypoints"][i];
            std::vector<std::pair<std::string, std::string>> wp_fields = {
                {"waypoint_id", "integer"},
                {"frame", "integer"},
                {"command", "integer"},
                {"param1", "double"},
                {"param2", "double"},
                {"param3", "double"},
                {"param4", "double"},
                {"x_lat", "double"},
                {"y_long", "double"},
                {"z_alt", "double"},
                {"is_current", "boolean"},
                {"autocontinue", "boolean"}
            };
            if (!wp.is_object()) {
                err_msg = "Waypoint " + std::to_string(i) + " is not an object";
                return false;
            }
            if (wp.size() < 10) {
                err_msg = "Waypoint " + std::to_string(i) + " has insufficient fields";
                return false;
            }
            // 验证航点字段
            for (auto& f : wp_fields) {
                if (!wp.contains(f.first)) {
                    err_msg = "Waypoint " + std::to_string(i) + " missing field: " + f.first;
                    return false;
                }
                if (f.second == "integer" && !wp[f.first].is_number_integer()) {
                    err_msg = "Waypoint " + std::to_string(i) + " invalid type for " + f.first + " (expected integer)";
                    return false;
                }
                if (f.second == "number" && !wp[f.first].is_number()) {
                    err_msg = "Waypoint " + std::to_string(i) + " invalid type for " + f.first + " (expected number)";
                    return false;
                }
                if (f.second == "boolean" && !wp[f.first].is_boolean()) {
                    err_msg = "Waypoint " + std::to_string(i) + " invalid type for " + f.first + " (expected boolean)";
                    return false;
                }
            }
        }
        return true;
    }
    else {
        err_msg = "Unknown command_type: " + cmd_type;
        return false;
    }
}