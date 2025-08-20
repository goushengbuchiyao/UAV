cmake_minimum_required(VERSION 3.0.2)
project(uav_msgs)

find_package(catkin REQUIRED COMPONENTS
  roscpp
  rospy
  std_msgs
  mavros_msgs
  geometry_msgs
  message_generation
)

add_message_files(
  FILES
  TakeoffCommand.msg
  LandCommand.msg
  PositionControlNEDCommand.msg
  PositionControlGlobalCommand.msg
  VelocityControlNEDCommand.msg
  ReturnToLaunchCommand.msg
  HoverCommand.msg
  SetModeCommand.msg
  UAVControlCommand.msg
  WaypointsCommand.msg
  Waypoint.msg
)

generate_messages(
  DEPENDENCIES
  std_msgs
  mavros_msgs
  geometry_msgs
)

catkin_package(
  CATKIN_DEPENDS message_runtime std_msgs geometry_msgs mavros_msgs
)