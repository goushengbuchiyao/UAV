; Auto-generated. Do not edit!


(cl:in-package uav_msgs-msg)


;//! \htmlinclude HoverCommand.msg.html

(cl:defclass <HoverCommand> (roslisp-msg-protocol:ros-message)
  ((mode
    :reader mode
    :initarg :mode
    :type cl:string
    :initform ""))
)

(cl:defclass HoverCommand (<HoverCommand>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <HoverCommand>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'HoverCommand)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name uav_msgs-msg:<HoverCommand> is deprecated: use uav_msgs-msg:HoverCommand instead.")))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <HoverCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:mode-val is deprecated.  Use uav_msgs-msg:mode instead.")
  (mode m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <HoverCommand>) ostream)
  "Serializes a message object of type '<HoverCommand>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'mode))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'mode))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <HoverCommand>) istream)
  "Deserializes a message object of type '<HoverCommand>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'mode) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'mode) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<HoverCommand>)))
  "Returns string type for a message object of type '<HoverCommand>"
  "uav_msgs/HoverCommand")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'HoverCommand)))
  "Returns string type for a message object of type 'HoverCommand"
  "uav_msgs/HoverCommand")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<HoverCommand>)))
  "Returns md5sum for a message object of type '<HoverCommand>"
  "e84dc3ad5dc323bb64f0aca01c2d1eef")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'HoverCommand)))
  "Returns md5sum for a message object of type 'HoverCommand"
  "e84dc3ad5dc323bb64f0aca01c2d1eef")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<HoverCommand>)))
  "Returns full string definition for message of type '<HoverCommand>"
  (cl:format cl:nil "string mode~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'HoverCommand)))
  "Returns full string definition for message of type 'HoverCommand"
  (cl:format cl:nil "string mode~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <HoverCommand>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'mode))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <HoverCommand>))
  "Converts a ROS message object to a list"
  (cl:list 'HoverCommand
    (cl:cons ':mode (mode msg))
))
