;; Auto-generated. Do not edit!


(when (boundp 'px_uav_msgs::UAVCommand)
  (if (not (find-package "PX_UAV_MSGS"))
    (make-package "PX_UAV_MSGS"))
  (shadow 'UAVCommand (find-package "PX_UAV_MSGS")))
(unless (find-package "PX_UAV_MSGS::UAVCOMMAND")
  (make-package "PX_UAV_MSGS::UAVCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude UAVCommand.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*INIT_POS_HOVER*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*INIT_POS_HOVER* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*INIT_POS_HOVER* 1)
(intern "*CURRENT_POS_HOVER*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*CURRENT_POS_HOVER* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*CURRENT_POS_HOVER* 2)
(intern "*LAND*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*LAND* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*LAND* 3)
(intern "*MOVE*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*MOVE* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*MOVE* 4)
(intern "*USER_MODE*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*USER_MODE* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*USER_MODE* 5)
(intern "*DEFAULT_CONTROL*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*DEFAULT_CONTROL* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*DEFAULT_CONTROL* 0)
(intern "*ABSOLUTE_CONTROL*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*ABSOLUTE_CONTROL* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*ABSOLUTE_CONTROL* 1)
(intern "*EXIT_ABSOLUTE_CONTROL*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*EXIT_ABSOLUTE_CONTROL* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*EXIT_ABSOLUTE_CONTROL* 2)
(intern "*XYZ_POS*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*XYZ_POS* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*XYZ_POS* 0)
(intern "*XY_VEL_Z_POS*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*XY_VEL_Z_POS* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*XY_VEL_Z_POS* 1)
(intern "*XYZ_VEL*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*XYZ_VEL* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*XYZ_VEL* 2)
(intern "*XYZ_POS_BODY*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*XYZ_POS_BODY* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*XYZ_POS_BODY* 3)
(intern "*XYZ_VEL_BODY*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*XYZ_VEL_BODY* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*XYZ_VEL_BODY* 4)
(intern "*XY_VEL_Z_POS_BODY*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*XY_VEL_Z_POS_BODY* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*XY_VEL_Z_POS_BODY* 5)
(intern "*TRAJECTORY*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*TRAJECTORY* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*TRAJECTORY* 6)
(intern "*XYZ_ATT*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*XYZ_ATT* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*XYZ_ATT* 7)
(intern "*LAT_LON_ALT*" (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(shadow '*LAT_LON_ALT* (find-package "PX_UAV_MSGS::UAVCOMMAND"))
(defconstant px_uav_msgs::UAVCommand::*LAT_LON_ALT* 8)

(defun px_uav_msgs::UAVCommand-to-symbol (const)
  (cond
        ((= const 1) 'px_uav_msgs::UAVCommand::*Init_Pos_Hover*)
        ((= const 2) 'px_uav_msgs::UAVCommand::*Current_Pos_Hover*)
        ((= const 3) 'px_uav_msgs::UAVCommand::*Land*)
        ((= const 4) 'px_uav_msgs::UAVCommand::*Move*)
        ((= const 5) 'px_uav_msgs::UAVCommand::*User_Mode*)
        ((= const 0) 'px_uav_msgs::UAVCommand::*DEFAULT_CONTROL*)
        ((= const 1) 'px_uav_msgs::UAVCommand::*ABSOLUTE_CONTROL*)
        ((= const 2) 'px_uav_msgs::UAVCommand::*EXIT_ABSOLUTE_CONTROL*)
        ((= const 0) 'px_uav_msgs::UAVCommand::*XYZ_POS*)
        ((= const 1) 'px_uav_msgs::UAVCommand::*XY_VEL_Z_POS*)
        ((= const 2) 'px_uav_msgs::UAVCommand::*XYZ_VEL*)
        ((= const 3) 'px_uav_msgs::UAVCommand::*XYZ_POS_BODY*)
        ((= const 4) 'px_uav_msgs::UAVCommand::*XYZ_VEL_BODY*)
        ((= const 5) 'px_uav_msgs::UAVCommand::*XY_VEL_Z_POS_BODY*)
        ((= const 6) 'px_uav_msgs::UAVCommand::*TRAJECTORY*)
        ((= const 7) 'px_uav_msgs::UAVCommand::*XYZ_ATT*)
        ((= const 8) 'px_uav_msgs::UAVCommand::*LAT_LON_ALT*)
        (t nil)))

(defclass px_uav_msgs::UAVCommand
  :super ros::object
  :slots (_header _Agent_CMD _Control_Level _Move_mode _position_ref _velocity_ref _acceleration_ref _yaw_ref _Yaw_Rate_Mode _yaw_rate_ref _att_ref _latitude _longitude _altitude _Command_ID ))

(defmethod px_uav_msgs::UAVCommand
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:Agent_CMD __Agent_CMD) 0)
    ((:Control_Level __Control_Level) 0)
    ((:Move_mode __Move_mode) 0)
    ((:position_ref __position_ref) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:velocity_ref __velocity_ref) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:acceleration_ref __acceleration_ref) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:yaw_ref __yaw_ref) 0.0)
    ((:Yaw_Rate_Mode __Yaw_Rate_Mode) nil)
    ((:yaw_rate_ref __yaw_rate_ref) 0.0)
    ((:att_ref __att_ref) (make-array 4 :initial-element 0.0 :element-type :float))
    ((:latitude __latitude) 0.0)
    ((:longitude __longitude) 0.0)
    ((:altitude __altitude) 0.0)
    ((:Command_ID __Command_ID) 0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _Agent_CMD (round __Agent_CMD))
   (setq _Control_Level (round __Control_Level))
   (setq _Move_mode (round __Move_mode))
   (setq _position_ref __position_ref)
   (setq _velocity_ref __velocity_ref)
   (setq _acceleration_ref __acceleration_ref)
   (setq _yaw_ref (float __yaw_ref))
   (setq _Yaw_Rate_Mode __Yaw_Rate_Mode)
   (setq _yaw_rate_ref (float __yaw_rate_ref))
   (setq _att_ref __att_ref)
   (setq _latitude (float __latitude))
   (setq _longitude (float __longitude))
   (setq _altitude (float __altitude))
   (setq _Command_ID (round __Command_ID))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:Agent_CMD
   (&optional __Agent_CMD)
   (if __Agent_CMD (setq _Agent_CMD __Agent_CMD)) _Agent_CMD)
  (:Control_Level
   (&optional __Control_Level)
   (if __Control_Level (setq _Control_Level __Control_Level)) _Control_Level)
  (:Move_mode
   (&optional __Move_mode)
   (if __Move_mode (setq _Move_mode __Move_mode)) _Move_mode)
  (:position_ref
   (&optional __position_ref)
   (if __position_ref (setq _position_ref __position_ref)) _position_ref)
  (:velocity_ref
   (&optional __velocity_ref)
   (if __velocity_ref (setq _velocity_ref __velocity_ref)) _velocity_ref)
  (:acceleration_ref
   (&optional __acceleration_ref)
   (if __acceleration_ref (setq _acceleration_ref __acceleration_ref)) _acceleration_ref)
  (:yaw_ref
   (&optional __yaw_ref)
   (if __yaw_ref (setq _yaw_ref __yaw_ref)) _yaw_ref)
  (:Yaw_Rate_Mode
   (&optional (__Yaw_Rate_Mode :null))
   (if (not (eq __Yaw_Rate_Mode :null)) (setq _Yaw_Rate_Mode __Yaw_Rate_Mode)) _Yaw_Rate_Mode)
  (:yaw_rate_ref
   (&optional __yaw_rate_ref)
   (if __yaw_rate_ref (setq _yaw_rate_ref __yaw_rate_ref)) _yaw_rate_ref)
  (:att_ref
   (&optional __att_ref)
   (if __att_ref (setq _att_ref __att_ref)) _att_ref)
  (:latitude
   (&optional __latitude)
   (if __latitude (setq _latitude __latitude)) _latitude)
  (:longitude
   (&optional __longitude)
   (if __longitude (setq _longitude __longitude)) _longitude)
  (:altitude
   (&optional __altitude)
   (if __altitude (setq _altitude __altitude)) _altitude)
  (:Command_ID
   (&optional __Command_ID)
   (if __Command_ID (setq _Command_ID __Command_ID)) _Command_ID)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _Agent_CMD
    1
    ;; uint8 _Control_Level
    1
    ;; uint8 _Move_mode
    1
    ;; float32[3] _position_ref
    (* 4    3)
    ;; float32[3] _velocity_ref
    (* 4    3)
    ;; float32[3] _acceleration_ref
    (* 4    3)
    ;; float32 _yaw_ref
    4
    ;; bool _Yaw_Rate_Mode
    1
    ;; float32 _yaw_rate_ref
    4
    ;; float32[4] _att_ref
    (* 4    4)
    ;; float64 _latitude
    8
    ;; float64 _longitude
    8
    ;; float64 _altitude
    8
    ;; uint32 _Command_ID
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _Agent_CMD
       (write-byte _Agent_CMD s)
     ;; uint8 _Control_Level
       (write-byte _Control_Level s)
     ;; uint8 _Move_mode
       (write-byte _Move_mode s)
     ;; float32[3] _position_ref
     (dotimes (i 3)
       (sys::poke (elt _position_ref i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[3] _velocity_ref
     (dotimes (i 3)
       (sys::poke (elt _velocity_ref i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[3] _acceleration_ref
     (dotimes (i 3)
       (sys::poke (elt _acceleration_ref i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _yaw_ref
       (sys::poke _yaw_ref (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _Yaw_Rate_Mode
       (if _Yaw_Rate_Mode (write-byte -1 s) (write-byte 0 s))
     ;; float32 _yaw_rate_ref
       (sys::poke _yaw_rate_ref (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[4] _att_ref
     (dotimes (i 4)
       (sys::poke (elt _att_ref i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float64 _latitude
       (sys::poke _latitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _longitude
       (sys::poke _longitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _altitude
       (sys::poke _altitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; uint32 _Command_ID
       (write-long _Command_ID s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _Agent_CMD
     (setq _Agent_CMD (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _Control_Level
     (setq _Control_Level (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _Move_mode
     (setq _Move_mode (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32[3] _position_ref
   (dotimes (i (length _position_ref))
     (setf (elt _position_ref i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[3] _velocity_ref
   (dotimes (i (length _velocity_ref))
     (setf (elt _velocity_ref i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[3] _acceleration_ref
   (dotimes (i (length _acceleration_ref))
     (setf (elt _acceleration_ref i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32 _yaw_ref
     (setq _yaw_ref (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _Yaw_Rate_Mode
     (setq _Yaw_Rate_Mode (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _yaw_rate_ref
     (setq _yaw_rate_ref (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[4] _att_ref
   (dotimes (i (length _att_ref))
     (setf (elt _att_ref i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float64 _latitude
     (setq _latitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _longitude
     (setq _longitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _altitude
     (setq _altitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; uint32 _Command_ID
     (setq _Command_ID (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get px_uav_msgs::UAVCommand :md5sum-) "8e2d468617a903de8fb514f495325390")
(setf (get px_uav_msgs::UAVCommand :datatype-) "px_uav_msgs/UAVCommand")
(setf (get px_uav_msgs::UAVCommand :definition-)
      "std_msgs/Header header

## 控制命令的模式 
uint8 Agent_CMD
# Agent_CMD 枚举
uint8 Init_Pos_Hover=1  # home点上方悬停
uint8 Current_Pos_Hover=2 # 当前位置上方悬停
uint8 Land=3
uint8 Move=4
uint8 User_Mode=5

## 控制等级 
uint8 Control_Level
# Control_Level 枚举
uint8 DEFAULT_CONTROL=0        ### 默认控制
uint8 ABSOLUTE_CONTROL=1       ### 绝对控制，在该控制等级下不在响应 默认控制 下任何指令，持续的Move模式应谨慎使用该优先级
uint8 EXIT_ABSOLUTE_CONTROL=2  ### 退出绝对控制控制，在该控制下，会响应上述两种控制的指令

## 移动命令下的子模式
uint8 Move_mode
## 移动命令下的子模式枚举
uint8 XYZ_POS = 0               ### 惯性系定点控制
uint8 XY_VEL_Z_POS = 1          ### 惯性系定高速度控制
uint8 XYZ_VEL = 2               ### 惯性系速度控制
uint8 XYZ_POS_BODY = 3          ### 机体系位置控制
uint8 XYZ_VEL_BODY = 4          ### 机体系速度控制
uint8 XY_VEL_Z_POS_BODY = 5     ### 机体系定高速度控制
uint8 TRAJECTORY = 6            ### 轨迹追踪控制
uint8 XYZ_ATT = 7               ### 姿态控制（来自外部控制器）
uint8 LAT_LON_ALT = 8           ### 绝对坐标系下的经纬度

## 控制参考量
float32[3] position_ref                ## [m]
float32[3] velocity_ref                 ## [m/s]
float32[3] acceleration_ref       ## [m/s^2]
float32 yaw_ref                             ## [rad]
bool Yaw_Rate_Mode                      ## True 代表控制偏航角速率
float32 yaw_rate_ref                  ## [rad/s]
float32[4] att_ref       ## [rad] + [0-1]
float64 latitude        ## 无人机经度、纬度、高度                 
float64 longitude       ## 无人机经度、纬度、高度
float64 altitude        ## 无人机经度、纬度、高度

## 控制命令的编号 防止接收到错误命令， 编号应该逐次递加
uint32 Command_ID

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

")



(provide :px_uav_msgs/UAVCommand "8e2d468617a903de8fb514f495325390")


