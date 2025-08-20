# generated from genmsg/cmake/pkg-genmsg.cmake.em

message(STATUS "uav_msgs: 11 messages, 0 services")

set(MSG_I_FLAGS "-Iuav_msgs:/home/px/UAV_SDK/src/uav_msgs/msg;-Istd_msgs:/opt/ros/noetic/share/std_msgs/cmake/../msg;-Imavros_msgs:/opt/ros/noetic/share/mavros_msgs/cmake/../msg;-Igeometry_msgs:/opt/ros/noetic/share/geometry_msgs/cmake/../msg;-Igeographic_msgs:/opt/ros/noetic/share/geographic_msgs/cmake/../msg;-Isensor_msgs:/opt/ros/noetic/share/sensor_msgs/cmake/../msg;-Iuuid_msgs:/opt/ros/noetic/share/uuid_msgs/cmake/../msg")

# Find all generators
find_package(gencpp REQUIRED)
find_package(geneus REQUIRED)
find_package(genlisp REQUIRED)
find_package(gennodejs REQUIRED)
find_package(genpy REQUIRED)

add_custom_target(uav_msgs_generate_messages ALL)

# verify that message/service dependencies have not changed since configure



get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg" NAME_WE)
add_custom_target(_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uav_msgs" "/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg" ""
)

get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg" NAME_WE)
add_custom_target(_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uav_msgs" "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg" ""
)

get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg" NAME_WE)
add_custom_target(_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uav_msgs" "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg" ""
)

get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg" NAME_WE)
add_custom_target(_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uav_msgs" "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg" ""
)

get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg" NAME_WE)
add_custom_target(_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uav_msgs" "/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg" ""
)

get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg" NAME_WE)
add_custom_target(_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uav_msgs" "/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg" ""
)

get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg" NAME_WE)
add_custom_target(_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uav_msgs" "/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg" ""
)

get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg" NAME_WE)
add_custom_target(_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uav_msgs" "/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg" ""
)

get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/UAVControlCommand.msg" NAME_WE)
add_custom_target(_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uav_msgs" "/home/px/UAV_SDK/src/uav_msgs/msg/UAVControlCommand.msg" "uav_msgs/LandCommand:uav_msgs/WaypointsCommand:uav_msgs/PositionControlGlobalCommand:uav_msgs/PositionControlNEDCommand:mavros_msgs/Waypoint:uav_msgs/VelocityControlNEDCommand:uav_msgs/ReturnToLaunchCommand:uav_msgs/Waypoint:uav_msgs/SetModeCommand:uav_msgs/HoverCommand:uav_msgs/TakeoffCommand"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg" NAME_WE)
add_custom_target(_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uav_msgs" "/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg" "mavros_msgs/Waypoint:uav_msgs/Waypoint"
)

get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg" NAME_WE)
add_custom_target(_uav_msgs_generate_messages_check_deps_${_filename}
  COMMAND ${CATKIN_ENV} ${PYTHON_EXECUTABLE} ${GENMSG_CHECK_DEPS_SCRIPT} "uav_msgs" "/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg" "mavros_msgs/Waypoint"
)

#
#  langs = gencpp;geneus;genlisp;gennodejs;genpy
#

### Section generating for lang: gencpp
### Generating Messages
_generate_msg_cpp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_msgs
)
_generate_msg_cpp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_msgs
)
_generate_msg_cpp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_msgs
)
_generate_msg_cpp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_msgs
)
_generate_msg_cpp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_msgs
)
_generate_msg_cpp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_msgs
)
_generate_msg_cpp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_msgs
)
_generate_msg_cpp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_msgs
)
_generate_msg_cpp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/UAVControlCommand.msg"
  "${MSG_I_FLAGS}"
  "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg;/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_msgs
)
_generate_msg_cpp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_msgs
)
_generate_msg_cpp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_msgs
)

### Generating Services

### Generating Module File
_generate_module_cpp(uav_msgs
  ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_msgs
  "${ALL_GEN_OUTPUT_FILES_cpp}"
)

add_custom_target(uav_msgs_generate_messages_cpp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_cpp}
)
add_dependencies(uav_msgs_generate_messages uav_msgs_generate_messages_cpp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_cpp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_cpp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_cpp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_cpp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_cpp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_cpp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_cpp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_cpp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/UAVControlCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_cpp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_cpp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_cpp _uav_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uav_msgs_gencpp)
add_dependencies(uav_msgs_gencpp uav_msgs_generate_messages_cpp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uav_msgs_generate_messages_cpp)

### Section generating for lang: geneus
### Generating Messages
_generate_msg_eus(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_msgs
)
_generate_msg_eus(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_msgs
)
_generate_msg_eus(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_msgs
)
_generate_msg_eus(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_msgs
)
_generate_msg_eus(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_msgs
)
_generate_msg_eus(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_msgs
)
_generate_msg_eus(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_msgs
)
_generate_msg_eus(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_msgs
)
_generate_msg_eus(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/UAVControlCommand.msg"
  "${MSG_I_FLAGS}"
  "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg;/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_msgs
)
_generate_msg_eus(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_msgs
)
_generate_msg_eus(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_msgs
)

### Generating Services

### Generating Module File
_generate_module_eus(uav_msgs
  ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_msgs
  "${ALL_GEN_OUTPUT_FILES_eus}"
)

add_custom_target(uav_msgs_generate_messages_eus
  DEPENDS ${ALL_GEN_OUTPUT_FILES_eus}
)
add_dependencies(uav_msgs_generate_messages uav_msgs_generate_messages_eus)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_eus _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_eus _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_eus _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_eus _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_eus _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_eus _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_eus _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_eus _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/UAVControlCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_eus _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_eus _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_eus _uav_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uav_msgs_geneus)
add_dependencies(uav_msgs_geneus uav_msgs_generate_messages_eus)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uav_msgs_generate_messages_eus)

### Section generating for lang: genlisp
### Generating Messages
_generate_msg_lisp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_msgs
)
_generate_msg_lisp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_msgs
)
_generate_msg_lisp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_msgs
)
_generate_msg_lisp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_msgs
)
_generate_msg_lisp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_msgs
)
_generate_msg_lisp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_msgs
)
_generate_msg_lisp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_msgs
)
_generate_msg_lisp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_msgs
)
_generate_msg_lisp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/UAVControlCommand.msg"
  "${MSG_I_FLAGS}"
  "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg;/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_msgs
)
_generate_msg_lisp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_msgs
)
_generate_msg_lisp(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_msgs
)

### Generating Services

### Generating Module File
_generate_module_lisp(uav_msgs
  ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_msgs
  "${ALL_GEN_OUTPUT_FILES_lisp}"
)

add_custom_target(uav_msgs_generate_messages_lisp
  DEPENDS ${ALL_GEN_OUTPUT_FILES_lisp}
)
add_dependencies(uav_msgs_generate_messages uav_msgs_generate_messages_lisp)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_lisp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_lisp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_lisp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_lisp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_lisp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_lisp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_lisp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_lisp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/UAVControlCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_lisp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_lisp _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_lisp _uav_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uav_msgs_genlisp)
add_dependencies(uav_msgs_genlisp uav_msgs_generate_messages_lisp)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uav_msgs_generate_messages_lisp)

### Section generating for lang: gennodejs
### Generating Messages
_generate_msg_nodejs(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uav_msgs
)
_generate_msg_nodejs(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uav_msgs
)
_generate_msg_nodejs(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uav_msgs
)
_generate_msg_nodejs(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uav_msgs
)
_generate_msg_nodejs(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uav_msgs
)
_generate_msg_nodejs(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uav_msgs
)
_generate_msg_nodejs(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uav_msgs
)
_generate_msg_nodejs(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uav_msgs
)
_generate_msg_nodejs(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/UAVControlCommand.msg"
  "${MSG_I_FLAGS}"
  "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg;/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uav_msgs
)
_generate_msg_nodejs(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uav_msgs
)
_generate_msg_nodejs(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uav_msgs
)

### Generating Services

### Generating Module File
_generate_module_nodejs(uav_msgs
  ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uav_msgs
  "${ALL_GEN_OUTPUT_FILES_nodejs}"
)

add_custom_target(uav_msgs_generate_messages_nodejs
  DEPENDS ${ALL_GEN_OUTPUT_FILES_nodejs}
)
add_dependencies(uav_msgs_generate_messages uav_msgs_generate_messages_nodejs)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_nodejs _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_nodejs _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_nodejs _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_nodejs _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_nodejs _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_nodejs _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_nodejs _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_nodejs _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/UAVControlCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_nodejs _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_nodejs _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_nodejs _uav_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uav_msgs_gennodejs)
add_dependencies(uav_msgs_gennodejs uav_msgs_generate_messages_nodejs)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uav_msgs_generate_messages_nodejs)

### Section generating for lang: genpy
### Generating Messages
_generate_msg_py(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs
)
_generate_msg_py(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs
)
_generate_msg_py(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs
)
_generate_msg_py(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs
)
_generate_msg_py(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs
)
_generate_msg_py(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs
)
_generate_msg_py(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs
)
_generate_msg_py(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg"
  "${MSG_I_FLAGS}"
  ""
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs
)
_generate_msg_py(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/UAVControlCommand.msg"
  "${MSG_I_FLAGS}"
  "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg;/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg;/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs
)
_generate_msg_py(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg;/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs
)
_generate_msg_py(uav_msgs
  "/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg"
  "${MSG_I_FLAGS}"
  "/opt/ros/noetic/share/mavros_msgs/cmake/../msg/Waypoint.msg"
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs
)

### Generating Services

### Generating Module File
_generate_module_py(uav_msgs
  ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs
  "${ALL_GEN_OUTPUT_FILES_py}"
)

add_custom_target(uav_msgs_generate_messages_py
  DEPENDS ${ALL_GEN_OUTPUT_FILES_py}
)
add_dependencies(uav_msgs_generate_messages uav_msgs_generate_messages_py)

# add dependencies to all check dependencies targets
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/TakeoffCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_py _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/LandCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_py _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlNEDCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_py _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/PositionControlGlobalCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_py _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/VelocityControlNEDCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_py _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/ReturnToLaunchCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_py _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/HoverCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_py _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/SetModeCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_py _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/UAVControlCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_py _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/WaypointsCommand.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_py _uav_msgs_generate_messages_check_deps_${_filename})
get_filename_component(_filename "/home/px/UAV_SDK/src/uav_msgs/msg/Waypoint.msg" NAME_WE)
add_dependencies(uav_msgs_generate_messages_py _uav_msgs_generate_messages_check_deps_${_filename})

# target for backward compatibility
add_custom_target(uav_msgs_genpy)
add_dependencies(uav_msgs_genpy uav_msgs_generate_messages_py)

# register target for catkin_package(EXPORTED_TARGETS)
list(APPEND ${PROJECT_NAME}_EXPORTED_TARGETS uav_msgs_generate_messages_py)



if(gencpp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gencpp_INSTALL_DIR}/uav_msgs
    DESTINATION ${gencpp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_cpp)
  add_dependencies(uav_msgs_generate_messages_cpp std_msgs_generate_messages_cpp)
endif()
if(TARGET mavros_msgs_generate_messages_cpp)
  add_dependencies(uav_msgs_generate_messages_cpp mavros_msgs_generate_messages_cpp)
endif()
if(TARGET geometry_msgs_generate_messages_cpp)
  add_dependencies(uav_msgs_generate_messages_cpp geometry_msgs_generate_messages_cpp)
endif()

if(geneus_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${geneus_INSTALL_DIR}/uav_msgs
    DESTINATION ${geneus_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_eus)
  add_dependencies(uav_msgs_generate_messages_eus std_msgs_generate_messages_eus)
endif()
if(TARGET mavros_msgs_generate_messages_eus)
  add_dependencies(uav_msgs_generate_messages_eus mavros_msgs_generate_messages_eus)
endif()
if(TARGET geometry_msgs_generate_messages_eus)
  add_dependencies(uav_msgs_generate_messages_eus geometry_msgs_generate_messages_eus)
endif()

if(genlisp_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genlisp_INSTALL_DIR}/uav_msgs
    DESTINATION ${genlisp_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_lisp)
  add_dependencies(uav_msgs_generate_messages_lisp std_msgs_generate_messages_lisp)
endif()
if(TARGET mavros_msgs_generate_messages_lisp)
  add_dependencies(uav_msgs_generate_messages_lisp mavros_msgs_generate_messages_lisp)
endif()
if(TARGET geometry_msgs_generate_messages_lisp)
  add_dependencies(uav_msgs_generate_messages_lisp geometry_msgs_generate_messages_lisp)
endif()

if(gennodejs_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uav_msgs)
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${gennodejs_INSTALL_DIR}/uav_msgs
    DESTINATION ${gennodejs_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_nodejs)
  add_dependencies(uav_msgs_generate_messages_nodejs std_msgs_generate_messages_nodejs)
endif()
if(TARGET mavros_msgs_generate_messages_nodejs)
  add_dependencies(uav_msgs_generate_messages_nodejs mavros_msgs_generate_messages_nodejs)
endif()
if(TARGET geometry_msgs_generate_messages_nodejs)
  add_dependencies(uav_msgs_generate_messages_nodejs geometry_msgs_generate_messages_nodejs)
endif()

if(genpy_INSTALL_DIR AND EXISTS ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs)
  install(CODE "execute_process(COMMAND \"/usr/bin/python3\" -m compileall \"${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs\")")
  # install generated code
  install(
    DIRECTORY ${CATKIN_DEVEL_PREFIX}/${genpy_INSTALL_DIR}/uav_msgs
    DESTINATION ${genpy_INSTALL_DIR}
  )
endif()
if(TARGET std_msgs_generate_messages_py)
  add_dependencies(uav_msgs_generate_messages_py std_msgs_generate_messages_py)
endif()
if(TARGET mavros_msgs_generate_messages_py)
  add_dependencies(uav_msgs_generate_messages_py mavros_msgs_generate_messages_py)
endif()
if(TARGET geometry_msgs_generate_messages_py)
  add_dependencies(uav_msgs_generate_messages_py geometry_msgs_generate_messages_py)
endif()
