#!/bin/bash

# 询问用户是否启动仿真环境
echo "欢迎使用PX4 HITL仿真环境启动脚本"
echo "是否启动仿真环境？(y/n)"
read -r choice

# 将输入转换为小写，以提高兼容性
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

# 判断用户的选择
if [[ "$choice" == "y" || "$choice" == "yes" ]]; then

# 启动roscore，在新终端中运行
echo "正在启动roscore..."
gnome-terminal --tab --title="roscore" -- bash -c "roscore; exec bash"

# 等待1秒，确保roscore有时间启动
sleep 1

# 启动hitl_uav.launch文件
echo "启动PX4 HITL仿真环境..."
gnome-terminal --tab --title="PX4 HITL" -- bash -c "roslaunch px4 hitl_uav.launch; exec bash"

# 启动QGroundControl
echo "启动QGroundControl地面站..."
gnome-terminal --tab --title="QGroundControl" -- bash -c "sleep 5; cd ~/QGC; ./QGroundControl.AppImage; exec bash"

# 确保脚本在出错时停止执行
source /opt/ros/noetic/setup.bash
# 加载工作空间的环境变量
source /home/px/UAV_SDK/devel/setup.bash

# 启动mqtt_bridge.launch文件，在新终端中运行
echo "正在启动mqtt_bridge..."
gnome-terminal --tab --title="MQTT Bridge" -- bash -c "roslaunch mqtt_bridge mqtt_bridge.launch; exec bash"

# 等待1秒，确保第一个节点有时间启动
sleep 1

# 启动uav_control.launch文件，在新终端中运行
echo "正在启动uav_control..."
gnome-terminal --tab --title="UAV Control" -- bash -c "roslaunch uav_control uav_control.launch; exec bash"

# 提示用户如何停止脚本
echo "所有节点已启动。如需停止，可关闭终端窗口或在本终端按Ctrl+C。"

read -r
elif [[ "$choice" == "n" || "$choice" == "no" ]]; then
    # 用户选择不启动仿真环境
echo "用户选择不启动仿真环境，继续启动其他节点..."
# 启动mqtt_bridge.launch文件，在新终端中运行
echo "正在启动roscore..."
gnome-terminal --tab --title="roscore" -- bash -c "roscore; exec bash"

# 等待1秒，确保roscore有时间启动
sleep 1

# 启动mqtt_bridge.launch文件，在新终端中运行
echo "正在启动mqtt_bridge..."
gnome-terminal --tab --title="MQTT Bridge" -- bash -c "roslaunch mqtt_bridge mqtt_bridge.launch; exec bash"

# 等待1秒，确保第一个节点有时间启动
sleep 1

# 启动uav_control.launch文件，在新终端中运行
echo "正在启动uav_control..."
gnome-terminal --tab --title="UAV Control" -- bash -c "roslaunch uav_control uav_control.launch; exec bash"

exit 0
else
    # 输入无效
echo "输入无效，请输入y或n。"
exit 1
fi