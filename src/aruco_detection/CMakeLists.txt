cmake_minimum_required(VERSION 3.0.2)
project(aruco_detection)

## Compile as C++11, supported in ROS Kinetic and newer
add_compile_options(-std=c++11)

## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  roscpp
  sensor_msgs
  cv_bridge
  image_transport
)

find_package(OpenCV REQUIRED)

find_package(Eigen3 REQUIRED)

catkin_package(
  CATKIN_DEPENDS roscpp sensor_msgs cv_bridge image_transport
)

include_directories(
  ${catkin_INCLUDE_DIRS}
  ${OpenCV_INCLUDE_DIRS}
)

add_executable(aruco_detection src/aruco_detection.cpp)
add_dependencies(aruco_detection ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(aruco_detection
  ${catkin_LIBRARIES}
  ${OpenCV_LIBS}
  ${EIGEN3_INCLUDE_DIRS}
)
