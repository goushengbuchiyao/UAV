#ifndef MQTT_BRIDGE_MQTT_CLIENT_H
#define MQTT_BRIDGE_MQTT_CLIENT_H

#include <mqtt/async_client.h>
#include <mqtt/ssl_options.h>
#include <string>
#include <functional>
#include <memory>
#include <atomic>

namespace mqtt_bridge {

class MQTTClient {
public:
    // 回调函数类型定义
    using MessageCallback = std::function<void(const std::string& topic, const std::string& payload)>;
    using ConnectionCallback = std::function<void(bool connected)>;

    /**
     * @brief MQTT客户端构造函数
     * @param server_uri MQTT服务器URI
     * @param client_id 客户端ID
     * @param ca_path CA证书路径
     * @param username 用户名
     * @param password 密码
     * @param reconnect_interval 重连间隔(毫秒)
     */
    MQTTClient(const std::string& server_uri, 
               const std::string& client_id,
               const std::string& ca_path,
               const std::string& username = "",
               const std::string& password = "",
               int reconnect_interval = 5000);

    ~MQTTClient();

    /**
     * @brief 连接到MQTT服务器
     * @return 是否成功启动连接过程
     */
    bool connect();

    /**
     * @brief 断开与MQTT服务器的连接
     */
    void disconnect();

    /**
     * @brief 发布消息到指定主题
     * @param topic 主题
     * @param payload 消息内容
     * @param qos QoS级别
     * @param retain 是否保留消息
     * @return 是否成功发布
     */
    bool publish(const std::string& topic, const std::string& payload, 
                 int qos = 1, bool retain = false);

    /**
     * @brief 订阅主题
     * @param topic 主题
     * @param qos QoS级别
     * @return 是否成功订阅
     */
    bool subscribe(const std::string& topic, int qos = 1);

    /**
     * @brief 取消订阅主题
     * @param topic 主题
     * @return 是否成功取消订阅
     */
    bool unsubscribe(const std::string& topic);

    /**
     * @brief 设置消息接收回调函数
     * @param callback 回调函数
     */
    void setMessageCallback(MessageCallback callback);

    /**
     * @brief 设置连接状态变化回调函数
     * @param callback 回调函数
     */
    void setConnectionCallback(ConnectionCallback callback);

    /**
     * @brief 检查是否已连接
     * @return 是否连接
     */
    bool isConnected() const { return connected_; }

private:
    class Callback : public virtual mqtt::callback, 
                     public virtual mqtt::iaction_listener {
    public:
        Callback(MQTTClient& client);

        // mqtt::callback 接口
        void connection_lost(const std::string& cause) override;
        void message_arrived(mqtt::const_message_ptr msg) override;
        void delivery_complete(mqtt::delivery_token_ptr token) override;

        // mqtt::iaction_listener 接口
        void on_failure(const mqtt::token& tok) override;
        void on_success(const mqtt::token& tok) override;

    private:
        MQTTClient& client_;
    };

    std::string server_uri_;
    std::string client_id_;
    std::string ca_path_;
    std::string username_;
    std::string password_;
    int reconnect_interval_;
    
    std::unique_ptr<mqtt::async_client> client_;
    std::unique_ptr<Callback> callback_;
    mqtt::connect_options conn_opts_;
    
    std::atomic<bool> connected_;
    MessageCallback message_callback_;
    ConnectionCallback connection_callback_;

    // 尝试重连
    void tryReconnect();
};

} // namespace mqtt_bridge

#endif // MQTT_BRIDGE_MQTT_CLIENT_H
