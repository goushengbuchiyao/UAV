# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "px_uav_msgs: 19 messages, 0 services")

set(MSG_I_FLAGS "-Ipx_uav_msgs:/home/px/UAV_SDK/src/common/px_uav_msgs/msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/noetic/share/sensor_msgs/cmake/../msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(px_uav_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg" "std_msgs/Header:geometry_msgs/Quaternion"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUAVState.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUAVState.msg" "std_msgs/Header:geometry_msgs/Quaternion:px_uav_msgs/UAVState"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVCommand.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVCommand.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVControlState.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVControlState.msg" "std_msgs/Header:geometry_msgs/Point:geometry_msgs/Vector3"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVSetup.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVSetup.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/TextInfo.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/TextInfo.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GlobalAruco.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GlobalAruco.msg" "std_msgs/Header:px_uav_msgs/ArucoInfo"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg" "std_msgs/Header:geometry_msgs/Quaternion"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVCommand.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVCommand.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUGVState.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUGVState.msg" "std_msgs/Header:px_uav_msgs/UGVState:geometry_msgs/Quaternion"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/PositionReference.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/PositionReference.msg" "std_msgs/Header"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/StationCommand.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/StationCommand.msg" "geometry_msgs/PoseStamped:std_msgs/Header:geometry_msgs/Point:geometry_msgs/Pose:geometry_msgs/Quaternion"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/SwarmCommand.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/SwarmCommand.msg" "std_msgs/Header:geometry_msgs/Point"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/FormationAssign.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/FormationAssign.msg" "geometry_msgs/Point"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/OffsetPose.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/OffsetPose.msg" ""
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GPSData.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GPSData.msg" ""
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg" ""
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNodeframe2.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNodeframe2.msg" "px_uav_msgs/LinktrackNode2"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ParamSettings.msg" NAME_WE)
add_custom_target(_px_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "px_uav_msgs" "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ParamSettings.msg" ""
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVControlState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVSetup.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/TextInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GlobalAruco.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ArucoInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/PositionReference.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/StationCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/SwarmCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/FormationAssign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/OffsetPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GPSData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNodeframe2.msg"
  "${MSG_I_FLAGS}"
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_cpp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ParamSettings.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(px_uav_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(px_uav_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(px_uav_msgs_generate_messages px_uav_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUAVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVControlState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVSetup.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/TextInfo.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GlobalAruco.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUGVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/PositionReference.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/StationCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/SwarmCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/FormationAssign.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/OffsetPose.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GPSData.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNodeframe2.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ParamSettings.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_cpp _px_uav_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(px_uav_msgs_gencpp)
add_dependencies(px_uav_msgs_gencpp px_uav_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS px_uav_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVControlState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVSetup.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/TextInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GlobalAruco.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ArucoInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/PositionReference.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/StationCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/SwarmCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/FormationAssign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/OffsetPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GPSData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNodeframe2.msg"
  "${MSG_I_FLAGS}"
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_eus(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ParamSettings.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
)

### Generating Services

### Generating Module File
_generate_module_eus(px_uav_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(px_uav_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(px_uav_msgs_generate_messages px_uav_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUAVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVControlState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVSetup.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/TextInfo.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GlobalAruco.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUGVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/PositionReference.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/StationCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/SwarmCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/FormationAssign.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/OffsetPose.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GPSData.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNodeframe2.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ParamSettings.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_eus _px_uav_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(px_uav_msgs_geneus)
add_dependencies(px_uav_msgs_geneus px_uav_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS px_uav_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVControlState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVSetup.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/TextInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GlobalAruco.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ArucoInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/PositionReference.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/StationCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/SwarmCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/FormationAssign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/OffsetPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GPSData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNodeframe2.msg"
  "${MSG_I_FLAGS}"
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_lisp(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ParamSettings.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(px_uav_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(px_uav_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(px_uav_msgs_generate_messages px_uav_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUAVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVControlState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVSetup.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/TextInfo.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GlobalAruco.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUGVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/PositionReference.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/StationCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/SwarmCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/FormationAssign.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/OffsetPose.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GPSData.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNodeframe2.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ParamSettings.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_lisp _px_uav_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(px_uav_msgs_genlisp)
add_dependencies(px_uav_msgs_genlisp px_uav_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS px_uav_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVControlState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVSetup.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/TextInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GlobalAruco.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ArucoInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/PositionReference.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/StationCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/SwarmCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/FormationAssign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/OffsetPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GPSData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNodeframe2.msg"
  "${MSG_I_FLAGS}"
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_nodejs(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ParamSettings.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
)

### Generating Services

### Generating Module File
_generate_module_nodejs(px_uav_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(px_uav_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(px_uav_msgs_generate_messages px_uav_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUAVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVControlState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVSetup.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/TextInfo.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GlobalAruco.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUGVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/PositionReference.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/StationCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/SwarmCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/FormationAssign.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/OffsetPose.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GPSData.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNodeframe2.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ParamSettings.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_nodejs _px_uav_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(px_uav_msgs_gennodejs)
add_dependencies(px_uav_msgs_gennodejs px_uav_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS px_uav_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUAVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVControlState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Vector3.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVSetup.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/TextInfo.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GlobalAruco.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ArucoInfo.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUGVState.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/PositionReference.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/StationCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/PoseStamped.msg;/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Pose.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Quaternion.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/SwarmCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/std_msgs/cmake/../msg/Header.msg;/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/FormationAssign.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/geometry_msgs/cmake/../msg/Point.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/OffsetPose.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GPSData.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNodeframe2.msg"
  "${MSG_I_FLAGS}"
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)
_generate_msg_py(px_uav_msgs
  "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ParamSettings.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(px_uav_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(px_uav_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(px_uav_msgs_generate_messages px_uav_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUAVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVControlState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVSetup.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/TextInfo.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GlobalAruco.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUGVState.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/PositionReference.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/StationCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/SwarmCommand.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/FormationAssign.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/OffsetPose.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GPSData.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNodeframe2.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ParamSettings.msg" NAME_WE)
add_dependencies(px_uav_msgs_generate_messages_py _px_uav_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(px_uav_msgs_genpy)
add_dependencies(px_uav_msgs_genpy px_uav_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS px_uav_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/px_uav_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(px_uav_msgs_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()
if(TARGET sensor_msgs_generate_messages_cpp)
  add_dependencies(px_uav_msgs_generate_messages_cpp sensor_msgs_generate_messages_cpp)
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(px_uav_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/px_uav_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(px_uav_msgs_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()
if(TARGET sensor_msgs_generate_messages_eus)
  add_dependencies(px_uav_msgs_generate_messages_eus sensor_msgs_generate_messages_eus)
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(px_uav_msgs_generate_messages_eus std_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/px_uav_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(px_uav_msgs_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()
if(TARGET sensor_msgs_generate_messages_lisp)
  add_dependencies(px_uav_msgs_generate_messages_lisp sensor_msgs_generate_messages_lisp)
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(px_uav_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/px_uav_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(px_uav_msgs_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()
if(TARGET sensor_msgs_generate_messages_nodejs)
  add_dependencies(px_uav_msgs_generate_messages_nodejs sensor_msgs_generate_messages_nodejs)
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(px_uav_msgs_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/px_uav_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(px_uav_msgs_generate_messages_py geometry_msgs_generate_messages_py)
endif()
if(TARGET sensor_msgs_generate_messages_py)
  add_dependencies(px_uav_msgs_generate_messages_py sensor_msgs_generate_messages_py)
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(px_uav_msgs_generate_messages_py std_msgs_generate_messages_py)
endif()
