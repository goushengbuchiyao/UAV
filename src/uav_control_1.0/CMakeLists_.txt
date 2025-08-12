cmake_minimum_required(VERSION 3.0.2)
project(uav_control)

add_compile_options(-std=c++14)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  geometry_msgs
  sensor_msgs
  mavros_msgs
  tf2
  tf2_ros
  message_generation
  uav_msgs
)
# generate_messages(
#   DEPENDENCIES
#   std_msgs
#   geometry_msgs
#   sensor_msgs
#   uav_msgs
# )

catkin_package(
  CATKIN_DEPENDS roscpp std_msgs geometry_msgs sensor_msgs mavros_msgs tf2 tf2_ros uav_msgs
)

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

add_executable(uav_control_node
  src/main_node.cpp
  src/rc_monitor.cpp
  src/command_dispatcher.cpp
  src/controller_manager.cpp
  src/setpoint_publisher.cpp
  src/safety_monitor.cpp
)

target_link_libraries(uav_control_node ${catkin_LIBRARIES})
