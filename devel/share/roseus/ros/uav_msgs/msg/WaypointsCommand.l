;; Auto-generated. Do not edit!


(when (boundp 'uav_msgs::WaypointsCommand)
  (if (not (find-package "UAV_MSGS"))
    (make-package "UAV_MSGS"))
  (shadow 'WaypointsCommand (find-package "UAV_MSGS")))
(unless (find-package "UAV_MSGS::WAYPOINTSCOMMAND")
  (make-package "UAV_MSGS::WAYPOINTSCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude WaypointsCommand.msg.html


(defclass uav_msgs::WaypointsCommand
  :super ros::object
  :slots (_clear_existing _start_immediately _waypoints ))

(defmethod uav_msgs::WaypointsCommand
  (:init
   (&key
    ((:clear_existing __clear_existing) nil)
    ((:start_immediately __start_immediately) nil)
    ((:waypoints __waypoints) ())
    )
   (send-super :init)
   (setq _clear_existing __clear_existing)
   (setq _start_immediately __start_immediately)
   (setq _waypoints __waypoints)
   self)
  (:clear_existing
   (&optional (__clear_existing :null))
   (if (not (eq __clear_existing :null)) (setq _clear_existing __clear_existing)) _clear_existing)
  (:start_immediately
   (&optional (__start_immediately :null))
   (if (not (eq __start_immediately :null)) (setq _start_immediately __start_immediately)) _start_immediately)
  (:waypoints
   (&rest __waypoints)
   (if (keywordp (car __waypoints))
       (send* _waypoints __waypoints)
     (progn
       (if __waypoints (setq _waypoints (car __waypoints)))
       _waypoints)))
  (:serialization-length
   ()
   (+
    ;; bool _clear_existing
    1
    ;; bool _start_immediately
    1
    ;; uav_msgs/Waypoint[] _waypoints
    (apply #'+ (send-all _waypoints :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _clear_existing
       (if _clear_existing (write-byte -1 s) (write-byte 0 s))
     ;; bool _start_immediately
       (if _start_immediately (write-byte -1 s) (write-byte 0 s))
     ;; uav_msgs/Waypoint[] _waypoints
     (write-long (length _waypoints) s)
     (dolist (elem _waypoints)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _clear_existing
     (setq _clear_existing (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _start_immediately
     (setq _start_immediately (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uav_msgs/Waypoint[] _waypoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _waypoints (let (r) (dotimes (i n) (push (instance uav_msgs::Waypoint :init) r)) r))
     (dolist (elem- _waypoints)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get uav_msgs::WaypointsCommand :md5sum-) "3a60269c5c8ce3371b60f6f24bd4757b")
(setf (get uav_msgs::WaypointsCommand :datatype-) "uav_msgs/WaypointsCommand")
(setf (get uav_msgs::WaypointsCommand :definition-)
      "bool clear_existing      #是否清除存在航线
bool start_immediately   # 是否立即执行
Waypoint[] waypoints       # 航点列表
================================================================================
MSG: uav_msgs/Waypoint
int32 waypoint_id
mavros_msgs/Waypoint waypoint

================================================================================
MSG: mavros_msgs/Waypoint
# Waypoint.msg
#
# ROS representation of MAVLink MISSION_ITEM
# See mavlink documentation



# see enum MAV_FRAME
uint8 frame
uint8 FRAME_GLOBAL = 0
uint8 FRAME_LOCAL_NED = 1
uint8 FRAME_MISSION = 2
uint8 FRAME_GLOBAL_REL_ALT = 3
uint8 FRAME_LOCAL_ENU = 4
uint8 FRAME_GLOBAL_INT = 5
uint8 FRAME_GLOBAL_RELATIVE_ALT_INT = 6
uint8 FRAME_LOCAL_OFFSET_NED = 7
uint8 FRAME_BODY_NED = 8
uint8 FRAME_BODY_OFFSET_NED = 9
uint8 FRAME_GLOBAL_TERRAIN_ALT = 10
uint8 FRAME_GLOBAL_TERRAIN_ALT_INT = 11
uint8 FRAME_BODY_FRD = 12
uint8 FRAME_RESERVED_13 = 13
uint8 FRAME_RESERVED_14 = 14
uint8 FRAME_RESERVED_15 = 15
uint8 FRAME_RESERVED_16 = 16
uint8 FRAME_RESERVED_17 = 17
uint8 FRAME_RESERVED_18 = 18
uint8 FRAME_RESERVED_19 = 19
uint8 FRAME_LOCAL_FRD = 20
uint8 FRAME_LOCAL_FLU = 21

# see enum MAV_CMD and CommandCode.msg
uint16 command

bool is_current
bool autocontinue
# meaning of this params described in enum MAV_CMD
float32 param1
float32 param2
float32 param3
float32 param4
float64 x_lat
float64 y_long
float64 z_alt

")



(provide :uav_msgs/WaypointsCommand "3a60269c5c8ce3371b60f6f24bd4757b")


