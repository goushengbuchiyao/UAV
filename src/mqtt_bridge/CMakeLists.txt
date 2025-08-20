cmake_minimum_required(VERSION 3.0.2)
project(mqtt_bridge)

## Compile as C++11, supported in ROS Kinetic and newer
add_compile_options(-std=c++17)
## Find catkin macros and libraries
find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  geometry_msgs
  message_generation
  sensor_msgs
  uav_msgs
  mavros_msgs
  tf
)



## System dependencies are found with CMake's conventions
## 查找 JsonCpp，使用 Config 模式
find_package(PkgConfig REQUIRED)
# pkg_check_modules(JSONCPP REQUIRED jsoncpp)
find_package(PahoMqttCpp REQUIRED)
find_package(OpenSSL REQUIRED)
find_package(nlohmann_json REQUIRED)
## Generate messages in the 'msg' folder
# add_message_files(
#   FILES
# )

## Generate added messages and services with any dependencies listed here
# 移除generate_messages避免目标冲突
# generate_messages(
#   DEPENDENCIES
#   geometry_msgs
#   std_msgs
#   sensor_msgs
#   uav_msgs
#   mavros_msgs
# )

## Declare a catkin package
catkin_package(
  CATKIN_DEPENDS roscpp std_msgs message_runtime geometry_msgs sensor_msgs uav_msgs mavros_msgs 
  DEPENDS PahoMqttCpp OpenSSL
)
# set(JSONCPP_INCLUDE_DIR "/usr/include/jsoncpp")
## Specify additional locations of header files
include_directories(
  ${catkin_INCLUDE_DIRS}
  ${PROJECT_SOURCE_DIR}/include
  # ${PAHO_MQTT_CPP_INCLUDE_DIRS}
  # ${OPENSSL_INCLUDE_DIR}
  ${JSONCPP_INCLUDE_DIRS}
  ${Boost_INCLUDE_DIRS}
)

add_executable(mqtt_bridge_node
  src/main.cpp
  src/mqtt_ros_node.cpp
  src/mqtt_client.cpp
  src/uav_state_collector.cpp
  src/uav_command_parser.cpp
  # src/uav_state_publisher.cpp
  # src/message_converter.cpp
)
## Declare a C++ executable
# add_executable(mqtt_bridge_node src/mqtt_bridge_node.cpp src/mqtt_client.cpp)

## Specify libraries to link a library or executable target against
target_link_libraries(mqtt_bridge_node
  ${catkin_LIBRARIES}
  PahoMqttCpp::paho-mqttpp3-shared
  # PahoMqttCpp::paho-mqtt3as
  ${OPENSSL_LIBRARIES}
  ${JSONCPP_LIBRARIES}  
  ${Boost_LIBRARIES}
)

## Add cmake target dependencies of the executable
add_dependencies(mqtt_bridge_node ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})