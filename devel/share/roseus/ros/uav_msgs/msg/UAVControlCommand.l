;; Auto-generated. Do not edit!


(when (boundp 'uav_msgs::UAVControlCommand)
  (if (not (find-package "UAV_MSGS"))
    (make-package "UAV_MSGS"))
  (shadow 'UAVControlCommand (find-package "UAV_MSGS")))
(unless (find-package "UAV_MSGS::UAVCONTROLCOMMAND")
  (make-package "UAV_MSGS::UAVCONTROLCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude UAVControlCommand.msg.html


(defclass uav_msgs::UAVControlCommand
  :super ros::object
  :slots (_command_type _timestamp _target_system _takeoff _land _pos_ned _pos_global _vel_ned _rtl _hover _set_mode _waypoints_cmd ))

(defmethod uav_msgs::UAVControlCommand
  (:init
   (&key
    ((:command_type __command_type) "")
    ((:timestamp __timestamp) (instance ros::time :init))
    ((:target_system __target_system) 0)
    ((:takeoff __takeoff) (instance uav_msgs::TakeoffCommand :init))
    ((:land __land) (instance uav_msgs::LandCommand :init))
    ((:pos_ned __pos_ned) (instance uav_msgs::PositionControlNEDCommand :init))
    ((:pos_global __pos_global) (instance uav_msgs::PositionControlGlobalCommand :init))
    ((:vel_ned __vel_ned) (instance uav_msgs::VelocityControlNEDCommand :init))
    ((:rtl __rtl) (instance uav_msgs::ReturnToLaunchCommand :init))
    ((:hover __hover) (instance uav_msgs::HoverCommand :init))
    ((:set_mode __set_mode) (instance uav_msgs::SetModeCommand :init))
    ((:waypoints_cmd __waypoints_cmd) (instance uav_msgs::WaypointsCommand :init))
    )
   (send-super :init)
   (setq _command_type (string __command_type))
   (setq _timestamp __timestamp)
   (setq _target_system (round __target_system))
   (setq _takeoff __takeoff)
   (setq _land __land)
   (setq _pos_ned __pos_ned)
   (setq _pos_global __pos_global)
   (setq _vel_ned __vel_ned)
   (setq _rtl __rtl)
   (setq _hover __hover)
   (setq _set_mode __set_mode)
   (setq _waypoints_cmd __waypoints_cmd)
   self)
  (:command_type
   (&optional __command_type)
   (if __command_type (setq _command_type __command_type)) _command_type)
  (:timestamp
   (&optional __timestamp)
   (if __timestamp (setq _timestamp __timestamp)) _timestamp)
  (:target_system
   (&optional __target_system)
   (if __target_system (setq _target_system __target_system)) _target_system)
  (:takeoff
   (&rest __takeoff)
   (if (keywordp (car __takeoff))
       (send* _takeoff __takeoff)
     (progn
       (if __takeoff (setq _takeoff (car __takeoff)))
       _takeoff)))
  (:land
   (&rest __land)
   (if (keywordp (car __land))
       (send* _land __land)
     (progn
       (if __land (setq _land (car __land)))
       _land)))
  (:pos_ned
   (&rest __pos_ned)
   (if (keywordp (car __pos_ned))
       (send* _pos_ned __pos_ned)
     (progn
       (if __pos_ned (setq _pos_ned (car __pos_ned)))
       _pos_ned)))
  (:pos_global
   (&rest __pos_global)
   (if (keywordp (car __pos_global))
       (send* _pos_global __pos_global)
     (progn
       (if __pos_global (setq _pos_global (car __pos_global)))
       _pos_global)))
  (:vel_ned
   (&rest __vel_ned)
   (if (keywordp (car __vel_ned))
       (send* _vel_ned __vel_ned)
     (progn
       (if __vel_ned (setq _vel_ned (car __vel_ned)))
       _vel_ned)))
  (:rtl
   (&rest __rtl)
   (if (keywordp (car __rtl))
       (send* _rtl __rtl)
     (progn
       (if __rtl (setq _rtl (car __rtl)))
       _rtl)))
  (:hover
   (&rest __hover)
   (if (keywordp (car __hover))
       (send* _hover __hover)
     (progn
       (if __hover (setq _hover (car __hover)))
       _hover)))
  (:set_mode
   (&rest __set_mode)
   (if (keywordp (car __set_mode))
       (send* _set_mode __set_mode)
     (progn
       (if __set_mode (setq _set_mode (car __set_mode)))
       _set_mode)))
  (:waypoints_cmd
   (&rest __waypoints_cmd)
   (if (keywordp (car __waypoints_cmd))
       (send* _waypoints_cmd __waypoints_cmd)
     (progn
       (if __waypoints_cmd (setq _waypoints_cmd (car __waypoints_cmd)))
       _waypoints_cmd)))
  (:serialization-length
   ()
   (+
    ;; string _command_type
    4 (length _command_type)
    ;; time _timestamp
    8
    ;; int32 _target_system
    4
    ;; uav_msgs/TakeoffCommand _takeoff
    (send _takeoff :serialization-length)
    ;; uav_msgs/LandCommand _land
    (send _land :serialization-length)
    ;; uav_msgs/PositionControlNEDCommand _pos_ned
    (send _pos_ned :serialization-length)
    ;; uav_msgs/PositionControlGlobalCommand _pos_global
    (send _pos_global :serialization-length)
    ;; uav_msgs/VelocityControlNEDCommand _vel_ned
    (send _vel_ned :serialization-length)
    ;; uav_msgs/ReturnToLaunchCommand _rtl
    (send _rtl :serialization-length)
    ;; uav_msgs/HoverCommand _hover
    (send _hover :serialization-length)
    ;; uav_msgs/SetModeCommand _set_mode
    (send _set_mode :serialization-length)
    ;; uav_msgs/WaypointsCommand _waypoints_cmd
    (send _waypoints_cmd :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _command_type
       (write-long (length _command_type) s) (princ _command_type s)
     ;; time _timestamp
       (write-long (send _timestamp :sec) s) (write-long (send _timestamp :nsec) s)
     ;; int32 _target_system
       (write-long _target_system s)
     ;; uav_msgs/TakeoffCommand _takeoff
       (send _takeoff :serialize s)
     ;; uav_msgs/LandCommand _land
       (send _land :serialize s)
     ;; uav_msgs/PositionControlNEDCommand _pos_ned
       (send _pos_ned :serialize s)
     ;; uav_msgs/PositionControlGlobalCommand _pos_global
       (send _pos_global :serialize s)
     ;; uav_msgs/VelocityControlNEDCommand _vel_ned
       (send _vel_ned :serialize s)
     ;; uav_msgs/ReturnToLaunchCommand _rtl
       (send _rtl :serialize s)
     ;; uav_msgs/HoverCommand _hover
       (send _hover :serialize s)
     ;; uav_msgs/SetModeCommand _set_mode
       (send _set_mode :serialize s)
     ;; uav_msgs/WaypointsCommand _waypoints_cmd
       (send _waypoints_cmd :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _command_type
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _command_type (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; time _timestamp
     (send _timestamp :sec (sys::peek buf ptr- :integer)) (incf ptr- 4)  (send _timestamp :nsec (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _target_system
     (setq _target_system (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; uav_msgs/TakeoffCommand _takeoff
     (send _takeoff :deserialize buf ptr-) (incf ptr- (send _takeoff :serialization-length))
   ;; uav_msgs/LandCommand _land
     (send _land :deserialize buf ptr-) (incf ptr- (send _land :serialization-length))
   ;; uav_msgs/PositionControlNEDCommand _pos_ned
     (send _pos_ned :deserialize buf ptr-) (incf ptr- (send _pos_ned :serialization-length))
   ;; uav_msgs/PositionControlGlobalCommand _pos_global
     (send _pos_global :deserialize buf ptr-) (incf ptr- (send _pos_global :serialization-length))
   ;; uav_msgs/VelocityControlNEDCommand _vel_ned
     (send _vel_ned :deserialize buf ptr-) (incf ptr- (send _vel_ned :serialization-length))
   ;; uav_msgs/ReturnToLaunchCommand _rtl
     (send _rtl :deserialize buf ptr-) (incf ptr- (send _rtl :serialization-length))
   ;; uav_msgs/HoverCommand _hover
     (send _hover :deserialize buf ptr-) (incf ptr- (send _hover :serialization-length))
   ;; uav_msgs/SetModeCommand _set_mode
     (send _set_mode :deserialize buf ptr-) (incf ptr- (send _set_mode :serialization-length))
   ;; uav_msgs/WaypointsCommand _waypoints_cmd
     (send _waypoints_cmd :deserialize buf ptr-) (incf ptr- (send _waypoints_cmd :serialization-length))
   ;;
   self)
  )

(setf (get uav_msgs::UAVControlCommand :md5sum-) "53572dae1fc3b49d99d763590ada7f7d")
(setf (get uav_msgs::UAVControlCommand :datatype-) "uav_msgs/UAVControlCommand")
(setf (get uav_msgs::UAVControlCommand :definition-)
      "
string command_type
time timestamp
int32 target_system

TakeoffCommand takeoff
LandCommand land
PositionControlNEDCommand pos_ned
PositionControlGlobalCommand pos_global
VelocityControlNEDCommand vel_ned
ReturnToLaunchCommand rtl
HoverCommand hover
SetModeCommand set_mode
WaypointsCommand waypoints_cmd

================================================================================
MSG: uav_msgs/TakeoffCommand
float64 altitude
float64 yaw

================================================================================
MSG: uav_msgs/LandCommand
float64 yaw

================================================================================
MSG: uav_msgs/PositionControlNEDCommand
float64 x
float64 y
float64 z
float64 yaw

================================================================================
MSG: uav_msgs/PositionControlGlobalCommand
float64 latitude
float64 longitude
float64 altitude
float64 yaw

================================================================================
MSG: uav_msgs/VelocityControlNEDCommand
float64 vx
float64 vy
float64 vz
float64 yaw_rate

================================================================================
MSG: uav_msgs/ReturnToLaunchCommand
float64 altitude

================================================================================
MSG: uav_msgs/HoverCommand
string mode
================================================================================
MSG: uav_msgs/SetModeCommand
string mode

================================================================================
MSG: uav_msgs/WaypointsCommand
bool start_immediately     # 是否立即执行航点
Waypoint[] waypoints       # 航点列表
================================================================================
MSG: uav_msgs/Waypoint
int32 waypoint_id          # 航点ID
string frame               # 坐标系类型
string command             # 航点指令类型
float64 latitude           # 纬度 (度)
float64 longitude          # 经度 (度)
float64 altitude           # 高度 (米)
bool is_current            # 是否为当前航点
bool autocontinue          # 是否自动继续到下一个航点
float64 hold_time          # 悬停时间 (秒)
")



(provide :uav_msgs/UAVControlCommand "53572dae1fc3b49d99d763590ada7f7d")


