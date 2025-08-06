# generated from catkin/cmake/template/pkg.context.pc.in
CATKIN_PACKAGE_PREFIX = ""
PROJECT_PKG_CONFIG_INCLUDE_DIRS = "${prefix}/include".split(';') if "${prefix}/include" != "" else []
PROJECT_CATKIN_DEPENDS = "roscpp;std_msgs;mavros_msgs;sensor_msgs;geometry_msgs;nav_msgs".replace(';', ' ')
PKG_CONFIG_LIBRARIES_WITH_PREFIX = "-lmqtt_ros_bridge".split(';') if "-lmqtt_ros_bridge" != "" else []
PROJECT_NAME = "mqtt_ros_bridge"
PROJECT_SPACE_DIR = "/home/px/UAV_SDK/install"
PROJECT_VERSION = "0.0.0"
