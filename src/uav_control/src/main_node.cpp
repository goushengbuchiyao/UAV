#include <ros/ros.h>
#include <std_msgs/String.h>
#include "uav_control/rc_monitor.h"
#include "uav_control/command_dispatcher.h"
#include "uav_control/controller_manager.h"
#include "uav_control/setpoint_publisher.h"
#include "uav_control/safety_monitor.h"
#include <uav_msgs/UAVControlCommand.h> // use your top-level message package

class UAVControlMain {
public:
    UAVControlMain(ros::NodeHandle& nh) : nh_(nh) {
        nh_.param<std::string>("uav_id", uav_id_, "uav1");
        ns_ = "/" + uav_id_;
        // init modules
        rc_monitor_.init(nh_, ns_);
        dispatcher_.init(nh_, ns_);
        ctrl_mgr_.init(nh_, ns_);
        spub_.init(nh_, ns_, 20.0);
        safety_.init(nh_, ns_);

        // subscribe to the ROS-mapped command topic (published by MQTT bridge)
        std::string cmd_topic;
        nh_.param<std::string>("ros_command_topic", cmd_topic, "/mqtt_ros_bridge"+ ns_ + "/ros/uavcontrol/command");
        ROS_INFO("Subscribing to command topic: %s", cmd_topic.c_str());
        cmd_sub_ = nh_.subscribe<uav_msgs::UAVControlCommand>(cmd_topic, 20, &UAVControlMain::cmdCallback, this);

        // status/ack publisher
        ack_pub_ = nh_.advertise<std_msgs::String>(ns_ + "/ros/command_ack", 10);
    }

    void cmdCallback(const uav_msgs::UAVControlCommand::ConstPtr& msg) {
        double now = ros::Time::now().toSec();
        double msg_time = msg->timestamp.sec;
        std::cout << "++++++++++++++++++++++" << std::endl;
        std::cout << "Received command: " << msg << std::endl;
        if (std::abs(now - msg_time) > 10.0) {
            ROS_WARN("Command timestamp too old/new: now=%.1f msg=%.1f", now, msg_time);
            return;
        }

        if (rc_monitor_.isRCOverride()) {
            ROS_WARN("RC override active -> ignore command");
            std_msgs::String ack; ack.data = "ignored:rc_override";
            ack_pub_.publish(ack);
            return;
        }

        std::string reason;
        bool ok = dispatcher_.execute(*msg, reason);
        std_msgs::String ack;
        ack.data = ok ? "ok" : "failed:" + reason;
        ack_pub_.publish(ack);

        // 如果是位置控制，启动 setpoint publisher
        if (msg->command_type == "position_control_ned") {
            geometry_msgs::PoseStamped p;
            p.header.stamp = ros::Time::now();
            p.pose.position.x = msg->pos_ned.y;   // E
            p.pose.position.y = msg->pos_ned.x;   // N
            p.pose.position.z = -msg->pos_ned.z;  // up
            spub_.updatePose(p);
            spub_.start();
        }
}

    void spin() {
        ros::Rate r(20);
        while (ros::ok()) {
            ros::spinOnce();
            // if RC override detected, stop setpoint publisher
            if (rc_monitor_.isRCOverride()) spub_.stop();
            r.sleep();
        }
    }

private:
    ros::NodeHandle nh_;
    std::string uav_id_;
    std::string ns_;
    ros::Subscriber cmd_sub_;
    ros::Publisher ack_pub_;

    RCMonitor rc_monitor_;
    CommandDispatcher dispatcher_;
    ControllerManager ctrl_mgr_;
    SetpointPublisher spub_;
    SafetyMonitor safety_;
};

int main(int argc, char** argv) {
    ros::init(argc, argv, "uav_control_node");
    ros::NodeHandle nh("~");
    UAVControlMain app(nh);
    app.spin();
    return 0;
}
