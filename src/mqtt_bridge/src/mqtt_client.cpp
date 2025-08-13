#include <mqtt_client.h>
#include <mqtt/exception.h>
#include <iostream>
#include <chrono>
#include <thread>

namespace mqtt_bridge {

MQTTClient::Callback::Callback(MQTTClient& client) : client_(client) {}

void MQTTClient::Callback::connection_lost(const std::string& cause) {
    std::cout << "Connection lost: " << cause << std::endl;
    client_.connected_ = false;
    
    if (client_.connection_callback_) {
        client_.connection_callback_(false);
    }
    
    // 尝试重连
    client_.tryReconnect();
}

// void MQTTClient::Callback::message_arrived(mqtt::const_message_ptr msg) {
//     if (client_.message_callback_) {
//         client_.message_callback_(msg->get_topic(), msg->to_string());
//     }
// }
void MQTTClient::Callback::message_arrived(mqtt::const_message_ptr msg) {
    std::cout << "[DEBUG] Raw MQTT message received: Topic=" << msg->get_topic() << ", Payload=" << msg->to_string() << std::endl;
    if (client_.message_callback_) {
        client_.message_callback_(msg->get_topic(), msg->to_string());
    } else {
        std::cout << "[DEBUG] No message callback set!" << std::endl;
    }
}

void MQTTClient::Callback::delivery_complete(mqtt::delivery_token_ptr token) {}

void MQTTClient::Callback::on_failure(const mqtt::token& tok) {
    std::cout << "MQTT operation failed: " << tok.get_message_id() << std::endl;
    
    if (tok.get_type() == mqtt::token::CONNECT) {
        client_.connected_ = false;
        if (client_.connection_callback_) {
            client_.connection_callback_(false);
        }
        // 尝试重连
        client_.tryReconnect();
    }
}

void MQTTClient::Callback::on_success(const mqtt::token& tok) {
    if (tok.get_type() == mqtt::token::CONNECT) {
        std::cout << "Connected to MQTT server successfully" << std::endl;
        client_.connected_ = true;
        if (client_.connection_callback_) {
            client_.connection_callback_(true);
        }
    }
}

MQTTClient::MQTTClient(const std::string& server_uri, 
                       const std::string& client_id,
                       const std::string& ca_path,
                       const std::string& username,
                       const std::string& password,
                       int reconnect_interval)
    : server_uri_(server_uri),
      client_id_(client_id),
      ca_path_(ca_path),
      username_(username),
      password_(password),
      reconnect_interval_(reconnect_interval),
      connected_(false) {
    // 创建MQTT客户端
    client_ = std::make_unique<mqtt::async_client>(server_uri_, client_id_);
    
    // 创建回调对象
    callback_ = std::make_unique<Callback>(*this);
    client_->set_callback(*callback_);
    
    // 配置连接选项
    conn_opts_.set_clean_session(true);
    conn_opts_.set_automatic_reconnect(std::chrono::seconds(1), std::chrono::seconds(30));
    
    if (!username.empty()) {
        conn_opts_.set_user_name(username);
    }
    
    if (!password.empty()) {
        conn_opts_.set_password(password);
    }
    
    // 配置SSL选项
    mqtt::ssl_options ssl_opts;
    ssl_opts.set_trust_store(ca_path_);
    conn_opts_.set_ssl(ssl_opts);
}

MQTTClient::~MQTTClient() {
    disconnect();
}

bool MQTTClient::connect() {
    try {
        // std::cout << "Connecting to MQTT server: " << client_->get_server_uri() << std::endl;
        // std::cout << "keep_alive_interval: " << conn_opts_.get_keep_alive_interval().count() << "S" << std::endl;
        // std::cout << "username: " << (conn_opts_.get_user_name().empty() ? "no set" : conn_opts_.get_user_name()) << std::endl;
        // std::cout << "password: " << (conn_opts_.get_password_str().empty() ? "no set" : conn_opts_.get_password_str()) << std::endl;
        // std::cout << "ca_path: " << conn_opts_.get_ssl_options().get_trust_store() << std::endl;

    //     client_->connect(conn_opts_, nullptr, *callback_);
    //     if (client_->is_connected()) {
    //         std::cout << "Connect MQTT server success!!!" << std::endl;
    //         return true;
    //     } else {
    //         std::cout << "Connect MQTT server failed!!!" << std::endl;
    //         // return false;
    //     }   
    // } catch (const mqtt::exception& e) {
    //     std::cout << "=====================" << std::endl;
    //     std::cerr << "Connect failed: " << e.get_error_str() << " " << e.what() << std::endl;
    //     std::cout << "=====================" << std::endl;
    //     return false;
    // }
        
        // 异步连接不立即检查状态，依赖回调更新连接状态
        client_->connect(conn_opts_, nullptr, *callback_);
        
        // 等待连接完成（最多10秒）
        int wait_seconds = 10;
        std::cout << "Waiting for connection to complete... (max " << wait_seconds << "s)" << std::endl;
        for (int i = 0; i < wait_seconds; ++i) {
            std::cout << "Connect MQTT server, try " << i << " times" << std::endl;
            if (client_->is_connected()) {
                std::cout << "Connect MQTT server success!!!" << std::endl;
                break;
            }
            std::this_thread::sleep_for(std::chrono::seconds(1));
        }
    
        if (client_->is_connected()) {
            std::cout << "Connect MQTT server success!!!" << std::endl;
            return true;
        } else {
            std::cout << "Connect MQTT server failed!!!" << std::endl;
            std::cout << "Connect MQTT server timed out after " << wait_seconds << " seconds" << std::endl;
            // return false;
        }   
        // 超时仍未连接成功
        
        // return true;
    } catch (const mqtt::exception& e) {
        std::cout << "=====================" << std::endl;
        std::cerr << "Connect failed: " << e.get_error_str() << " (" << e.get_reason_code() << ")" << std::endl;
        std::cerr << "Error details: " << e.what() << std::endl;
        std::cout << "=====================" << std::endl;
        return false;
    }
}

void MQTTClient::disconnect() {
    if (client_ && connected_) {
        try {
            std::cout << "Disconnecting from MQTT server..." << std::endl;
            client_->disconnect()->wait();
            connected_ = false;
            if (connection_callback_) {
                connection_callback_(false);
            }
            std::cout << "Disconnected" << std::endl;
        } catch (const mqtt::exception& e) {
            std::cerr << "Disconnect failed: " << e.what() << std::endl;
        }
    }
}

bool MQTTClient::publish(const std::string& topic, const std::string& payload, 
                         int qos, bool retain) {
    if (!connected_) {
        std::cerr << "Cannot publish, not connected to MQTT server" << std::endl;
        return false;
    }
    
    try {
        mqtt::message_ptr msg = mqtt::make_message(topic, payload);
        msg->set_qos(qos);
        msg->set_retained(retain);
        client_->publish(msg)->wait_for(std::chrono::seconds(1));
        return true;
    } catch (const mqtt::exception& e) {
        std::cerr << "Publish failed: " << e.what() << std::endl;
        return false;
    }
}

bool MQTTClient::subscribe(const std::string& topic, int qos) {
    if (!connected_) {
        std::cerr << "Cannot subscribe, not connected to MQTT server" << std::endl;
        return false;
    }
    
    try {
        std::cout << "Subscribing to topic: " << topic << " with QoS " << qos << std::endl;
        // std::cout << "++++++++++++++++++++++" << std::endl;
        client_->subscribe(topic, qos);
        return true;
    } catch (const mqtt::exception& e) {
        std::cerr << "Subscribe failed: " << e.what() << std::endl;
        return false;
    }
}
// bool MQTTClient::subscribe(const std::string& topic, int qos) {
//     if (!connected_) {
//         std::cerr << "Cannot subscribe, not connected to MQTT server" << std::endl;
//         return false;
//     }
//     try {
//         std::cout << "[DEBUG] Subscribing to topic: " << topic << " with QoS " << qos << std::endl;
//         auto tok = client_->subscribe(topic, qos);
//         tok->wait(); // 等待订阅完成
//         std::cout << "[DEBUG] Subscribe result: " << tok->get_return_code() << std::endl;
//         return true;
//     } catch (const mqtt::exception& e) {
//         std::cerr << "Subscribe failed: " << e.what() << std::endl;
//         return false;
//     }
// }

bool MQTTClient::unsubscribe(const std::string& topic) {
    if (!connected_) {
        std::cerr << "Cannot unsubscribe, not connected to MQTT server" << std::endl;
        return false;
    }
    
    try {
        std::cout << "Unsubscribing from topic: " << topic << std::endl;
        client_->unsubscribe(topic)->wait();
        return true;
    } catch (const mqtt::exception& e) {
        std::cerr << "Unsubscribe failed: " << e.what() << std::endl;
        return false;
    }
}

void MQTTClient::setMessageCallback(MessageCallback callback) {
    message_callback_ = callback;
}

void MQTTClient::setConnectionCallback(ConnectionCallback callback) {
    connection_callback_ = callback;
}

void MQTTClient::tryReconnect() {
    if (connected_) return;
    
    std::cout << "Attempting to reconnect in " << reconnect_interval_ << "ms..." << std::endl;
    
    std::this_thread::sleep_for(std::chrono::milliseconds(reconnect_interval_));
    
    try {
        client_->connect(conn_opts_, nullptr, *callback_);
    } catch (const mqtt::exception& e) {
        std::cerr << "Reconnect failed: " << e.what() << std::endl;
        // 再次尝试重连
        tryReconnect();
    }
}

} // namespace mqtt_bridge
