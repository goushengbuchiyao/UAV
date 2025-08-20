; Auto-generated. Do not edit!


(cl:in-package uav_msgs-msg)


;//! \htmlinclude UAVControlCommand.msg.html

(cl:defclass <UAVControlCommand> (roslisp-msg-protocol:ros-message)
  ((command_type
    :reader command_type
    :initarg :command_type
    :type cl:string
    :initform "")
   (timestamp
    :reader timestamp
    :initarg :timestamp
    :type cl:real
    :initform 0)
   (target_system
    :reader target_system
    :initarg :target_system
    :type cl:integer
    :initform 0)
   (takeoff
    :reader takeoff
    :initarg :takeoff
    :type uav_msgs-msg:TakeoffCommand
    :initform (cl:make-instance 'uav_msgs-msg:TakeoffCommand))
   (land
    :reader land
    :initarg :land
    :type uav_msgs-msg:LandCommand
    :initform (cl:make-instance 'uav_msgs-msg:LandCommand))
   (pos_ned
    :reader pos_ned
    :initarg :pos_ned
    :type uav_msgs-msg:PositionControlNEDCommand
    :initform (cl:make-instance 'uav_msgs-msg:PositionControlNEDCommand))
   (pos_global
    :reader pos_global
    :initarg :pos_global
    :type uav_msgs-msg:PositionControlGlobalCommand
    :initform (cl:make-instance 'uav_msgs-msg:PositionControlGlobalCommand))
   (vel_ned
    :reader vel_ned
    :initarg :vel_ned
    :type uav_msgs-msg:VelocityControlNEDCommand
    :initform (cl:make-instance 'uav_msgs-msg:VelocityControlNEDCommand))
   (rtl
    :reader rtl
    :initarg :rtl
    :type uav_msgs-msg:ReturnToLaunchCommand
    :initform (cl:make-instance 'uav_msgs-msg:ReturnToLaunchCommand))
   (hover
    :reader hover
    :initarg :hover
    :type uav_msgs-msg:HoverCommand
    :initform (cl:make-instance 'uav_msgs-msg:HoverCommand))
   (set_mode
    :reader set_mode
    :initarg :set_mode
    :type uav_msgs-msg:SetModeCommand
    :initform (cl:make-instance 'uav_msgs-msg:SetModeCommand))
   (waypoints_cmd
    :reader waypoints_cmd
    :initarg :waypoints_cmd
    :type uav_msgs-msg:WaypointsCommand
    :initform (cl:make-instance 'uav_msgs-msg:WaypointsCommand)))
)

(cl:defclass UAVControlCommand (<UAVControlCommand>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UAVControlCommand>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UAVControlCommand)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uav_msgs-msg:<UAVControlCommand> is deprecated: use uav_msgs-msg:UAVControlCommand instead.")))

(cl:ensure-generic-function 'command_type-val :lambda-list '(m))
(cl:defmethod command_type-val ((m <UAVControlCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:command_type-val is deprecated.  Use uav_msgs-msg:command_type instead.")
  (command_type m))

(cl:ensure-generic-function 'timestamp-val :lambda-list '(m))
(cl:defmethod timestamp-val ((m <UAVControlCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:timestamp-val is deprecated.  Use uav_msgs-msg:timestamp instead.")
  (timestamp m))

(cl:ensure-generic-function 'target_system-val :lambda-list '(m))
(cl:defmethod target_system-val ((m <UAVControlCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:target_system-val is deprecated.  Use uav_msgs-msg:target_system instead.")
  (target_system m))

(cl:ensure-generic-function 'takeoff-val :lambda-list '(m))
(cl:defmethod takeoff-val ((m <UAVControlCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:takeoff-val is deprecated.  Use uav_msgs-msg:takeoff instead.")
  (takeoff m))

(cl:ensure-generic-function 'land-val :lambda-list '(m))
(cl:defmethod land-val ((m <UAVControlCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:land-val is deprecated.  Use uav_msgs-msg:land instead.")
  (land m))

(cl:ensure-generic-function 'pos_ned-val :lambda-list '(m))
(cl:defmethod pos_ned-val ((m <UAVControlCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:pos_ned-val is deprecated.  Use uav_msgs-msg:pos_ned instead.")
  (pos_ned m))

(cl:ensure-generic-function 'pos_global-val :lambda-list '(m))
(cl:defmethod pos_global-val ((m <UAVControlCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:pos_global-val is deprecated.  Use uav_msgs-msg:pos_global instead.")
  (pos_global m))

(cl:ensure-generic-function 'vel_ned-val :lambda-list '(m))
(cl:defmethod vel_ned-val ((m <UAVControlCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:vel_ned-val is deprecated.  Use uav_msgs-msg:vel_ned instead.")
  (vel_ned m))

(cl:ensure-generic-function 'rtl-val :lambda-list '(m))
(cl:defmethod rtl-val ((m <UAVControlCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:rtl-val is deprecated.  Use uav_msgs-msg:rtl instead.")
  (rtl m))

(cl:ensure-generic-function 'hover-val :lambda-list '(m))
(cl:defmethod hover-val ((m <UAVControlCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:hover-val is deprecated.  Use uav_msgs-msg:hover instead.")
  (hover m))

(cl:ensure-generic-function 'set_mode-val :lambda-list '(m))
(cl:defmethod set_mode-val ((m <UAVControlCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:set_mode-val is deprecated.  Use uav_msgs-msg:set_mode instead.")
  (set_mode m))

(cl:ensure-generic-function 'waypoints_cmd-val :lambda-list '(m))
(cl:defmethod waypoints_cmd-val ((m <UAVControlCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:waypoints_cmd-val is deprecated.  Use uav_msgs-msg:waypoints_cmd instead.")
  (waypoints_cmd m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UAVControlCommand>) ostream)
  "Serializes a message object of type '<UAVControlCommand>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'command_type))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'command_type))
  (cl:let ((__sec (cl:floor (cl:slot-value msg 'timestamp)))
        (__nsec (cl:round (cl:* 1e9 (cl:- (cl:slot-value msg 'timestamp) (cl:floor (cl:slot-value msg 'timestamp)))))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __sec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 0) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __nsec) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __nsec) ostream))
  (cl:let* ((signed (cl:slot-value msg 'target_system)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'takeoff) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'land) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pos_ned) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'pos_global) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'vel_ned) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'rtl) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'hover) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'set_mode) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'waypoints_cmd) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UAVControlCommand>) istream)
  "Deserializes a message object of type '<UAVControlCommand>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'command_type) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'command_type) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((__sec 0) (__nsec 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __sec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 0) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __nsec) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __nsec) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'timestamp) (cl:+ (cl:coerce __sec 'cl:double-float) (cl:/ __nsec 1e9))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'target_system) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'takeoff) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'land) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pos_ned) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'pos_global) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'vel_ned) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'rtl) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'hover) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'set_mode) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'waypoints_cmd) istream)
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UAVControlCommand>)))
  "Returns string type for a message object of type '<UAVControlCommand>"
  "uav_msgs/UAVControlCommand")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UAVControlCommand)))
  "Returns string type for a message object of type 'UAVControlCommand"
  "uav_msgs/UAVControlCommand")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UAVControlCommand>)))
  "Returns md5sum for a message object of type '<UAVControlCommand>"
  "f1644fc0af173323746f79d8eb46fbc4")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UAVControlCommand)))
  "Returns md5sum for a message object of type 'UAVControlCommand"
  "f1644fc0af173323746f79d8eb46fbc4")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UAVControlCommand>)))
  "Returns full string definition for message of type '<UAVControlCommand>"
  (cl:format cl:nil "~%string command_type~%time timestamp~%int32 target_system~%~%TakeoffCommand takeoff~%LandCommand land~%PositionControlNEDCommand pos_ned~%PositionControlGlobalCommand pos_global~%VelocityControlNEDCommand vel_ned~%ReturnToLaunchCommand rtl~%HoverCommand hover~%SetModeCommand set_mode~%WaypointsCommand waypoints_cmd~%~%================================================================================~%MSG: uav_msgs/TakeoffCommand~%float64 altitude~%float64 yaw~%~%================================================================================~%MSG: uav_msgs/LandCommand~%float64 yaw~%~%================================================================================~%MSG: uav_msgs/PositionControlNEDCommand~%float64 x~%float64 y~%float64 z~%float64 yaw~%~%================================================================================~%MSG: uav_msgs/PositionControlGlobalCommand~%float64 latitude~%float64 longitude~%float64 altitude~%float64 yaw~%~%================================================================================~%MSG: uav_msgs/VelocityControlNEDCommand~%float64 vx~%float64 vy~%float64 vz~%float64 yaw_rate~%~%================================================================================~%MSG: uav_msgs/ReturnToLaunchCommand~%float64 altitude~%~%================================================================================~%MSG: uav_msgs/HoverCommand~%string mode~%================================================================================~%MSG: uav_msgs/SetModeCommand~%string mode~%~%================================================================================~%MSG: uav_msgs/WaypointsCommand~%bool clear_existing      #是否清除存在航线~%Waypoint[] waypoints       # 航点列表~%================================================================================~%MSG: uav_msgs/Waypoint~%int32 waypoint_id~%mavros_msgs/Waypoint waypoint~%~%================================================================================~%MSG: mavros_msgs/Waypoint~%# Waypoint.msg~%#~%# ROS representation of MAVLink MISSION_ITEM~%# See mavlink documentation~%~%~%~%# see enum MAV_FRAME~%uint8 frame~%uint8 FRAME_GLOBAL = 0~%uint8 FRAME_LOCAL_NED = 1~%uint8 FRAME_MISSION = 2~%uint8 FRAME_GLOBAL_REL_ALT = 3~%uint8 FRAME_LOCAL_ENU = 4~%uint8 FRAME_GLOBAL_INT = 5~%uint8 FRAME_GLOBAL_RELATIVE_ALT_INT = 6~%uint8 FRAME_LOCAL_OFFSET_NED = 7~%uint8 FRAME_BODY_NED = 8~%uint8 FRAME_BODY_OFFSET_NED = 9~%uint8 FRAME_GLOBAL_TERRAIN_ALT = 10~%uint8 FRAME_GLOBAL_TERRAIN_ALT_INT = 11~%uint8 FRAME_BODY_FRD = 12~%uint8 FRAME_RESERVED_13 = 13~%uint8 FRAME_RESERVED_14 = 14~%uint8 FRAME_RESERVED_15 = 15~%uint8 FRAME_RESERVED_16 = 16~%uint8 FRAME_RESERVED_17 = 17~%uint8 FRAME_RESERVED_18 = 18~%uint8 FRAME_RESERVED_19 = 19~%uint8 FRAME_LOCAL_FRD = 20~%uint8 FRAME_LOCAL_FLU = 21~%~%# see enum MAV_CMD and CommandCode.msg~%uint16 command~%~%bool is_current~%bool autocontinue~%# meaning of this params described in enum MAV_CMD~%float32 param1~%float32 param2~%float32 param3~%float32 param4~%float64 x_lat~%float64 y_long~%float64 z_alt~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UAVControlCommand)))
  "Returns full string definition for message of type 'UAVControlCommand"
  (cl:format cl:nil "~%string command_type~%time timestamp~%int32 target_system~%~%TakeoffCommand takeoff~%LandCommand land~%PositionControlNEDCommand pos_ned~%PositionControlGlobalCommand pos_global~%VelocityControlNEDCommand vel_ned~%ReturnToLaunchCommand rtl~%HoverCommand hover~%SetModeCommand set_mode~%WaypointsCommand waypoints_cmd~%~%================================================================================~%MSG: uav_msgs/TakeoffCommand~%float64 altitude~%float64 yaw~%~%================================================================================~%MSG: uav_msgs/LandCommand~%float64 yaw~%~%================================================================================~%MSG: uav_msgs/PositionControlNEDCommand~%float64 x~%float64 y~%float64 z~%float64 yaw~%~%================================================================================~%MSG: uav_msgs/PositionControlGlobalCommand~%float64 latitude~%float64 longitude~%float64 altitude~%float64 yaw~%~%================================================================================~%MSG: uav_msgs/VelocityControlNEDCommand~%float64 vx~%float64 vy~%float64 vz~%float64 yaw_rate~%~%================================================================================~%MSG: uav_msgs/ReturnToLaunchCommand~%float64 altitude~%~%================================================================================~%MSG: uav_msgs/HoverCommand~%string mode~%================================================================================~%MSG: uav_msgs/SetModeCommand~%string mode~%~%================================================================================~%MSG: uav_msgs/WaypointsCommand~%bool clear_existing      #是否清除存在航线~%Waypoint[] waypoints       # 航点列表~%================================================================================~%MSG: uav_msgs/Waypoint~%int32 waypoint_id~%mavros_msgs/Waypoint waypoint~%~%================================================================================~%MSG: mavros_msgs/Waypoint~%# Waypoint.msg~%#~%# ROS representation of MAVLink MISSION_ITEM~%# See mavlink documentation~%~%~%~%# see enum MAV_FRAME~%uint8 frame~%uint8 FRAME_GLOBAL = 0~%uint8 FRAME_LOCAL_NED = 1~%uint8 FRAME_MISSION = 2~%uint8 FRAME_GLOBAL_REL_ALT = 3~%uint8 FRAME_LOCAL_ENU = 4~%uint8 FRAME_GLOBAL_INT = 5~%uint8 FRAME_GLOBAL_RELATIVE_ALT_INT = 6~%uint8 FRAME_LOCAL_OFFSET_NED = 7~%uint8 FRAME_BODY_NED = 8~%uint8 FRAME_BODY_OFFSET_NED = 9~%uint8 FRAME_GLOBAL_TERRAIN_ALT = 10~%uint8 FRAME_GLOBAL_TERRAIN_ALT_INT = 11~%uint8 FRAME_BODY_FRD = 12~%uint8 FRAME_RESERVED_13 = 13~%uint8 FRAME_RESERVED_14 = 14~%uint8 FRAME_RESERVED_15 = 15~%uint8 FRAME_RESERVED_16 = 16~%uint8 FRAME_RESERVED_17 = 17~%uint8 FRAME_RESERVED_18 = 18~%uint8 FRAME_RESERVED_19 = 19~%uint8 FRAME_LOCAL_FRD = 20~%uint8 FRAME_LOCAL_FLU = 21~%~%# see enum MAV_CMD and CommandCode.msg~%uint16 command~%~%bool is_current~%bool autocontinue~%# meaning of this params described in enum MAV_CMD~%float32 param1~%float32 param2~%float32 param3~%float32 param4~%float64 x_lat~%float64 y_long~%float64 z_alt~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UAVControlCommand>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'command_type))
     8
     4
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'takeoff))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'land))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pos_ned))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'pos_global))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'vel_ned))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'rtl))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'hover))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'set_mode))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'waypoints_cmd))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UAVControlCommand>))
  "Converts a ROS message object to a list"
  (cl:list 'UAVControlCommand
    (cl:cons ':command_type (command_type msg))
    (cl:cons ':timestamp (timestamp msg))
    (cl:cons ':target_system (target_system msg))
    (cl:cons ':takeoff (takeoff msg))
    (cl:cons ':land (land msg))
    (cl:cons ':pos_ned (pos_ned msg))
    (cl:cons ':pos_global (pos_global msg))
    (cl:cons ':vel_ned (vel_ned msg))
    (cl:cons ':rtl (rtl msg))
    (cl:cons ':hover (hover msg))
    (cl:cons ':set_mode (set_mode msg))
    (cl:cons ':waypoints_cmd (waypoints_cmd msg))
))
