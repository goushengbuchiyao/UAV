#ifndef MQTT_BRIDGE_MQTT_CLIENT_H
#define MQTT_BRIDGE_MQTT_CLIENT_H

#include <ros/ros.h>
#include <mqtt/async_client.h>
#include <mqtt/message.h>
#include <mqtt/connect_options.h>
#include <mqtt/properties.h>
#include <mqtt/ssl_options.h>
#include <memory>
#include <string>
#include <vector>
#include <functional>
#include <queue>
#include <mutex>
#include <thread>
#include <condition_variable>

namespace mqtt_bridge {

class MqttClient {
public:
  // 连接状态变化回调
  using ConnectionCallback = std::function<void(bool connected)>; 
  // 修改回调类型定义，增加 NodeHandle 参数
  using MessageCallback = std::function<void(const std::string& topic, const std::string& payload, ros::NodeHandle& nh)>;

  MqttClient(const std::string& server_address, 
             const std::string& client_id,
             const std::string& username,
             const std::string& password,
             const std::string& ca_cert_path,
             int qos = 1,
             ros::NodeHandle nh = ros::NodeHandle());

  ~MqttClient();
  
  ros::NodeHandle nh_;
  // 连接到MQTT服务器
  bool connect();

  // 断开与MQTT服务器的连接
  void disconnect();

  // 发布消息
  bool publish(const std::string& topic, const std::string& payload, int qos = 1, bool retain = false);

  // 订阅主题
  bool subscribe(const std::string& topic, int qos = 1);

  // 设置消息回调函数
  void setMessageCallback(const MessageCallback& callback);


  // 检查连接状态
  bool isConnected() const;

  void setConnectionCallback(const ConnectionCallback& callback) { conn_callback_ = callback; }
private:

  ConnectionCallback conn_callback_;
  int reconnect_interval_; // 重连间隔（秒）
  std::atomic<bool> reconnecting_ = false;
  int retry_count_ = 0; // 重试次数 
  int max_retries_ = 5; // 最大重试次数
  int retry_interval_ = 5000; // 重试间隔（毫秒）
  
  // 重连函数
  void attemptReconnect();
  // 连接函数
  bool doConnect();
  // MQTT客户端对象
  std::unique_ptr<mqtt::async_client> client_;
  
  // 连接选项
  mqtt::connect_options connOpts_;
  
  // SSL选项
  mqtt::ssl_options sslOpts_;
  
  // 客户端ID
  std::string client_id_;
  
  // 连接状态
  bool connected_;
  
  // 消息回调
  MessageCallback message_callback_;
  
  // 回调类，处理MQTT事件
  class Callback : public mqtt::callback {
  public:
    Callback(MqttClient& parent) : parent_(parent) {}

    void connection_lost(const std::string& cause) override;
    void message_arrived(mqtt::const_message_ptr msg) override;
    void delivery_complete(mqtt::delivery_token_ptr token) override;

  private:
    MqttClient& parent_;
  };
  
  // 回调实例
  Callback callback_;
  // 添加消息队列相关方法
  void enqueueMessage(const std::string& topic, const std::string& payload, int qos = 1, bool retain = false);
  void startWorkerThread();
  void stopWorkerThread();
private:
  // 消息队列
  std::queue<std::tuple<std::string, std::string, int, bool>> message_queue_;
  std::mutex queue_mutex_;
  std::condition_variable queue_condition_;
  std::thread worker_thread_;
  bool worker_running_ = false;
};

} // namespace mqtt_bridge

#endif // MQTT_BRIDGE_MQTT_CLIENT_H