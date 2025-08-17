# MAVROS实现PX4航线规划的流程梳理

## 流程图

```mermaid
graph TD
    Start[开始] --> Init[系统初始化与连接建立]
    
    subgraph 系统初始化与连接建立
        Init --> HW[硬件连接
'串口/UDP/TCP']
        Init --> MavrosStart[启动MAVROS节点
配置通信参数]
        Init --> StateCheck[监听/mavros/state
确认连接状态]
    end
    
    Init --> MissionMgmt[航线任务管理]
    
    subgraph 航线任务管理
        MissionMgmt --> Clear[清除现有任务
/mavros/mission/clear]
        Clear --> Define[定义航点列表
Waypoint消息构造]
        Define --> Push[推送航点到飞控
/mavros/mission/push]
        Push --> Verify[验证航点上传
/mavros/mission/pull]
    end
    
    MissionMgmt --> Execute[执行航线任务]
    
    subgraph 执行航线任务
        Execute --> SetMode[设置飞行模式
AUTO.MISSION]
        SetMode --> Arm[解锁电机
/mavros/cmd/arming]
        Arm --> Takeoff[起飞触发
自动/手动起飞]
    end
    
    Execute --> Monitor[任务监控与控制]
    
    subgraph 任务监控与控制
        Monitor --> CurrentWP[监听当前航点
/mavros/mission/current]
        Monitor --> ReachEvent[监听航点到达事件
/mavros/mission/waypoint_reached]
        Monitor --> Emergency[紧急中断
切换RTL/MANUAL模式]
    end
    
    Monitor --> Complete[任务完成]
    Complete --> Land[执行着陆
MAV_CMD_NAV_LAND]
    Land --> End[结束]

    classDef important fill:#f9f,stroke:#333,stroke-width:4px
    class Init,MissionMgmt,Execute important
```

## 流程说明

1. **系统初始化与连接建立**：通过硬件接口建立通信，启动MAVROS节点并验证连接状态
2. **航线任务管理**：清除历史任务，定义航点列表（包含坐标、高度、指令类型等），上传并验证航点
3. **执行航线任务**：切换至任务模式，解锁电机并触发起飞
4. **任务监控与控制**：实时跟踪航点执行进度，处理异常情况
5. **任务完成**：执行着陆流程，结束任务

> 关键接口：`/mavros/mission/*`服务（清除/推送/拉取航点）、`/mavros/set_mode`（模式切换）、`/mavros/cmd/arming`（电机解锁）