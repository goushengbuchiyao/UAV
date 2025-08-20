; Auto-generated. Do not edit!


(cl:in-package uav_msgs-msg)


;//! \htmlinclude WaypointsCommand.msg.html

(cl:defclass <WaypointsCommand> (roslisp-msg-protocol:ros-message)
  ((clear_existing
    :reader clear_existing
    :initarg :clear_existing
    :type cl:boolean
    :initform cl:nil)
   (waypoints
    :reader waypoints
    :initarg :waypoints
    :type (cl:vector uav_msgs-msg:Waypoint)
   :initform (cl:make-array 0 :element-type 'uav_msgs-msg:Waypoint :initial-element (cl:make-instance 'uav_msgs-msg:Waypoint))))
)

(cl:defclass WaypointsCommand (<WaypointsCommand>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <WaypointsCommand>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'WaypointsCommand)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uav_msgs-msg:<WaypointsCommand> is deprecated: use uav_msgs-msg:WaypointsCommand instead.")))

(cl:ensure-generic-function 'clear_existing-val :lambda-list '(m))
(cl:defmethod clear_existing-val ((m <WaypointsCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:clear_existing-val is deprecated.  Use uav_msgs-msg:clear_existing instead.")
  (clear_existing m))

(cl:ensure-generic-function 'waypoints-val :lambda-list '(m))
(cl:defmethod waypoints-val ((m <WaypointsCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:waypoints-val is deprecated.  Use uav_msgs-msg:waypoints instead.")
  (waypoints m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WaypointsCommand>) ostream)
  "Serializes a message object of type '<WaypointsCommand>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'clear_existing) 1 0)) ostream)
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'waypoints))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'waypoints))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <WaypointsCommand>) istream)
  "Deserializes a message object of type '<WaypointsCommand>"
    (cl:setf (cl:slot-value msg 'clear_existing) (cl:not (cl:zerop (cl:read-byte istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'waypoints) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'waypoints)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'uav_msgs-msg:Waypoint))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<WaypointsCommand>)))
  "Returns string type for a message object of type '<WaypointsCommand>"
  "uav_msgs/WaypointsCommand")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'WaypointsCommand)))
  "Returns string type for a message object of type 'WaypointsCommand"
  "uav_msgs/WaypointsCommand")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<WaypointsCommand>)))
  "Returns md5sum for a message object of type '<WaypointsCommand>"
  "64dffdfd8bd5405e375d970e627fb6dc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WaypointsCommand)))
  "Returns md5sum for a message object of type 'WaypointsCommand"
  "64dffdfd8bd5405e375d970e627fb6dc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WaypointsCommand>)))
  "Returns full string definition for message of type '<WaypointsCommand>"
  (cl:format cl:nil "bool clear_existing      #是否清除存在航线~%Waypoint[] waypoints       # 航点列表~%================================================================================~%MSG: uav_msgs/Waypoint~%int32 waypoint_id~%mavros_msgs/Waypoint waypoint~%~%================================================================================~%MSG: mavros_msgs/Waypoint~%# Waypoint.msg~%#~%# ROS representation of MAVLink MISSION_ITEM~%# See mavlink documentation~%~%~%~%# see enum MAV_FRAME~%uint8 frame~%uint8 FRAME_GLOBAL = 0~%uint8 FRAME_LOCAL_NED = 1~%uint8 FRAME_MISSION = 2~%uint8 FRAME_GLOBAL_REL_ALT = 3~%uint8 FRAME_LOCAL_ENU = 4~%uint8 FRAME_GLOBAL_INT = 5~%uint8 FRAME_GLOBAL_RELATIVE_ALT_INT = 6~%uint8 FRAME_LOCAL_OFFSET_NED = 7~%uint8 FRAME_BODY_NED = 8~%uint8 FRAME_BODY_OFFSET_NED = 9~%uint8 FRAME_GLOBAL_TERRAIN_ALT = 10~%uint8 FRAME_GLOBAL_TERRAIN_ALT_INT = 11~%uint8 FRAME_BODY_FRD = 12~%uint8 FRAME_RESERVED_13 = 13~%uint8 FRAME_RESERVED_14 = 14~%uint8 FRAME_RESERVED_15 = 15~%uint8 FRAME_RESERVED_16 = 16~%uint8 FRAME_RESERVED_17 = 17~%uint8 FRAME_RESERVED_18 = 18~%uint8 FRAME_RESERVED_19 = 19~%uint8 FRAME_LOCAL_FRD = 20~%uint8 FRAME_LOCAL_FLU = 21~%~%# see enum MAV_CMD and CommandCode.msg~%uint16 command~%~%bool is_current~%bool autocontinue~%# meaning of this params described in enum MAV_CMD~%float32 param1~%float32 param2~%float32 param3~%float32 param4~%float64 x_lat~%float64 y_long~%float64 z_alt~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WaypointsCommand)))
  "Returns full string definition for message of type 'WaypointsCommand"
  (cl:format cl:nil "bool clear_existing      #是否清除存在航线~%Waypoint[] waypoints       # 航点列表~%================================================================================~%MSG: uav_msgs/Waypoint~%int32 waypoint_id~%mavros_msgs/Waypoint waypoint~%~%================================================================================~%MSG: mavros_msgs/Waypoint~%# Waypoint.msg~%#~%# ROS representation of MAVLink MISSION_ITEM~%# See mavlink documentation~%~%~%~%# see enum MAV_FRAME~%uint8 frame~%uint8 FRAME_GLOBAL = 0~%uint8 FRAME_LOCAL_NED = 1~%uint8 FRAME_MISSION = 2~%uint8 FRAME_GLOBAL_REL_ALT = 3~%uint8 FRAME_LOCAL_ENU = 4~%uint8 FRAME_GLOBAL_INT = 5~%uint8 FRAME_GLOBAL_RELATIVE_ALT_INT = 6~%uint8 FRAME_LOCAL_OFFSET_NED = 7~%uint8 FRAME_BODY_NED = 8~%uint8 FRAME_BODY_OFFSET_NED = 9~%uint8 FRAME_GLOBAL_TERRAIN_ALT = 10~%uint8 FRAME_GLOBAL_TERRAIN_ALT_INT = 11~%uint8 FRAME_BODY_FRD = 12~%uint8 FRAME_RESERVED_13 = 13~%uint8 FRAME_RESERVED_14 = 14~%uint8 FRAME_RESERVED_15 = 15~%uint8 FRAME_RESERVED_16 = 16~%uint8 FRAME_RESERVED_17 = 17~%uint8 FRAME_RESERVED_18 = 18~%uint8 FRAME_RESERVED_19 = 19~%uint8 FRAME_LOCAL_FRD = 20~%uint8 FRAME_LOCAL_FLU = 21~%~%# see enum MAV_CMD and CommandCode.msg~%uint16 command~%~%bool is_current~%bool autocontinue~%# meaning of this params described in enum MAV_CMD~%float32 param1~%float32 param2~%float32 param3~%float32 param4~%float64 x_lat~%float64 y_long~%float64 z_alt~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WaypointsCommand>))
  (cl:+ 0
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'waypoints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WaypointsCommand>))
  "Converts a ROS message object to a list"
  (cl:list 'WaypointsCommand
    (cl:cons ':clear_existing (clear_existing msg))
    (cl:cons ':waypoints (waypoints msg))
))
