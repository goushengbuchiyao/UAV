; Auto-generated. Do not edit!


(cl:in-package uav_msgs-msg)


;//! \htmlinclude Waypoint.msg.html

(cl:defclass <Waypoint> (roslisp-msg-protocol:ros-message)
  ((waypoint_id
    :reader waypoint_id
    :initarg :waypoint_id
    :type cl:integer
    :initform 0)
   (waypoint
    :reader waypoint
    :initarg :waypoint
    :type mavros_msgs-msg:Waypoint
    :initform (cl:make-instance 'mavros_msgs-msg:Waypoint)))
)

(cl:defclass Waypoint (<Waypoint>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Waypoint>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Waypoint)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uav_msgs-msg:<Waypoint> is deprecated: use uav_msgs-msg:Waypoint instead.")))

(cl:ensure-generic-function 'waypoint_id-val :lambda-list '(m))
(cl:defmethod waypoint_id-val ((m <Waypoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:waypoint_id-val is deprecated.  Use uav_msgs-msg:waypoint_id instead.")
  (waypoint_id m))

(cl:ensure-generic-function 'waypoint-val :lambda-list '(m))
(cl:defmethod waypoint-val ((m <Waypoint>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:waypoint-val is deprecated.  Use uav_msgs-msg:waypoint instead.")
  (waypoint m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Waypoint>) ostream)
  "Serializes a message object of type '<Waypoint>"
  (cl:let* ((signed (cl:slot-value msg 'waypoint_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'waypoint) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Waypoint>) istream)
  "Deserializes a message object of type '<Waypoint>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'waypoint_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'waypoint) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Waypoint>)))
  "Returns string type for a message object of type '<Waypoint>"
  "uav_msgs/Waypoint")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Waypoint)))
  "Returns string type for a message object of type 'Waypoint"
  "uav_msgs/Waypoint")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Waypoint>)))
  "Returns md5sum for a message object of type '<Waypoint>"
  "a6f99f03f8a3405b686baeb3a31c59e9")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Waypoint)))
  "Returns md5sum for a message object of type 'Waypoint"
  "a6f99f03f8a3405b686baeb3a31c59e9")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Waypoint>)))
  "Returns full string definition for message of type '<Waypoint>"
  (cl:format cl:nil "int32 waypoint_id~%mavros_msgs/Waypoint waypoint~%~%================================================================================~%MSG: mavros_msgs/Waypoint~%# Waypoint.msg~%#~%# ROS representation of MAVLink MISSION_ITEM~%# See mavlink documentation~%~%~%~%# see enum MAV_FRAME~%uint8 frame~%uint8 FRAME_GLOBAL = 0~%uint8 FRAME_LOCAL_NED = 1~%uint8 FRAME_MISSION = 2~%uint8 FRAME_GLOBAL_REL_ALT = 3~%uint8 FRAME_LOCAL_ENU = 4~%uint8 FRAME_GLOBAL_INT = 5~%uint8 FRAME_GLOBAL_RELATIVE_ALT_INT = 6~%uint8 FRAME_LOCAL_OFFSET_NED = 7~%uint8 FRAME_BODY_NED = 8~%uint8 FRAME_BODY_OFFSET_NED = 9~%uint8 FRAME_GLOBAL_TERRAIN_ALT = 10~%uint8 FRAME_GLOBAL_TERRAIN_ALT_INT = 11~%uint8 FRAME_BODY_FRD = 12~%uint8 FRAME_RESERVED_13 = 13~%uint8 FRAME_RESERVED_14 = 14~%uint8 FRAME_RESERVED_15 = 15~%uint8 FRAME_RESERVED_16 = 16~%uint8 FRAME_RESERVED_17 = 17~%uint8 FRAME_RESERVED_18 = 18~%uint8 FRAME_RESERVED_19 = 19~%uint8 FRAME_LOCAL_FRD = 20~%uint8 FRAME_LOCAL_FLU = 21~%~%# see enum MAV_CMD and CommandCode.msg~%uint16 command~%~%bool is_current~%bool autocontinue~%# meaning of this params described in enum MAV_CMD~%float32 param1~%float32 param2~%float32 param3~%float32 param4~%float64 x_lat~%float64 y_long~%float64 z_alt~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Waypoint)))
  "Returns full string definition for message of type 'Waypoint"
  (cl:format cl:nil "int32 waypoint_id~%mavros_msgs/Waypoint waypoint~%~%================================================================================~%MSG: mavros_msgs/Waypoint~%# Waypoint.msg~%#~%# ROS representation of MAVLink MISSION_ITEM~%# See mavlink documentation~%~%~%~%# see enum MAV_FRAME~%uint8 frame~%uint8 FRAME_GLOBAL = 0~%uint8 FRAME_LOCAL_NED = 1~%uint8 FRAME_MISSION = 2~%uint8 FRAME_GLOBAL_REL_ALT = 3~%uint8 FRAME_LOCAL_ENU = 4~%uint8 FRAME_GLOBAL_INT = 5~%uint8 FRAME_GLOBAL_RELATIVE_ALT_INT = 6~%uint8 FRAME_LOCAL_OFFSET_NED = 7~%uint8 FRAME_BODY_NED = 8~%uint8 FRAME_BODY_OFFSET_NED = 9~%uint8 FRAME_GLOBAL_TERRAIN_ALT = 10~%uint8 FRAME_GLOBAL_TERRAIN_ALT_INT = 11~%uint8 FRAME_BODY_FRD = 12~%uint8 FRAME_RESERVED_13 = 13~%uint8 FRAME_RESERVED_14 = 14~%uint8 FRAME_RESERVED_15 = 15~%uint8 FRAME_RESERVED_16 = 16~%uint8 FRAME_RESERVED_17 = 17~%uint8 FRAME_RESERVED_18 = 18~%uint8 FRAME_RESERVED_19 = 19~%uint8 FRAME_LOCAL_FRD = 20~%uint8 FRAME_LOCAL_FLU = 21~%~%# see enum MAV_CMD and CommandCode.msg~%uint16 command~%~%bool is_current~%bool autocontinue~%# meaning of this params described in enum MAV_CMD~%float32 param1~%float32 param2~%float32 param3~%float32 param4~%float64 x_lat~%float64 y_long~%float64 z_alt~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Waypoint>))
  (cl:+ 0
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'waypoint))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Waypoint>))
  "Converts a ROS message object to a list"
  (cl:list 'Waypoint
    (cl:cons ':waypoint_id (waypoint_id msg))
    (cl:cons ':waypoint (waypoint msg))
))
