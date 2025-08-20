;; Auto-generated. Do not edit!


(when (boundp 'uav_msgs::Waypoint)
  (if (not (find-package "UAV_MSGS"))
    (make-package "UAV_MSGS"))
  (shadow 'Waypoint (find-package "UAV_MSGS")))
(unless (find-package "UAV_MSGS::WAYPOINT")
  (make-package "UAV_MSGS::WAYPOINT"))

(in-package "ROS")
;;//! \htmlinclude Waypoint.msg.html
(if (not (find-package "MAVROS_MSGS"))
  (ros::roseus-add-msgs "mavros_msgs"))


(defclass uav_msgs::Waypoint
  :super ros::object
  :slots (_waypoint_id _waypoint ))

(defmethod uav_msgs::Waypoint
  (:init
   (&key
    ((:waypoint_id __waypoint_id) 0)
    ((:waypoint __waypoint) (instance mavros_msgs::Waypoint :init))
    )
   (send-super :init)
   (setq _waypoint_id (round __waypoint_id))
   (setq _waypoint __waypoint)
   self)
  (:waypoint_id
   (&optional __waypoint_id)
   (if __waypoint_id (setq _waypoint_id __waypoint_id)) _waypoint_id)
  (:waypoint
   (&rest __waypoint)
   (if (keywordp (car __waypoint))
       (send* _waypoint __waypoint)
     (progn
       (if __waypoint (setq _waypoint (car __waypoint)))
       _waypoint)))
  (:serialization-length
   ()
   (+
    ;; int32 _waypoint_id
    4
    ;; mavros_msgs/Waypoint _waypoint
    (send _waypoint :serialization-length)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _waypoint_id
       (write-long _waypoint_id s)
     ;; mavros_msgs/Waypoint _waypoint
       (send _waypoint :serialize s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _waypoint_id
     (setq _waypoint_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; mavros_msgs/Waypoint _waypoint
     (send _waypoint :deserialize buf ptr-) (incf ptr- (send _waypoint :serialization-length))
   ;;
   self)
  )

(setf (get uav_msgs::Waypoint :md5sum-) "a6f99f03f8a3405b686baeb3a31c59e9")
(setf (get uav_msgs::Waypoint :datatype-) "uav_msgs/Waypoint")
(setf (get uav_msgs::Waypoint :definition-)
      "int32 waypoint_id
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



(provide :uav_msgs/Waypoint "a6f99f03f8a3405b686baeb3a31c59e9")


