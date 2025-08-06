cmake_minimum_required(VERSION 3.0.2)
project(mqtt_camera_interface)

## Compile as C++11, supported in ROS Kinetic and newer
add_compile_options(-std=c++17)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  mavros_msgs
  roscpp
  std_msgs
  message_generation
)

## System dependencies are found with CMake's conventions
# find_package(Boost REQUIRED COMPONENTS system)
# find_package(nlohmann_json REQUIRED)
find_package(PahoMqttCpp REQUIRED)

include_directories(
  ${catkin_INCLUDE_DIRS}
  ${PAHO_MQTT_CPP_INCLUDE_DIRS}
  ${JSONCPP_INCLUDE_DIRS}
)

catkin_package(
  INCLUDE_DIRS include
  LIBRARIES mqtt_camera_interface
  CATKIN_DEPENDS roscpp mavros_msgs std_msgs
)

add_executable(mqtt_camera_node src/mqtt_camera_node.cpp)
add_dependencies(mqtt_camera_node ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})

target_link_libraries(mqtt_camera_node
  ${catkin_LIBRARIES}
  # nlohmann_json::nlohmann_json
  PahoMqttCpp::paho-mqttpp3-shared
  PahoMqttCpp::paho-mqtt3as
)