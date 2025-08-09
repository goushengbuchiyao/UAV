; Auto-generated. Do not edit!


(cl:in-package uav_msgs-msg)


;//! \htmlinclude ReturnToLaunchCommand.msg.html

(cl:defclass <ReturnToLaunchCommand> (roslisp-msg-protocol:ros-message)
  ((altitude
    :reader altitude
    :initarg :altitude
    :type cl:float
    :initform 0.0))
)

(cl:defclass ReturnToLaunchCommand (<ReturnToLaunchCommand>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <ReturnToLaunchCommand>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'ReturnToLaunchCommand)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uav_msgs-msg:<ReturnToLaunchCommand> is deprecated: use uav_msgs-msg:ReturnToLaunchCommand instead.")))

(cl:ensure-generic-function 'altitude-val :lambda-list '(m))
(cl:defmethod altitude-val ((m <ReturnToLaunchCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:altitude-val is deprecated.  Use uav_msgs-msg:altitude instead.")
  (altitude m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <ReturnToLaunchCommand>) ostream)
  "Serializes a message object of type '<ReturnToLaunchCommand>"
  (cl:let ((bits (roslisp-utils:encode-double-float-bits (cl:slot-value msg 'altitude))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 32) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 40) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 48) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 56) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <ReturnToLaunchCommand>) istream)
  "Deserializes a message object of type '<ReturnToLaunchCommand>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 32) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 40) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 48) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 56) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'altitude) (roslisp-utils:decode-double-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<ReturnToLaunchCommand>)))
  "Returns string type for a message object of type '<ReturnToLaunchCommand>"
  "uav_msgs/ReturnToLaunchCommand")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'ReturnToLaunchCommand)))
  "Returns string type for a message object of type 'ReturnToLaunchCommand"
  "uav_msgs/ReturnToLaunchCommand")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<ReturnToLaunchCommand>)))
  "Returns md5sum for a message object of type '<ReturnToLaunchCommand>"
  "42af7eb0aaf91dc07d6880f800cabbb3")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'ReturnToLaunchCommand)))
  "Returns md5sum for a message object of type 'ReturnToLaunchCommand"
  "42af7eb0aaf91dc07d6880f800cabbb3")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<ReturnToLaunchCommand>)))
  "Returns full string definition for message of type '<ReturnToLaunchCommand>"
  (cl:format cl:nil "float64 altitude~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'ReturnToLaunchCommand)))
  "Returns full string definition for message of type 'ReturnToLaunchCommand"
  (cl:format cl:nil "float64 altitude~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <ReturnToLaunchCommand>))
  (cl:+ 0
     8
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <ReturnToLaunchCommand>))
  "Converts a ROS message object to a list"
  (cl:list 'ReturnToLaunchCommand
    (cl:cons ':altitude (altitude msg))
))
