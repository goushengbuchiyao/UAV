cmake_minimum_required(VERSION 3.0.2)
project(uav_control)

add_compile_options(-std=c++14 -Wall)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  sensor_msgs
  nav_msgs
  geometry_msgs
  mavros_msgs
  uav_msgs
)

catkin_package(
  CATKIN_DEPENDS roscpp std_msgs sensor_msgs nav_msgs geometry_msgs mavros_msgs uav_msgs
)

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

add_executable(uav_control_node
  src/main.cpp
  src/uav_control_node.cpp
  src/safety_checker.cpp
  src/command_executor.cpp
)

target_link_libraries(uav_control_node ${catkin_LIBRARIES})
