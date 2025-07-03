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

namespace mqtt_bridge {

class MqttClient {
public:
  // 消息回调函数类型定义
  using MessageCallback = std::function<void(const std::string& topic, const std::string& payload)>;

  MqttClient(const std::string& server_address, 
             const std::string& client_id,
             const std::string& username,
             const std::string& password,
             const std::string& ca_cert_path,
             int qos = 1);
  
  ~MqttClient();

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

private:
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
  
  // 消息回调函数
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
};

} // namespace mqtt_bridge

#endif // MQTT_BRIDGE_MQTT_CLIENT_H
  