; Auto-generated. Do not edit!


(cl:in-package px_uav_msgs-msg)


;//! \htmlinclude UAVControlState.msg.html

(cl:defclass <UAVControlState> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (uav_id
    :reader uav_id
    :initarg :uav_id
    :type cl:fixnum
    :initform 0)
   (control_state
    :reader control_state
    :initarg :control_state
    :type cl:fixnum
    :initform 0)
   (pos_controller
    :reader pos_controller
    :initarg :pos_controller
    :type cl:fixnum
    :initform 0)
   (failsafe
    :reader failsafe
    :initarg :failsafe
    :type cl:boolean
    :initform cl:nil)
   (mode
    :reader mode
    :initarg :mode
    :type cl:string
    :initform "")
   (position
    :reader position
    :initarg :position
    :type geometry_msgs-msg:Point
    :initform (cl:make-instance 'geometry_msgs-msg:Point))
   (velocity
    :reader velocity
    :initarg :velocity
    :type geometry_msgs-msg:Vector3
    :initform (cl:make-instance 'geometry_msgs-msg:Vector3))
   (yaw
    :reader yaw
    :initarg :yaw
    :type cl:float
    :initform 0.0)
   (takeoff
    :reader takeoff
    :initarg :takeoff
    :type cl:boolean
    :initform cl:nil)
   (land
    :reader land
    :initarg :land
    :type cl:boolean
    :initform cl:nil)
   (emergency
    :reader emergency
    :initarg :emergency
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass UAVControlState (<UAVControlState>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <UAVControlState>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'UAVControlState)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name px_uav_msgs-msg:<UAVControlState> is deprecated: use px_uav_msgs-msg:UAVControlState instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:header-val is deprecated.  Use px_uav_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'uav_id-val :lambda-list '(m))
(cl:defmethod uav_id-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:uav_id-val is deprecated.  Use px_uav_msgs-msg:uav_id instead.")
  (uav_id m))

(cl:ensure-generic-function 'control_state-val :lambda-list '(m))
(cl:defmethod control_state-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:control_state-val is deprecated.  Use px_uav_msgs-msg:control_state instead.")
  (control_state m))

(cl:ensure-generic-function 'pos_controller-val :lambda-list '(m))
(cl:defmethod pos_controller-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:pos_controller-val is deprecated.  Use px_uav_msgs-msg:pos_controller instead.")
  (pos_controller m))

(cl:ensure-generic-function 'failsafe-val :lambda-list '(m))
(cl:defmethod failsafe-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:failsafe-val is deprecated.  Use px_uav_msgs-msg:failsafe instead.")
  (failsafe m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:mode-val is deprecated.  Use px_uav_msgs-msg:mode instead.")
  (mode m))

(cl:ensure-generic-function 'position-val :lambda-list '(m))
(cl:defmethod position-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:position-val is deprecated.  Use px_uav_msgs-msg:position instead.")
  (position m))

(cl:ensure-generic-function 'velocity-val :lambda-list '(m))
(cl:defmethod velocity-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:velocity-val is deprecated.  Use px_uav_msgs-msg:velocity instead.")
  (velocity m))

(cl:ensure-generic-function 'yaw-val :lambda-list '(m))
(cl:defmethod yaw-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:yaw-val is deprecated.  Use px_uav_msgs-msg:yaw instead.")
  (yaw m))

(cl:ensure-generic-function 'takeoff-val :lambda-list '(m))
(cl:defmethod takeoff-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:takeoff-val is deprecated.  Use px_uav_msgs-msg:takeoff instead.")
  (takeoff m))

(cl:ensure-generic-function 'land-val :lambda-list '(m))
(cl:defmethod land-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:land-val is deprecated.  Use px_uav_msgs-msg:land instead.")
  (land m))

(cl:ensure-generic-function 'emergency-val :lambda-list '(m))
(cl:defmethod emergency-val ((m <UAVControlState>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:emergency-val is deprecated.  Use px_uav_msgs-msg:emergency instead.")
  (emergency m))
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql '<UAVControlState>)))
    "Constants for message type '<UAVControlState>"
  '((:INIT . 0)
    (:RC_POS_CONTROL . 1)
    (:COMMAND_CONTROL . 2)
    (:LAND_CONTROL . 3)
    (:PX4_ORIGIN . 0)
    (:PID . 1)
    (:UDE . 2)
    (:NE . 3))
)
(cl:defmethod roslisp-msg-protocol:symbol-codes ((msg-type (cl:eql 'UAVControlState)))
    "Constants for message type 'UAVControlState"
  '((:INIT . 0)
    (:RC_POS_CONTROL . 1)
    (:COMMAND_CONTROL . 2)
    (:LAND_CONTROL . 3)
    (:PX4_ORIGIN . 0)
    (:PID . 1)
    (:UDE . 2)
    (:NE . 3))
)
(cl:defmethod roslisp-msg-protocol:serialize ((msg <UAVControlState>) ostream)
  "Serializes a message object of type '<UAVControlState>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'uav_id)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'control_state)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'pos_controller)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'failsafe) 1 0)) ostream)
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'mode))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'mode))
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'position) ostream)
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'velocity) ostream)
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'yaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'takeoff) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'land) 1 0)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'emergency) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <UAVControlState>) istream)
  "Deserializes a message object of type '<UAVControlState>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'uav_id)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'control_state)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'pos_controller)) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'failsafe) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'mode) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'position) istream)
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'velocity) istream)
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yaw) (roslisp-utils:decode-double-float-bits bits)))
    (cl:setf (cl:slot-value msg 'takeoff) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'land) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:setf (cl:slot-value msg 'emergency) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<UAVControlState>)))
  "Returns string type for a message object of type '<UAVControlState>"
  "px_uav_msgs/UAVControlState")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'UAVControlState)))
  "Returns string type for a message object of type 'UAVControlState"
  "px_uav_msgs/UAVControlState")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<UAVControlState>)))
  "Returns md5sum for a message object of type '<UAVControlState>"
  "e659c63b910cf2a272d26e1d4b516070")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'UAVControlState)))
  "Returns md5sum for a message object of type 'UAVControlState"
  "e659c63b910cf2a272d26e1d4b516070")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<UAVControlState>)))
  "Returns full string definition for message of type '<UAVControlState>"
  (cl:format cl:nil "std_msgs/Header header~%~%## 无人机编号 ~%uint8 uav_id~%~%## 无人机控制状态~%uint8 control_state~%## 状态枚举~%uint8 INIT=0~%uint8 RC_POS_CONTROL=1~%uint8 COMMAND_CONTROL=2~%uint8 LAND_CONTROL=3~%~%## 无人机控制器标志量~%uint8 pos_controller~%## 状态枚举~%uint8 PX4_ORIGIN=0~%uint8 PID=1~%uint8 UDE=2~%uint8 NE=3~%~%# 无人机安全保护触发标志量~%bool failsafe~%~%string mode~%geometry_msgs/Point position~%geometry_msgs/Vector3 velocity~%float64 yaw~%bool takeoff~%bool land~%bool emergency~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'UAVControlState)))
  "Returns full string definition for message of type 'UAVControlState"
  (cl:format cl:nil "std_msgs/Header header~%~%## 无人机编号 ~%uint8 uav_id~%~%## 无人机控制状态~%uint8 control_state~%## 状态枚举~%uint8 INIT=0~%uint8 RC_POS_CONTROL=1~%uint8 COMMAND_CONTROL=2~%uint8 LAND_CONTROL=3~%~%## 无人机控制器标志量~%uint8 pos_controller~%## 状态枚举~%uint8 PX4_ORIGIN=0~%uint8 PID=1~%uint8 UDE=2~%uint8 NE=3~%~%# 无人机安全保护触发标志量~%bool failsafe~%~%string mode~%geometry_msgs/Point position~%geometry_msgs/Vector3 velocity~%float64 yaw~%bool takeoff~%bool land~%bool emergency~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: geometry_msgs/Point~%# This contains the position of a point in free space~%float64 x~%float64 y~%float64 z~%~%================================================================================~%MSG: geometry_msgs/Vector3~%# This represents a vector in free space. ~%# It is only meant to represent a direction. Therefore, it does not~%# make sense to apply a translation to it (e.g., when applying a ~%# generic rigid transformation to a Vector3, tf2 will only apply the~%# rotation). If you want your data to be translatable too, use the~%# geometry_msgs/Point message instead.~%~%float64 x~%float64 y~%float64 z~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <UAVControlState>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     1
     1
     1
     1
     4 (cl:length (cl:slot-value msg 'mode))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'position))
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'velocity))
     8
     1
     1
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <UAVControlState>))
  "Converts a ROS message object to a list"
  (cl:list 'UAVControlState
    (cl:cons ':header (header msg))
    (cl:cons ':uav_id (uav_id msg))
    (cl:cons ':control_state (control_state msg))
    (cl:cons ':pos_controller (pos_controller msg))
    (cl:cons ':failsafe (failsafe msg))
    (cl:cons ':mode (mode msg))
    (cl:cons ':position (position msg))
    (cl:cons ':velocity (velocity msg))
    (cl:cons ':yaw (yaw msg))
    (cl:cons ':takeoff (takeoff msg))
    (cl:cons ':land (land msg))
    (cl:cons ':emergency (emergency msg))
))
