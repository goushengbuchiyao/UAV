#include <ros/ros.h>
#include <mqtt/async_client.h>
#include <mqtt/ssl_options.h>
#include <mavros_msgs/State.h>
#include <sensor_msgs/BatteryState.h>
#include <sensor_msgs/NavSatFix.h>
#include <geometry_msgs/PoseStamped.h>
#include <nav_msgs/Odometry.h>
#include <geometry_msgs/TwistStamped.h>
#include <mavros_msgs/GPSRAW.h>
#include <mavros_msgs/AttitudeTarget.h>
#include <nlohmann/json.hpp>
#include <thread>
#include <atomic>
#include <condition_variable>
#include <queue>
#include <mutex>
#include "mqtt_ros_bridge/message_converter.h"
#include "mqtt_ros_bridge/message_validator.h"

using json = nlohmann::json;
using namespace std;
using namespace mqtt;
using namespace mqtt_ros_bridge;

// 回调类处理MQTT连接和消息
class MqttCallback : public mqtt::callback, public mqtt::iaction_listener {
public:
    MqttCallback(async_client& client, const string& username, const string& password)
        : client_(client), username_(username), password_(password), connected_{false} {}

    void connected(const string& cause) override {
        
        ROS_INFO("MQTT server connected successfully");
        connected_ = true;
        conn_cond_.notify_all();
        
        // 订阅相关主题
        client_.subscribe("uav1/control/command", 1);
    }
    // 实现 iaction_listener 的纯虚函数
    void on_success(const mqtt::token& asyncActionToken) override {
        ROS_INFO("MQTT operation succeeded");
    }

    void on_failure(const mqtt::token& asyncActionToken) override {
        ROS_ERROR("MQTT operation failed");
    }
    void connection_lost(const string& cause) override {
        ROS_WARN_STREAM("MQTT connection lost: " << (cause.empty() ? "Unknown reason" : cause));
        connected_ = false;
    }
    void message_arrived(mqtt::const_message_ptr msg) override {
    ROS_INFO_STREAM("Received MQTT message: Topic=" << msg->get_topic() << ", Content=" << msg->to_string());
    try {
        json j = json::parse(msg->to_string());
        // 验证消息
        if (validator_.validateFormat(j) && validator_.validateSignature(j)) {
            ROS_INFO("Message validation passed");
            // 这里可以添加处理验证通过的消息的逻辑
        } else {
            ROS_ERROR_STREAM("Message validation failed: " << validator_.getLastError());
        }
    } catch (const std::exception& e) {
    ROS_ERROR_STREAM("Failed to parse MQTT message: " << e.what());
    }
}

    void delivery_complete(delivery_token_ptr token) override {
        // 消息发送完成回调
    }

    // 等待连接成功
    bool wait_for_connection(int timeout_seconds = 10) {
    unique_lock<mutex> lk(conn_mutex_);
    return conn_cond_.wait_for(
        lk, chrono::seconds(timeout_seconds),
        [this] { return this->connected_.load(); }
    );
    }

    // 发送消息
    void send_message(const string& topic, const string& payload) {
        lock_guard<mutex> lock(queue_mutex_);
        message_queue_.emplace(topic, payload);
        queue_cond_.notify_one();
    }

    // 启动消息发送线程
    void start_sender_thread() {
        sender_thread_ = thread(&MqttCallback::process_queue, this);
    }

    // 停止消息发送线程
    void stop_sender_thread() {
        {
            lock_guard<mutex> lock(queue_mutex_);
            stop_sender_ = true;
            queue_cond_.notify_one();
        }
        if (sender_thread_.joinable()) {
            sender_thread_.join();
        }
    }

private:
    async_client& client_;
    string username_;
    string password_;
    atomic<bool> connected_;
    mutex conn_mutex_;
    condition_variable conn_cond_;
    MessageValidator validator_;
    
    // 消息队列相关
    queue<pair<string, string>> message_queue_;
    mutex queue_mutex_;
    condition_variable queue_cond_;
    thread sender_thread_;
    atomic<bool> stop_sender_{false};

    // 处理消息队列
    void process_queue() {
        while (!stop_sender_) {
            unique_lock<mutex> lock(queue_mutex_);
            queue_cond_.wait(lock, [this] { 
                return !message_queue_.empty() || stop_sender_; 
            });

            if (stop_sender_) break;

            auto [topic, payload] = message_queue_.front();
            message_queue_.pop();
            lock.unlock();

            // 发送消息
            if (connected_) {
                try {
                    auto msg = mqtt::make_message(topic, payload);
                    msg->set_qos(1);
                    msg->set_retained(false);
                    client_.publish(msg)->wait_for(std::chrono::seconds(5));
                    ROS_INFO_STREAM("send MQTT message to " << topic << " successfully");
                } catch (const std::exception& e) {
                    ROS_ERROR_STREAM("send MQTT message failed: " << e.what());
                    // 可以在这里实现有限重试逻辑
                }
            } else {
                ROS_WARN("MQTT connection is not established, cannot send message");
                // 可以将消息重新放入队列，等待连接恢复
                lock_guard<mutex> lock2(queue_mutex_);
                message_queue_.emplace(topic, payload);
            }
        }
    }
};

// MQTT-ROS桥接节点类
class MqttRosBridgeNode {
public:
    MqttRosBridgeNode(ros::NodeHandle& nh) : nh_(nh), converter_() {
        // 从参数服务器获取MQTT配置
        nh_.param<string>("host", host_, "mqtts://de80ed56.ala.cn-hangzhou.emqxsl.cn");
        nh_.param<int>("port", port_, 8883);
        nh_.param<string>("username", username_, "px_uav");
        nh_.param<string>("password", password_, "123456");
        nh_.param<string>("ca_cert_path", ca_cert_path_, "/home/px/UAV_SDK/mqtt_bridge/config/emqxsl-ca.crt");
        nh_.param<string>("client_id", client_id_, "ros_mqtt_bridge_" + to_string(getpid()));
        
        // 配置MQTT客户端
        string server_uri = host_ + ":" + to_string(port_);
        client_ = make_unique<async_client>(server_uri, client_id_);
        
        // 配置SSL选项
        ssl_options ssl_opts;
        ssl_opts.set_trust_store(ca_cert_path_);
        
        // 配置连接选项
        conn_opts_.set_ssl(ssl_opts);
        conn_opts_.set_user_name(username_);
        conn_opts_.set_password(password_);
        conn_opts_.set_clean_session(true);
        conn_opts_.set_automatic_reconnect(chrono::seconds(1), chrono::seconds(30));
        
        // 设置回调
        callback_ = make_unique<MqttCallback>(*client_, username_, password_);
        client_->set_callback(*callback_);
        
        // 连接到MQTT服务器
        connect();
        
        // 启动消息发送线程
        callback_->start_sender_thread();
        
        // 订阅ROS话题
        subscribeToRosTopics();
    }

    ~MqttRosBridgeNode() {
        // 停止消息发送线程
        callback_->stop_sender_thread();
        
        // 断开连接
        if (client_->is_connected()) {
            ROS_INFO("Disconnecting MQTT connection");
            client_->disconnect()->wait();
        }
    }

    // 连接到MQTT服务器
    void connect() {
        try {
            ROS_INFO_STREAM("Connecting to MQTT server: " << host_ << ":" << port_);
            client_->connect(conn_opts_);
            
            // 等待连接成功
            if (!callback_->wait_for_connection(15)) {
                ROS_ERROR("Connection to MQTT server timed out");
            }
        } catch (const std::exception& e) {
            ROS_ERROR_STREAM("Failed to connect to MQTT server: " << e.what());
        }
    }

    // 订阅ROS话题
    void subscribeToRosTopics() {
        // 订阅飞控状态话题
        state_sub_ = nh_.subscribe<mavros_msgs::State>(
            "/uav1/mavros/state", 10, &MqttRosBridgeNode::stateCallback, this);
            
        // 订阅电池状态话题
        battery_sub_ = nh_.subscribe<sensor_msgs::BatteryState>(
            "/uav1/mavros/battery", 10, &MqttRosBridgeNode::batteryCallback, this);
            
        // 订阅GPS全局位置话题
        gps_global_sub_ = nh_.subscribe<sensor_msgs::NavSatFix>(
            "/uav1/mavros/global_position/global", 10, &MqttRosBridgeNode::gpsGlobalCallback, this);
            
        // 订阅本地坐标系位置话题
        local_pose_sub_ = nh_.subscribe<geometry_msgs::PoseStamped>(
            "/uav1/mavros/local_position/pose", 10, &MqttRosBridgeNode::localPoseCallback, this);
            
        // 订阅北东地坐标系位置话题
        ned_odom_sub_ = nh_.subscribe<nav_msgs::Odometry>(
            "/uav1/mavros/global_position/local", 10, &MqttRosBridgeNode::nedOdomCallback, this);
            
        // 订阅速度话题
        velocity_sub_ = nh_.subscribe<geometry_msgs::TwistStamped>(
            "/uav1/mavros/local_position/velocity", 10, &MqttRosBridgeNode::velocityCallback, this);
            
        // 订阅GPS状态话题
        gps_status_sub_ = nh_.subscribe<mavros_msgs::GPSRAW>(
            "/uav1/mavros/global_position/raw/satellite", 10, &MqttRosBridgeNode::gpsStatusCallback, this);
            
        // 订阅姿态话题
        attitude_sub_ = nh_.subscribe<mavros_msgs::AttitudeTarget>(
            "/uav1/mavros/setpoint_raw/attitude", 10, &MqttRosBridgeNode::attitudeCallback, this);
            
        ROS_INFO("Subscribed to all required ROS topics");
    }

    // 飞控状态回调函数
    void stateCallback(const mavros_msgs::State::ConstPtr& msg) {
        json data = converter_.convertState(msg);
        json wrapped = converter_.wrapMessage(data, "state");
        callback_->send_message("uav1/state", wrapped.dump());
    }

    // 电池状态回调函数
    void batteryCallback(const sensor_msgs::BatteryState::ConstPtr& msg) {
        json data = converter_.convertBattery(msg);
        json wrapped = converter_.wrapMessage(data, "battery");
        callback_->send_message("uav1/battery", wrapped.dump());
    }

    // GPS全局位置回调函数
    void gpsGlobalCallback(const sensor_msgs::NavSatFix::ConstPtr& msg) {
        json data = converter_.convertGpsGlobal(msg);
        json wrapped = converter_.wrapMessage(data, "gps_global");
        callback_->send_message("uav1/gps/global", wrapped.dump());
    }

    // 本地坐标系位置回调函数
    void localPoseCallback(const geometry_msgs::PoseStamped::ConstPtr& msg) {
        json data = converter_.convertLocalPose(msg);
        json wrapped = converter_.wrapMessage(data, "local_pose");
        callback_->send_message("uav1/position/local", wrapped.dump());
    }

    // 北东地坐标系位置回调函数
    void nedOdomCallback(const nav_msgs::Odometry::ConstPtr& msg) {
        json data = converter_.convertNedOdom(msg);
        json wrapped = converter_.wrapMessage(data, "ned_odom");
        callback_->send_message("uav1/position/ned", wrapped.dump());
    }

    // 速度回调函数
    void velocityCallback(const geometry_msgs::TwistStamped::ConstPtr& msg) {
        json data = converter_.convertVelocity(msg);
        json wrapped = converter_.wrapMessage(data, "velocity");
        callback_->send_message("uav1/velocity", wrapped.dump());
    }

    // GPS状态回调函数
    void gpsStatusCallback(const mavros_msgs::GPSRAW::ConstPtr& msg) {
        json data = converter_.convertGpsStatus(msg);
        json wrapped = converter_.wrapMessage(data, "gps_status");
        callback_->send_message("uav1/gps/status", wrapped.dump());
    }

    // 姿态回调函数
    void attitudeCallback(const mavros_msgs::AttitudeTarget::ConstPtr& msg) {
        json data = converter_.convertAttitude(msg);
        json wrapped = converter_.wrapMessage(data, "attitude");
        callback_->send_message("uav1/attitude", wrapped.dump());
    }

private:
    ros::NodeHandle nh_;
    unique_ptr<async_client> client_;
    connect_options conn_opts_;
    unique_ptr<MqttCallback> callback_;
    MessageConverter converter_;
    
    // MQTT配置参数
    string host_;
    int port_;
    string username_;
    string password_;
    string ca_cert_path_;
    string client_id_;
    
    // ROS订阅者
    ros::Subscriber state_sub_;
    ros::Subscriber battery_sub_;
    ros::Subscriber gps_global_sub_;
    ros::Subscriber local_pose_sub_;
    ros::Subscriber ned_odom_sub_;
    ros::Subscriber velocity_sub_;
    ros::Subscriber gps_status_sub_;
    ros::Subscriber attitude_sub_;
};

int main(int argc, char**argv) {
    // 初始化ROS节点
    ros::init(argc, argv, "mqtt_ros_bridge_node");
    ros::NodeHandle nh("~");
    // setlocale(LC_ALL, "zh_CN.UTF-8"); 
    // 创建桥接节点 
    MqttRosBridgeNode bridge_node(nh);
    
    // 运行ROS事件循环
    ros::spin();
    
    return 0;
}