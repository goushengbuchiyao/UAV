;; Auto-generated. Do not edit!


(when (boundp 'px_uav_msgs::UAVControlState)
  (if (not (find-package "PX_UAV_MSGS"))
    (make-package "PX_UAV_MSGS"))
  (shadow 'UAVControlState (find-package "PX_UAV_MSGS")))
(unless (find-package "PX_UAV_MSGS::UAVCONTROLSTATE")
  (make-package "PX_UAV_MSGS::UAVCONTROLSTATE"))

(in-package "ROS")
;;//! \htmlinclude UAVControlState.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*INIT*" (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(shadow '*INIT* (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(defconstant px_uav_msgs::UAVControlState::*INIT* 0)
(intern "*RC_POS_CONTROL*" (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(shadow '*RC_POS_CONTROL* (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(defconstant px_uav_msgs::UAVControlState::*RC_POS_CONTROL* 1)
(intern "*COMMAND_CONTROL*" (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(shadow '*COMMAND_CONTROL* (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(defconstant px_uav_msgs::UAVControlState::*COMMAND_CONTROL* 2)
(intern "*LAND_CONTROL*" (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(shadow '*LAND_CONTROL* (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(defconstant px_uav_msgs::UAVControlState::*LAND_CONTROL* 3)
(intern "*PX4_ORIGIN*" (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(shadow '*PX4_ORIGIN* (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(defconstant px_uav_msgs::UAVControlState::*PX4_ORIGIN* 0)
(intern "*PID*" (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(shadow '*PID* (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(defconstant px_uav_msgs::UAVControlState::*PID* 1)
(intern "*UDE*" (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(shadow '*UDE* (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(defconstant px_uav_msgs::UAVControlState::*UDE* 2)
(intern "*NE*" (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(shadow '*NE* (find-package "PX_UAV_MSGS::UAVCONTROLSTATE"))
(defconstant px_uav_msgs::UAVControlState::*NE* 3)

(defun px_uav_msgs::UAVControlState-to-symbol (const)
  (cond
        ((= const 0) 'px_uav_msgs::UAVControlState::*INIT*)
        ((= const 1) 'px_uav_msgs::UAVControlState::*RC_POS_CONTROL*)
        ((= const 2) 'px_uav_msgs::UAVControlState::*COMMAND_CONTROL*)
        ((= const 3) 'px_uav_msgs::UAVControlState::*LAND_CONTROL*)
        ((= const 0) 'px_uav_msgs::UAVControlState::*PX4_ORIGIN*)
        ((= const 1) 'px_uav_msgs::UAVControlState::*PID*)
        ((= const 2) 'px_uav_msgs::UAVControlState::*UDE*)
        ((= const 3) 'px_uav_msgs::UAVControlState::*NE*)
        (t nil)))

(defclass px_uav_msgs::UAVControlState
  :super ros::object
  :slots (_header _uav_id _control_state _pos_controller _failsafe _mode _position _velocity _yaw _takeoff _land _emergency ))

(defmethod px_uav_msgs::UAVControlState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:uav_id __uav_id) 0)
    ((:control_state __control_state) 0)
    ((:pos_controller __pos_controller) 0)
    ((:failsafe __failsafe) nil)
    ((:mode __mode) "")
    ((:position __position) (instance geometry_msgs::Point :init))
    ((:velocity __velocity) (instance geometry_msgs::Vector3 :init))
    ((:yaw __yaw) 0.0)
    ((:takeoff __takeoff) nil)
    ((:land __land) nil)
    ((:emergency __emergency) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _uav_id (round __uav_id))
   (setq _control_state (round __control_state))
   (setq _pos_controller (round __pos_controller))
   (setq _failsafe __failsafe)
   (setq _mode (string __mode))
   (setq _position __position)
   (setq _velocity __velocity)
   (setq _yaw (float __yaw))
   (setq _takeoff __takeoff)
   (setq _land __land)
   (setq _emergency __emergency)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:uav_id
   (&optional __uav_id)
   (if __uav_id (setq _uav_id __uav_id)) _uav_id)
  (:control_state
   (&optional __control_state)
   (if __control_state (setq _control_state __control_state)) _control_state)
  (:pos_controller
   (&optional __pos_controller)
   (if __pos_controller (setq _pos_controller __pos_controller)) _pos_controller)
  (:failsafe
   (&optional (__failsafe :null))
   (if (not (eq __failsafe :null)) (setq _failsafe __failsafe)) _failsafe)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:position
   (&rest __position)
   (if (keywordp (car __position))
       (send* _position __position)
     (progn
       (if __position (setq _position (car __position)))
       _position)))
  (:velocity
   (&rest __velocity)
   (if (keywordp (car __velocity))
       (send* _velocity __velocity)
     (progn
       (if __velocity (setq _velocity (car __velocity)))
       _velocity)))
  (:yaw
   (&optional __yaw)
   (if __yaw (setq _yaw __yaw)) _yaw)
  (:takeoff
   (&optional (__takeoff :null))
   (if (not (eq __takeoff :null)) (setq _takeoff __takeoff)) _takeoff)
  (:land
   (&optional (__land :null))
   (if (not (eq __land :null)) (setq _land __land)) _land)
  (:emergency
   (&optional (__emergency :null))
   (if (not (eq __emergency :null)) (setq _emergency __emergency)) _emergency)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _uav_id
    1
    ;; uint8 _control_state
    1
    ;; uint8 _pos_controller
    1
    ;; bool _failsafe
    1
    ;; string _mode
    4 (length _mode)
    ;; geometry_msgs/Point _position
    (send _position :serialization-length)
    ;; geometry_msgs/Vector3 _velocity
    (send _velocity :serialization-length)
    ;; float64 _yaw
    8
    ;; bool _takeoff
    1
    ;; bool _land
    1
    ;; bool _emergency
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _uav_id
       (write-byte _uav_id s)
     ;; uint8 _control_state
       (write-byte _control_state s)
     ;; uint8 _pos_controller
       (write-byte _pos_controller s)
     ;; bool _failsafe
       (if _failsafe (write-byte -1 s) (write-byte 0 s))
     ;; string _mode
       (write-long (length _mode) s) (princ _mode s)
     ;; geometry_msgs/Point _position
       (send _position :serialize s)
     ;; geometry_msgs/Vector3 _velocity
       (send _velocity :serialize s)
     ;; float64 _yaw
       (sys::poke _yaw (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; bool _takeoff
       (if _takeoff (write-byte -1 s) (write-byte 0 s))
     ;; bool _land
       (if _land (write-byte -1 s) (write-byte 0 s))
     ;; bool _emergency
       (if _emergency (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _uav_id
     (setq _uav_id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _control_state
     (setq _control_state (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _pos_controller
     (setq _pos_controller (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; bool _failsafe
     (setq _failsafe (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _mode
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _mode (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; geometry_msgs/Point _position
     (send _position :deserialize buf ptr-) (incf ptr- (send _position :serialization-length))
   ;; geometry_msgs/Vector3 _velocity
     (send _velocity :deserialize buf ptr-) (incf ptr- (send _velocity :serialization-length))
   ;; float64 _yaw
     (setq _yaw (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; bool _takeoff
     (setq _takeoff (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _land
     (setq _land (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _emergency
     (setq _emergency (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get px_uav_msgs::UAVControlState :md5sum-) "e659c63b910cf2a272d26e1d4b516070")
(setf (get px_uav_msgs::UAVControlState :datatype-) "px_uav_msgs/UAVControlState")
(setf (get px_uav_msgs::UAVControlState :definition-)
      "std_msgs/Header header

## 无人机编号 
uint8 uav_id

## 无人机控制状态
uint8 control_state
## 状态枚举
uint8 INIT=0
uint8 RC_POS_CONTROL=1
uint8 COMMAND_CONTROL=2
uint8 LAND_CONTROL=3

## 无人机控制器标志量
uint8 pos_controller
## 状态枚举
uint8 PX4_ORIGIN=0
uint8 PID=1
uint8 UDE=2
uint8 NE=3

# 无人机安全保护触发标志量
bool failsafe

string mode
geometry_msgs/Point position
geometry_msgs/Vector3 velocity
float64 yaw
bool takeoff
bool land
bool emergency
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

================================================================================
MSG: geometry_msgs/Point
# This contains the position of a point in free space
float64 x
float64 y
float64 z

================================================================================
MSG: geometry_msgs/Vector3
# This represents a vector in free space. 
# It is only meant to represent a direction. Therefore, it does not
# make sense to apply a translation to it (e.g., when applying a 
# generic rigid transformation to a Vector3, tf2 will only apply the
# rotation). If you want your data to be translatable too, use the
# geometry_msgs/Point message instead.

float64 x
float64 y
float64 z
")



(provide :px_uav_msgs/UAVControlState "e659c63b910cf2a272d26e1d4b516070")


