cmake_minimum_required(VERSION 3.0.2)
project(uav_control)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  std_msgs
  mavros_msgs
  uav_msgs
  geometry_msgs
)
find_package(yaml-cpp REQUIRED)

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
  src/rc_input.cpp
)

target_link_libraries(uav_control_node
  ${catkin_LIBRARIES}
  ${YAML_CPP_LIBRARIES}
)

install(TARGETS uav_control_node
  RUNTIME DESTINATION ${CATKIN_PACKAGE_BIN_DESTINATION}
)
