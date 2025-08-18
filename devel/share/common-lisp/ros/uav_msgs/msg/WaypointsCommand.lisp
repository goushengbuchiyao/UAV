; Auto-generated. Do not edit!


(cl:in-package uav_msgs-msg)


;//! \htmlinclude WaypointsCommand.msg.html

(cl:defclass <WaypointsCommand> (roslisp-msg-protocol:ros-message)
  ((start_immediately
    :reader start_immediately
    :initarg :start_immediately
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

(cl:ensure-generic-function 'start_immediately-val :lambda-list '(m))
(cl:defmethod start_immediately-val ((m <WaypointsCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:start_immediately-val is deprecated.  Use uav_msgs-msg:start_immediately instead.")
  (start_immediately m))

(cl:ensure-generic-function 'waypoints-val :lambda-list '(m))
(cl:defmethod waypoints-val ((m <WaypointsCommand>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader uav_msgs-msg:waypoints-val is deprecated.  Use uav_msgs-msg:waypoints instead.")
  (waypoints m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <WaypointsCommand>) ostream)
  "Serializes a message object of type '<WaypointsCommand>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'start_immediately) 1 0)) ostream)
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
    (cl:setf (cl:slot-value msg 'start_immediately) (cl:not (cl:zerop (cl:read-byte istream))))
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
  "dca3761828b95042e94f1dee6fa350dd")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'WaypointsCommand)))
  "Returns md5sum for a message object of type 'WaypointsCommand"
  "dca3761828b95042e94f1dee6fa350dd")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<WaypointsCommand>)))
  "Returns full string definition for message of type '<WaypointsCommand>"
  (cl:format cl:nil "bool start_immediately     # 是否立即执行航点~%Waypoint[] waypoints       # 航点列表~%================================================================================~%MSG: uav_msgs/Waypoint~%int32 waypoint_id          # 航点ID~%string frame               # 坐标系类型~%string command             # 航点指令类型~%float64 latitude           # 纬度 (度)~%float64 longitude          # 经度 (度)~%float64 altitude           # 高度 (米)~%bool is_current            # 是否为当前航点~%bool autocontinue          # 是否自动继续到下一个航点~%float64 hold_time          # 悬停时间 (秒)~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'WaypointsCommand)))
  "Returns full string definition for message of type 'WaypointsCommand"
  (cl:format cl:nil "bool start_immediately     # 是否立即执行航点~%Waypoint[] waypoints       # 航点列表~%================================================================================~%MSG: uav_msgs/Waypoint~%int32 waypoint_id          # 航点ID~%string frame               # 坐标系类型~%string command             # 航点指令类型~%float64 latitude           # 纬度 (度)~%float64 longitude          # 经度 (度)~%float64 altitude           # 高度 (米)~%bool is_current            # 是否为当前航点~%bool autocontinue          # 是否自动继续到下一个航点~%float64 hold_time          # 悬停时间 (秒)~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <WaypointsCommand>))
  (cl:+ 0
     1
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'waypoints) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <WaypointsCommand>))
  "Converts a ROS message object to a list"
  (cl:list 'WaypointsCommand
    (cl:cons ':start_immediately (start_immediately msg))
    (cl:cons ':waypoints (waypoints msg))
))
