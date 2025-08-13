; Auto-generated. Do not edit!


(cl:in-package uav_msgs-msg)


;//! \htmlinclude LandCommand.msg.html

(cl:defclass <LandCommand> (roslisp-msg-protocol:ros-message)
  ((yaw
    :reader yaw
    :initarg :yaw
    :type cl:float
    :initform 0.0))
)

(cl:defclass LandCommand (<LandCommand>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <LandCommand>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'LandCommand)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uav_msgs-msg:<LandCommand> is deprecated: use uav_msgs-msg:LandCommand instead.")))

(cl:ensure-generic-function 'yaw-val :lambda-list '(m))
(cl:defmethod yaw-val ((m <LandCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:yaw-val is deprecated.  Use uav_msgs-msg:yaw instead.")
  (yaw m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <LandCommand>) ostream)
  "Serializes a message object of type '<LandCommand>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'yaw))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <LandCommand>) istream)
  "Deserializes a message object of type '<LandCommand>"
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
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<LandCommand>)))
  "Returns string type for a message object of type '<LandCommand>"
  "uav_msgs/LandCommand")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'LandCommand)))
  "Returns string type for a message object of type 'LandCommand"
  "uav_msgs/LandCommand")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<LandCommand>)))
  "Returns md5sum for a message object of type '<LandCommand>"
  "08cb8274b6ddb17af5a842bca0b17db1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'LandCommand)))
  "Returns md5sum for a message object of type 'LandCommand"
  "08cb8274b6ddb17af5a842bca0b17db1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<LandCommand>)))
  "Returns full string definition for message of type '<LandCommand>"
  (cl:format cl:nil "float64 yaw~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'LandCommand)))
  "Returns full string definition for message of type 'LandCommand"
  (cl:format cl:nil "float64 yaw~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <LandCommand>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <LandCommand>))
  "Converts a ROS message object to a list"
  (cl:list 'LandCommand
    (cl:cons ':yaw (yaw msg))
))
