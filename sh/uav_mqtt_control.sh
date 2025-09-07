#!/bin/bash

# 检测系统中可用的终端模拟器
find_terminal() {
    # 按优先级顺序检查常用终端
    for terminal in gnome-terminal konsole xfce4-terminal lxterminal mate-terminal terminator xterm;
    do
        if command -v "$terminal" >/dev/null 2>&1;
        then
            echo "$terminal"
            return 0
        fi
    done
    return 1
}

# 获取可用的终端模拟器
TERMINAL=$(find_terminal)
  
# 检查是否找到可用的终端模拟器
if [ -z "$TERMINAL" ];
then
    echo "错误: 未找到可用的终端模拟器。请安装gnome-terminal、konsole、xfce4-terminal、lxterminal、mate-terminal、terminator或xterm。"
exit 1
fi

echo "检测到终端模拟器: $TERMINAL"

# 询问用户是否启动仿真环境
echo "欢迎使用PX4 HITL仿真环境启动脚本"
echo "是否启动仿真环境？(y/n)"
read -r choice

# 将输入转换为小写，以提高兼容性
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

# 根据终端类型设置创建新标签页的命令
case "$TERMINAL" in
    gnome-terminal)
        NEW_TAB="--tab --title="
        ;;    
    konsole)
        NEW_TAB="--new-tab --title "
        ;;    
    xfce4-terminal)
        NEW_TAB="--tab --title="
        ;;    
    lxterminal)
        NEW_TAB="--title="
        ;;    
    mate-terminal)
        NEW_TAB="--tab --title="
        ;;    
    terminator)
        NEW_TAB="--new-tab --title="
        ;;    
    xterm)
        # xterm不支持标签页，使用多个窗口
        NEW_TAB="-title "
        MULTI_WINDOW=true
        ;;    
    *)
        # 默认使用简单的终端启动方式
        NEW_TAB=""
        MULTI_WINDOW=true
        ;;
esac

# 根据用户选择执行不同的启动命令
if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
    # 启动roscore和其他节点
    echo "正在准备启动所有节点..."
    
    if [ "$MULTI_WINDOW" = true ]; then
        # 不支持标签页的终端，使用多个窗口
        echo "当前终端不支持标签页，将使用多个窗口启动..."
        
        # 启动roscore
        echo "正在启动roscore..."
        $TERMINAL $NEW_TAB"roscore" -e "roscore; exec bash" &
        sleep 1
        
        # 启动hitl_uav.launch
        echo "启动PX4 HITL仿真环境..."
        $TERMINAL $NEW_TAB"PX4 HITL" -e "source /opt/ros/noetic/setup.bash; source /home/px/UAV_SDK/devel/setup.bash; cd /home/px/PX4-Autopilot; roslaunch launch/hitl_uav.launch; exec bash" &
        
        # 启动QGroundControl
        echo "启动QGroundControl地面站..."
        $TERMINAL $NEW_TAB"QGroundControl" -e "sleep 5; cd ~/QGC; ./QGroundControl.AppImage; exec bash" &
        
        # 启动mqtt_bridge
        echo "正在启动mqtt_bridge..."
        $TERMINAL $NEW_TAB"MQTT Bridge" -e "source /opt/ros/noetic/setup.bash; source /home/px/UAV_SDK/devel/setup.bash; roslaunch mqtt_bridge mqtt_bridge.launch; exec bash" &
        
        # 启动uav_control
        echo "正在启动uav_control..."
        $TERMINAL $NEW_TAB"UAV Control" -e "source /opt/ros/noetic/setup.bash; source /home/px/UAV_SDK/devel/setup.bash; roslaunch uav_control uav_control.launch; exec bash" &
    else
        # 支持标签页的终端，在一个窗口中使用多个标签页
        echo "将在一个终端窗口的不同标签页中启动所有节点..."
        
        # 启动一个终端窗口，并在其中创建多个标签页
        case "$TERMINAL" in
            gnome-terminal | mate-terminal | terminator | xfce4-terminal)
                $TERMINAL \
                    $NEW_TAB"roscore" -e "roscore; exec bash" \
                    $NEW_TAB"PX4 HITL" -e "sleep 1; roslaunch px4 hitl_uav.launch; exec bash" \
                    $NEW_TAB"QGroundControl" -e "sleep 6; cd ~/QGC; ./QGroundControl.AppImage; exec bash" \
                    $NEW_TAB"MQTT Bridge" -e "sleep 2;  source /home/px/UAV_SDK/devel/setup.bash; roslaunch mqtt_bridge mqtt_bridge.launch; exec bash" \
                    $NEW_TAB"UAV Control" -e "sleep 3;  source /home/px/UAV_SDK/devel/setup.bash; roslaunch uav_control uav_control.launch; exec bash" &
                ;;
                
            konsole)
                $TERMINAL \
                    $NEW_TAB"roscore" -e "roscore; exec bash" \
                    $NEW_TAB"PX4 HITL" -e "sleep 1; roslaunch px4 hitl_uav.launch; exec bash" \
                    $NEW_TAB"QGroundControl" -e "sleep 6; cd ~/QGC; ./QGroundControl.AppImage; exec bash" \
                    $NEW_TAB"MQTT Bridge" -e "sleep 2;  source /home/px/UAV_SDK/devel/setup.bash; roslaunch mqtt_bridge mqtt_bridge.launch; exec bash" \
                    $NEW_TAB"UAV Control" -e "sleep 3;  source /home/px/UAV_SDK/devel/setup.bash; roslaunch uav_control uav_control.launch; exec bash" &
                ;;
        esac
    fi

    # 提示用户如何停止脚本
    echo "所有节点已启动。如需停止，可关闭终端窗口或在本终端按Ctrl+C。"
    read -r
    
elif [[ "$choice" == "n" || "$choice" == "no" ]]; then
    # 用户选择不启动仿真环境，只启动mqtt_bridge和uav_control
    echo "用户选择不启动仿真环境，只启动其他节点..."
    
    if [ "$MULTI_WINDOW" = true ]; then
        # 不支持标签页的终端，使用多个窗口
        echo "当前终端不支持标签页，将使用多个窗口启动..."
        
        # 启动roscore
        echo "正在启动roscore..."
        $TERMINAL $NEW_TAB"roscore" -e "roscore; exec bash" &
        sleep 1
        
        # 启动mqtt_bridge
        echo "正在启动mqtt_bridge..."
        $TERMINAL $NEW_TAB"MQTT Bridge" -e "source /opt/ros/noetic/setup.bash; source /home/px/UAV_SDK/devel/setup.bash; roslaunch mqtt_bridge mqtt_bridge.launch; exec bash" &
        
        # 启动uav_control
        echo "正在启动uav_control..."
        $TERMINAL $NEW_TAB"UAV Control" -e "source /opt/ros/noetic/setup.bash; source /home/px/UAV_SDK/devel/setup.bash; roslaunch uav_control uav_control.launch; exec bash" &
    else
        # 支持标签页的终端，在一个窗口中使用多个标签页
        echo "将在一个终端窗口的不同标签页中启动节点..."
        
        case "$TERMINAL" in
            gnome-terminal | mate-terminal | terminator | xfce4-terminal)
                $TERMINAL \
                    $NEW_TAB"roscore" -e "roscore; exec bash" \
                    $NEW_TAB"MQTT Bridge" -e "sleep 1; source /opt/ros/noetic/setup.bash; source /home/px/UAV_SDK/devel/setup.bash; roslaunch mqtt_bridge mqtt_bridge.launch; exec bash" \
                    $NEW_TAB"UAV Control" -e "sleep 2; source /opt/ros/noetic/setup.bash; source /home/px/UAV_SDK/devel/setup.bash; roslaunch uav_control uav_control.launch; exec bash" &
                ;;
                
            konsole)
                $TERMINAL \
                    $NEW_TAB"roscore" -e "roscore; exec bash" \
                    $NEW_TAB"MQTT Bridge" -e "sleep 1; source /opt/ros/noetic/setup.bash; source /home/px/UAV_SDK/devel/setup.bash; roslaunch mqtt_bridge mqtt_bridge.launch; exec bash" \
                    $NEW_TAB"UAV Control" -e "sleep 2; source /opt/ros/noetic/setup.bash; source /home/px/UAV_SDK/devel/setup.bash; roslaunch uav_control uav_control.launch; exec bash" &
                ;;
        esac
    fi
    
    echo "节点已启动。如需停止，可关闭终端窗口或在本终端按Ctrl+C。"
    read -r
    exit 0
else
    # 输入无效
    echo "输入无效，请输入y或n。"
    exit 1
fi