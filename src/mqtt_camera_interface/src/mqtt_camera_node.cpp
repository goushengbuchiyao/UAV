
#include <ros/ros.h>
#include <mavros_msgs/CommandLong.h>
#include <std_msgs/String.h>
#include <nlohmann/json.hpp>
#include <mqtt/async_client.h>

using json = nlohmann::json;
using namespace std;

class MqttCameraInterface {
private:
    ros::NodeHandle nh_;
    ros::Publisher state_pub_;
    ros::ServiceClient command_client_;
    mqtt::async_client mqtt_client_;
    ros::Timer timer_; 
    string camera_state_ = "idle";
    string camera_mode_ = "photo";

public:
    MqttCameraInterface() : 
        mqtt_client_("tcp://47.104.183.127:1983", "ros_mqtt_client") // 建议用tcp协议
    {
        state_pub_ = nh_.advertise<std_msgs::String>("uav1/payload/camera/state", 10);
        command_client_ = nh_.serviceClient<mavros_msgs::CommandLong>("mavros/cmd/command");

        mqtt::connect_options conn_opts;
        conn_opts.set_keep_alive_interval(20);
        conn_opts.set_clean_session(true);
        conn_opts.set_user_name("pxtest");
        conn_opts.set_password("test2025@px");
        mqtt_client_.connect(conn_opts);

        // 用成员变量保存定时器
        timer_ = nh_.createTimer(ros::Duration(1.0), &MqttCameraInterface::publishState, this);
    }

    void publishState(const ros::TimerEvent& event) {
        json j;
        j["camera"]["state"] = camera_state_;
        j["camera"]["mode"] = camera_mode_;
        j["camera"]["media"]["resolution"] = "1920x1080";
        j["camera"]["media"]["framerate"] = 30;
        j["camera"]["media"]["format"] = "JPEG";
        j["camera"]["storage"]["remaining_space"] = 123456789;
        j["camera"]["storage"]["total_space"] = 1073741824;
        j["camera"]["storage"]["record_time_remaining"] = 3600;
        j["camera"]["status"]["temperature"] = 32;
        j["camera"]["status"]["timestamp"] = std::to_string(ros::Time::now().toSec());
        j["camera"]["error"]["code"] = 0;
        j["camera"]["error"]["message"] = "";
        j["camera"]["version"] = "1.0";

        // 发布到ROS话题
        std_msgs::String msg;
        msg.data = j.dump();
        state_pub_.publish(msg);

        // 发布到MQTT话题
        mqtt_client_.publish("uav1/payload/camera/state", msg.data, 1, false);
    }

    bool takePhoto() {
        mavros_msgs::CommandLong cmd;
        cmd.request.command = 2000; // 自定义拍照命令
        cmd.request.param1 = 1; // 拍照参数
        if (command_client_.call(cmd) && cmd.response.success) {
            camera_state_ = "capturing";
            return true;
        }
        return false;
    }

    bool startRecording() {
        mavros_msgs::CommandLong cmd;
        cmd.request.command = 2001; // 自定义录像命令
        cmd.request.param1 = 1; // 开始录像
        if (command_client_.call(cmd) && cmd.response.success) {
            camera_state_ = "recording";
            camera_mode_ = "video";
            return true;
        }
        return false;
    }

    bool stopRecording() {
        mavros_msgs::CommandLong cmd;
        cmd.request.command = 2001; // 自定义录像命令
        cmd.request.param1 = 0; // 停止录像
        if (command_client_.call(cmd) && cmd.response.success) {
            camera_state_ = "idle";
            return true;
        }
        return false;
    }
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "mqtt_camera_interface");
    MqttCameraInterface interface;
    ros::spin();
    return 0;
}