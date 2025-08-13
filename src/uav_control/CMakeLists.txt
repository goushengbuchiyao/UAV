cmake_minimum_required(VERSION 3.0.2)
project(uav_control)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  mavros_msgs
  uav_msgs
  geometry_msgs
)

catkin_package(
  INCLUDE_DIRS include
  CATKIN_DEPENDS roscpp std_msgs mavros_msgs uav_msgs geometry_msgs
)

include_directories(
  include
  ${catkin_INCLUDE_DIRS}
)

add_executable(uav_control_node
  src/uav_control_node.cpp
  src/safety_checker.cpp
  src/px4_param_loader.cpp
  src/command_executor.cpp
)

target_link_libraries(uav_control_node
  ${catkin_LIBRARIES}
)

install(TARGETS uav_control_node
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
