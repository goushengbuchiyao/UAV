#!/bin/bash

# 启动roscore，在新终端中运行
echo "正在启动roscore..."
gnome-terminal --tab --title="roscore" -- bash -c "roscore; exec bash"

# 启动hitl_uav.launch文件
echo "启动PX4 HITL仿真环境..."
gnome-terminal --tab --title="PX4 HITL" -- bash -c "source /opt/ros/noetic/setup.bash; source /home/px/UAV_SDK/devel/setup.bash; cd /home/px/PX4-Autopilot; roslaunch launch/hitl_uav.launch; exec bash"

# 启动QGroundControl
echo "启动QGroundControl地面站..."
gnome-terminal --tab --title="QGroundControl" -- bash -c "sleep 5; cd ~/QGC; ./QGroundControl.AppImage; exec bash"

# 等待用户输入后退出
echo "仿真环境已启动。按Enter键退出脚本..."
read -r