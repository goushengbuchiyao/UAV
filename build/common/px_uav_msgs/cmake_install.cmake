# Install script for directory: /home/px/UAV_SDK/src/common/px_uav_msgs

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/home/px/UAV_SDK/install")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Install shared libraries without execute permission?
if(NOT DEFINED CMAKE_INSTALL_SO_NO_EXE)
  set(CMAKE_INSTALL_SO_NO_EXE "1")
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/px_uav_msgs/msg" TYPE FILE FILES
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVState.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUAVState.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVCommand.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVControlState.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UAVSetup.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/TextInfo.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GlobalAruco.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVState.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/UGVCommand.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/MultiUGVState.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/PositionReference.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/StationCommand.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/SwarmCommand.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/FormationAssign.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/OffsetPose.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/GPSData.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNode2.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/LinktrackNodeframe2.msg"
    "/home/px/UAV_SDK/src/common/px_uav_msgs/msg/ParamSettings.msg"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/px_uav_msgs/cmake" TYPE FILE FILES "/home/px/UAV_SDK/build/common/px_uav_msgs/catkin_generated/installspace/px_uav_msgs-msg-paths.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/include" TYPE DIRECTORY FILES "/home/px/UAV_SDK/devel/include/px_uav_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/roseus/ros" TYPE DIRECTORY FILES "/home/px/UAV_SDK/devel/share/roseus/ros/px_uav_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/common-lisp/ros" TYPE DIRECTORY FILES "/home/px/UAV_SDK/devel/share/common-lisp/ros/px_uav_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/gennodejs/ros" TYPE DIRECTORY FILES "/home/px/UAV_SDK/devel/share/gennodejs/ros/px_uav_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  execute_process(COMMAND "/usr/bin/python3" -m compileall "/home/px/UAV_SDK/devel/lib/python3/dist-packages/px_uav_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/python3/dist-packages" TYPE DIRECTORY FILES "/home/px/UAV_SDK/devel/lib/python3/dist-packages/px_uav_msgs")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/lib/pkgconfig" TYPE FILE FILES "/home/px/UAV_SDK/build/common/px_uav_msgs/catkin_generated/installspace/px_uav_msgs.pc")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/px_uav_msgs/cmake" TYPE FILE FILES "/home/px/UAV_SDK/build/common/px_uav_msgs/catkin_generated/installspace/px_uav_msgs-msg-extras.cmake")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/px_uav_msgs/cmake" TYPE FILE FILES
    "/home/px/UAV_SDK/build/common/px_uav_msgs/catkin_generated/installspace/px_uav_msgsConfig.cmake"
    "/home/px/UAV_SDK/build/common/px_uav_msgs/catkin_generated/installspace/px_uav_msgsConfig-version.cmake"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/px_uav_msgs" TYPE FILE FILES "/home/px/UAV_SDK/src/common/px_uav_msgs/package.xml")
endif()

