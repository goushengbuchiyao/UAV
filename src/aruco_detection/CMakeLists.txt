cmake_minimum_required(VERSION 3.0.2)
project(aruco_detection)

## Compile as C++11, supported in ROS Kinetic and newer
# add_compile_options(-std=c++11)
add_compile_options(-std=c++17)
## Find catkin macros and libraries
## if COMPONENTS list like find_package(catkin REQUIRED COMPONENTS xyz)
## is used, also find other catkin packages
find_package(catkin REQUIRED COMPONENTS
  roscpp
  sensor_msgs
  cv_bridge
  image_transport
  px_uav_msgs
  mavros_msgs
)
generate_messages(
  DEPENDENCIES
  std_msgs
  geometry_msgs
  px_uav_msgs
)
find_package(OpenCV REQUIRED)

find_package(Eigen3 REQUIRED)

catkin_package(
  CATKIN_DEPENDS roscpp sensor_msgs cv_bridge image_transport px_uav_msgs
)


include_directories(
  include
  ${catkin_INCLUDE_DIRS}
  ${OpenCV_INCLUDE_DIRS}
)

add_executable(aruco_detection_nested src/aruco_detection_nested.cpp)
add_dependencies(aruco_detection_nested ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(aruco_detection_nested
  ${catkin_LIBRARIES}
  ${OpenCV_LIBS}
  ${EIGEN3_INCLUDE_DIRS}
)

add_executable(aruco_detection_once src/aruco_detection_once.cpp)
add_dependencies(aruco_detection_once ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(aruco_detection_once
  ${catkin_LIBRARIES}
  ${OpenCV_LIBS}
  ${EIGEN3_INCLUDE_DIRS}
)

add_executable(aruco_landing_controller_once src/aruco_landing_controller_once.cpp)
add_dependencies(aruco_landing_controller_once ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(aruco_landing_controller_once
  ${catkin_LIBRARIES}
)

add_executable(aruco_landing_controller_nested src/aruco_landing_controller_nested.cpp)
add_dependencies(aruco_landing_controller_nested ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
target_link_libraries(aruco_landing_controller_nested
  ${catkin_LIBRARIES}
)
# add_executable(aruco_code_tracker src/aruco_land.cpp)
# add_dependencies(aruco_code_tracker ${${PROJECT_NAME}_EXPORTED_TARGETS} ${catkin_EXPORTED_TARGETS})
# target_link_libraries(aruco_code_tracker
#   ${catkin_LIBRARIES}
# )