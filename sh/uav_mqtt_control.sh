#!/bin/bash

# 检测系统中可用的终端模拟器
detect_terminal() {
    # 按优先级顺序检查常用终端
    for terminal in gnome-terminal konsole xfce4-terminal mate-terminal terminator lxterminal xterm;
    do
        if command -v "$terminal" >/dev/null 2>&1;
        then
            echo "$terminal"
            return 0
        fi
    done
    return 1
}

# 为不同类型的终端创建新标签页或窗口
# 参数: $1=标题 $2=命令 $3=是否在新窗口中打开
create_terminal_session() {
    local title="$1"
    local command="$2"
    local new_window="$3"
    local full_command
    
    case "$TERMINAL" in
        gnome-terminal)
            if [ "$new_window" = true ]; then
                full_command="$TERMINAL --window --title='$title' -e 'bash -c \"$command; exec bash\"'"
            else
                full_command="$TERMINAL --tab --title='$title' -e 'bash -c \"$command; exec bash\"'"
            fi
            ;;
        
        konsole)
            if [ "$new_window" = true ]; then
                full_command="$TERMINAL --new-window --title '$title' -e 'bash -c \"$command; exec bash\"'"
            else
                full_command="$TERMINAL --new-tab --title '$title' -e 'bash -c \"$command; exec bash\"'"
            fi
            ;;
        
        xfce4-terminal)
            if [ "$new_window" = true ]; then
                full_command="$TERMINAL --title='$title' -x bash -c '$command; exec bash'"
            else
                full_command="$TERMINAL --tab --title='$title' -x bash -c '$command; exec bash'"
            fi
            ;;
        
        mate-terminal)
            if [ "$new_window" = true ]; then
                full_command="$TERMINAL --window --title='$title' -e 'bash -c \"$command; exec bash\"'"
            else
                full_command="$TERMINAL --tab --title='$title' -e 'bash -c \"$command; exec bash\"'"
            fi
            ;;
        
        terminator)
            if [ "$new_window" = true ]; then
                full_command="$TERMINAL --new-window --title='$title' -e 'bash -c \"$command; exec bash\"'"
            else
                full_command="$TERMINAL --new-tab --title='$title' -e 'bash -c \"$command; exec bash\"'"
            fi
            ;;
        
        lxterminal)
            # lxterminal不支持标签页，总是使用新窗口
            full_command="$TERMINAL --title='$title' -e 'bash -c \"$command; exec bash\"'"
            ;;
        
        xterm)
            # xterm不支持标签页，总是使用新窗口
            full_command="$TERMINAL -title '$title' -e 'bash -c \"$command; exec bash\"'"
            ;;
        
        *)
            # 默认使用简单的终端启动方式，假设支持-e参数
            full_command="$TERMINAL -e 'bash -c \"$command; exec bash\"'"
            ;;
    esac
    
    echo "执行命令: $full_command"
    eval "$full_command" &
}

# 支持标签页的终端列表
supports_tabs() {
    case "$TERMINAL" in
        gnome-terminal|konsole|xfce4-terminal|mate-terminal|terminator)
            return 0
            ;;
        *)
            return 1
            ;;
    esac
}

# 在单个窗口中使用多个标签页启动所有节点（仅支持标签页的终端）
start_with_tabs() {
    local roscore_cmd="sleep 1; source ~/.bashrc; roscore"
    local mqtt_cmd="sleep 2; source ~/.bashrc; source /home/px/UAV_SDK/devel/setup.bash; roslaunch mqtt_bridge mqtt_bridge.launch"
    local uav_cmd="sleep 3; source ~/.bashrc; source /home/px/UAV_SDK/devel/setup.bash; roslaunch uav_control uav_control.launch"
    
    case "$1" in
        "with_simulation")
            local px4_cmd="sleep 1; source ~/.bashrc; roslaunch px4 hitl_uav.launch"
            local qgc_cmd="sleep 6; cd ~/QGC; ./QGroundControl.AppImage"
            
            # 使用create_terminal_session函数统一处理不同终端类型
            create_terminal_session "roscore" "$roscore_cmd" false
            sleep 1
            create_terminal_session "PX4 HITL" "$px4_cmd" false
            sleep 1
            create_terminal_session "QGroundControl" "$qgc_cmd" false
            sleep 1
            create_terminal_session "MQTT Bridge" "$mqtt_cmd" false
            sleep 1
            create_terminal_session "UAV Control" "$uav_cmd" false
            ;;
            
        "without_simulation")
            # 使用create_terminal_session函数统一处理不同终端类型
            create_terminal_session "roscore" "$roscore_cmd" false
            sleep 1
            create_terminal_session "MQTT Bridge" "$mqtt_cmd" false
            sleep 1
            create_terminal_session "UAV Control" "$uav_cmd" false
            ;;
    esac
}

# 主程序开始
# 获取可用的终端模拟器
TERMINAL=$(detect_terminal)
  
# 检查是否找到可用的终端模拟器
if [ -z "$TERMINAL" ];
then
    echo "错误: 未找到可用的终端模拟器。请安装gnome-terminal、konsole、xfce4-terminal、mate-terminal、terminator、lxterminal或xterm。"
exit 1
fi

echo "检测到终端模拟器: $TERMINAL"

# 询问用户是否启动仿真环境
echo "欢迎使用PX4 HITL仿真环境启动脚本"
echo "是否启动仿真环境？(y/n)"
read -r choice

# 将输入转换为小写，以提高兼容性
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

# 检查ROS环境
echo "正在检查ROS环境..."
if ! command -v roscore >/dev/null 2>&1;
then
    echo "警告: 未找到roscore命令，请确保ROS环境已正确安装并配置。"
    echo "尝试加载ROS环境..."
    source /opt/ros/noetic/setup.bash 2>/dev/null || echo "无法自动加载ROS环境。"
fi

# 根据用户选择执行不同的启动命令
if [[ "$choice" == "y" || "$choice" == "yes" ]]; then
    # 启动roscore和其他节点（包括仿真）
    echo "正在准备启动所有节点（包括仿真环境）..."
    
    # 检查终端是否支持标签页
    if supports_tabs; then
        echo "当前终端支持标签页，将在一个窗口中使用多个标签页启动..."
        start_with_tabs "with_simulation"
    else
        echo "当前终端不支持标签页，将使用多个窗口启动..."
        
        create_terminal_session "roscore" "sleep 1; source ~/.bashrc; roscore" true
        sleep 1
        
        create_terminal_session "PX4 HITL" "sleep 1; source ~/.bashrc; roslaunch px4 hitl_uav.launch" true
        
        create_terminal_session "QGroundControl" "sleep 5; cd ~/QGC; ./QGroundControl.AppImage" true
        
        create_terminal_session "MQTT Bridge" "source ~/.bashrc; source /home/px/UAV_SDK/devel/setup.bash; roslaunch mqtt_bridge mqtt_bridge.launch" true
        
        create_terminal_session "UAV Control" "source ~/.bashrc; source /home/px/UAV_SDK/devel/setup.bash; roslaunch uav_control uav_control.launch" true
    fi

    # 提示用户如何停止脚本
echo "所有节点已启动。如需停止，可关闭终端窗口或在本终端按Ctrl+C。"
read -r
    
elif [[ "$choice" == "n" || "$choice" == "no" ]]; then
    # 用户选择不启动仿真环境，只启动mqtt_bridge和uav_control
    echo "用户选择不启动仿真环境，只启动其他节点..."
    
    # 检查终端是否支持标签页
    if supports_tabs; then
        echo "当前终端支持标签页，将在一个窗口中使用多个标签页启动..."
        start_with_tabs "without_simulation"
    else
        echo "当前终端不支持标签页，将使用多个窗口启动..."
        
        create_terminal_session "roscore" "source ~/.bashrc; roscore" true
        sleep 1
        
        create_terminal_session "MQTT Bridge" "source ~/.bashrc; source /home/px/UAV_SDK/devel/setup.bash; roslaunch mqtt_bridge mqtt_bridge.launch" true
        
        create_terminal_session "UAV Control" "source ~/.bashrc; source /home/px/UAV_SDK/devel/setup.bash; roslaunch uav_control uav_control.launch" true
    fi
    
    echo "节点已启动。如需停止，可关闭终端窗口。"
    read -r
    exit 0
else
    # 输入无效
    echo "输入无效，请输入y或n。"
exit 1
fi