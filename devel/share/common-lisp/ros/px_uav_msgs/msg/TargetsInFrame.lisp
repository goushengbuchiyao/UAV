; Auto-generated. Do not edit!


(cl:in-package px_uav_msgs-msg)


;//! \htmlinclude TargetsInFrame.msg.html

(cl:defclass <TargetsInFrame> (roslisp-msg-protocol:ros-message)
  ((header
    :reader header
    :initarg :header
    :type std_msgs-msg:Header
    :initform (cl:make-instance 'std_msgs-msg:Header))
   (frame_id
    :reader frame_id
    :initarg :frame_id
    :type cl:integer
    :initform 0)
   (height
    :reader height
    :initarg :height
    :type cl:integer
    :initform 0)
   (width
    :reader width
    :initarg :width
    :type cl:integer
    :initform 0)
   (fps
    :reader fps
    :initarg :fps
    :type cl:float
    :initform 0.0)
   (fov_x
    :reader fov_x
    :initarg :fov_x
    :type cl:float
    :initform 0.0)
   (fov_y
    :reader fov_y
    :initarg :fov_y
    :type cl:float
    :initform 0.0)
   (targets
    :reader targets
    :initarg :targets
    :type (cl:vector px_uav_msgs-msg:Target)
   :initform (cl:make-array 0 :element-type 'px_uav_msgs-msg:Target :initial-element (cl:make-instance 'px_uav_msgs-msg:Target)))
   (rois
    :reader rois
    :initarg :rois
    :type (cl:vector px_uav_msgs-msg:ROI)
   :initform (cl:make-array 0 :element-type 'px_uav_msgs-msg:ROI :initial-element (cl:make-instance 'px_uav_msgs-msg:ROI)))
   (no_track_frame_count
    :reader no_track_frame_count
    :initarg :no_track_frame_count
    :type cl:integer
    :initform 0)
   (tracking_state
    :reader tracking_state
    :initarg :tracking_state
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass TargetsInFrame (<TargetsInFrame>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <TargetsInFrame>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'TargetsInFrame)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name px_uav_msgs-msg:<TargetsInFrame> is deprecated: use px_uav_msgs-msg:TargetsInFrame instead.")))

(cl:ensure-generic-function 'header-val :lambda-list '(m))
(cl:defmethod header-val ((m <TargetsInFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:header-val is deprecated.  Use px_uav_msgs-msg:header instead.")
  (header m))

(cl:ensure-generic-function 'frame_id-val :lambda-list '(m))
(cl:defmethod frame_id-val ((m <TargetsInFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:frame_id-val is deprecated.  Use px_uav_msgs-msg:frame_id instead.")
  (frame_id m))

(cl:ensure-generic-function 'height-val :lambda-list '(m))
(cl:defmethod height-val ((m <TargetsInFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:height-val is deprecated.  Use px_uav_msgs-msg:height instead.")
  (height m))

(cl:ensure-generic-function 'width-val :lambda-list '(m))
(cl:defmethod width-val ((m <TargetsInFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:width-val is deprecated.  Use px_uav_msgs-msg:width instead.")
  (width m))

(cl:ensure-generic-function 'fps-val :lambda-list '(m))
(cl:defmethod fps-val ((m <TargetsInFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:fps-val is deprecated.  Use px_uav_msgs-msg:fps instead.")
  (fps m))

(cl:ensure-generic-function 'fov_x-val :lambda-list '(m))
(cl:defmethod fov_x-val ((m <TargetsInFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:fov_x-val is deprecated.  Use px_uav_msgs-msg:fov_x instead.")
  (fov_x m))

(cl:ensure-generic-function 'fov_y-val :lambda-list '(m))
(cl:defmethod fov_y-val ((m <TargetsInFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:fov_y-val is deprecated.  Use px_uav_msgs-msg:fov_y instead.")
  (fov_y m))

(cl:ensure-generic-function 'targets-val :lambda-list '(m))
(cl:defmethod targets-val ((m <TargetsInFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:targets-val is deprecated.  Use px_uav_msgs-msg:targets instead.")
  (targets m))

(cl:ensure-generic-function 'rois-val :lambda-list '(m))
(cl:defmethod rois-val ((m <TargetsInFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:rois-val is deprecated.  Use px_uav_msgs-msg:rois instead.")
  (rois m))

(cl:ensure-generic-function 'no_track_frame_count-val :lambda-list '(m))
(cl:defmethod no_track_frame_count-val ((m <TargetsInFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:no_track_frame_count-val is deprecated.  Use px_uav_msgs-msg:no_track_frame_count instead.")
  (no_track_frame_count m))

(cl:ensure-generic-function 'tracking_state-val :lambda-list '(m))
(cl:defmethod tracking_state-val ((m <TargetsInFrame>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:tracking_state-val is deprecated.  Use px_uav_msgs-msg:tracking_state instead.")
  (tracking_state m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <TargetsInFrame>) ostream)
  "Serializes a message object of type '<TargetsInFrame>"
  (roslisp-msg-protocol:serialize (cl:slot-value msg 'header) ostream)
  (cl:let* ((signed (cl:slot-value msg 'frame_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'height)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'width)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'fps))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'fov_x))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'fov_y))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'targets))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'targets))
  (cl:let ((__ros_arr_len (cl:length (cl:slot-value msg 'rois))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_arr_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_arr_len) ostream))
  (cl:map cl:nil #'(cl:lambda (ele) (roslisp-msg-protocol:serialize ele ostream))
   (cl:slot-value msg 'rois))
  (cl:let* ((signed (cl:slot-value msg 'no_track_frame_count)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'tracking_state) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <TargetsInFrame>) istream)
  "Deserializes a message object of type '<TargetsInFrame>"
  (roslisp-msg-protocol:deserialize (cl:slot-value msg 'header) istream)
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'frame_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'height) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'width) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fps) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fov_x) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fov_y) (roslisp-utils:decode-single-float-bits bits)))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'targets) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'targets)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'px_uav_msgs-msg:Target))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
  (cl:let ((__ros_arr_len 0))
    (cl:setf (cl:ldb (cl:byte 8 0) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 16) __ros_arr_len) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 24) __ros_arr_len) (cl:read-byte istream))
  (cl:setf (cl:slot-value msg 'rois) (cl:make-array __ros_arr_len))
  (cl:let ((vals (cl:slot-value msg 'rois)))
    (cl:dotimes (i __ros_arr_len)
    (cl:setf (cl:aref vals i) (cl:make-instance 'px_uav_msgs-msg:ROI))
  (roslisp-msg-protocol:deserialize (cl:aref vals i) istream))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'no_track_frame_count) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:setf (cl:slot-value msg 'tracking_state) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<TargetsInFrame>)))
  "Returns string type for a message object of type '<TargetsInFrame>"
  "px_uav_msgs/TargetsInFrame")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'TargetsInFrame)))
  "Returns string type for a message object of type 'TargetsInFrame"
  "px_uav_msgs/TargetsInFrame")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<TargetsInFrame>)))
  "Returns md5sum for a message object of type '<TargetsInFrame>"
  "50723d8130f9d56db1f6a8f8b5c9622c")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'TargetsInFrame)))
  "Returns md5sum for a message object of type 'TargetsInFrame"
  "50723d8130f9d56db1f6a8f8b5c9622c")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<TargetsInFrame>)))
  "Returns full string definition for message of type '<TargetsInFrame>"
  (cl:format cl:nil "## ROS Header~%std_msgs/Header header~%~%## 帧ID号~%int32 frame_id~%~%## 帧像素高度~%int32 height~%## 帧像素宽度~%int32 width~%~%## 当前检测/跟踪频率~%float32 fps~%~%## 当前成像设备的水平视场角，单位：度~%float32 fov_x~%## 当前成像设备的垂直视场角，单位：度~%float32 fov_y~%~%## 当前帧每个目标信息~%Target[] targets~%~%## 当前检测的兴趣区域，ROIs~%ROI[] rois~%~%##focusing solely on tracking , without considering detection~%int32 no_track_frame_count~%~%## 是否处于跟踪状态，0：否，1：是。当状态为1，targets为空表示丢失；targets不为空表示正常跟踪。~%bool tracking_state~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: px_uav_msgs/Target~%~%## 目标中心的水平位置 [0,1]~%float32 cx~%## 目标中心的垂直位置 [0,1]~%float32 cy~%~%## 目标宽度/图像宽度 [0,1]~%float32 w~%## 目标高度/图像高度 [0,1]~%float32 h~%~%## 目标置信度 [0,1]~%float32 score~%~%## 目标类别名称~%string category~%## 目标类别编号 从0开始计算~%int32 category_id~%~%## 目标跟踪ID号~%int32 tracked_id~%~%## 目标3D位置 单位：m~%float32 px~%float32 py~%float32 pz~%~%## 目标中心点的视线角度 [相机系下：右方x角度为正，下方y角度为正] 单位：度~%float32 los_ax~%float32 los_ay~%~%## 偏航角误差 [图像系下：垂直向上为0°，右半圈顺时针0~~180°，左半圈逆时针0~~-180°]~%float32 yaw_a~%~%## detection(false/0) or tracked(true/1)~%bool mode~%~%## CosineSimilarity~%float32 sim_score~%~%~%~%~%~%================================================================================~%MSG: px_uav_msgs/ROI~%~%## 区域左上角像素坐标~%int32 x1~%int32 y1~%~%## 区域右下角像素坐标~%int32 x2~%int32 y2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'TargetsInFrame)))
  "Returns full string definition for message of type 'TargetsInFrame"
  (cl:format cl:nil "## ROS Header~%std_msgs/Header header~%~%## 帧ID号~%int32 frame_id~%~%## 帧像素高度~%int32 height~%## 帧像素宽度~%int32 width~%~%## 当前检测/跟踪频率~%float32 fps~%~%## 当前成像设备的水平视场角，单位：度~%float32 fov_x~%## 当前成像设备的垂直视场角，单位：度~%float32 fov_y~%~%## 当前帧每个目标信息~%Target[] targets~%~%## 当前检测的兴趣区域，ROIs~%ROI[] rois~%~%##focusing solely on tracking , without considering detection~%int32 no_track_frame_count~%~%## 是否处于跟踪状态，0：否，1：是。当状态为1，targets为空表示丢失；targets不为空表示正常跟踪。~%bool tracking_state~%~%================================================================================~%MSG: std_msgs/Header~%# Standard metadata for higher-level stamped data types.~%# This is generally used to communicate timestamped data ~%# in a particular coordinate frame.~%# ~%# sequence ID: consecutively increasing ID ~%uint32 seq~%#Two-integer timestamp that is expressed as:~%# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')~%# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')~%# time-handling sugar is provided by the client library~%time stamp~%#Frame this data is associated with~%string frame_id~%~%================================================================================~%MSG: px_uav_msgs/Target~%~%## 目标中心的水平位置 [0,1]~%float32 cx~%## 目标中心的垂直位置 [0,1]~%float32 cy~%~%## 目标宽度/图像宽度 [0,1]~%float32 w~%## 目标高度/图像高度 [0,1]~%float32 h~%~%## 目标置信度 [0,1]~%float32 score~%~%## 目标类别名称~%string category~%## 目标类别编号 从0开始计算~%int32 category_id~%~%## 目标跟踪ID号~%int32 tracked_id~%~%## 目标3D位置 单位：m~%float32 px~%float32 py~%float32 pz~%~%## 目标中心点的视线角度 [相机系下：右方x角度为正，下方y角度为正] 单位：度~%float32 los_ax~%float32 los_ay~%~%## 偏航角误差 [图像系下：垂直向上为0°，右半圈顺时针0~~180°，左半圈逆时针0~~-180°]~%float32 yaw_a~%~%## detection(false/0) or tracked(true/1)~%bool mode~%~%## CosineSimilarity~%float32 sim_score~%~%~%~%~%~%================================================================================~%MSG: px_uav_msgs/ROI~%~%## 区域左上角像素坐标~%int32 x1~%int32 y1~%~%## 区域右下角像素坐标~%int32 x2~%int32 y2~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <TargetsInFrame>))
  (cl:+ 0
     (roslisp-msg-protocol:serialization-length (cl:slot-value msg 'header))
     4
     4
     4
     4
     4
     4
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'targets) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4 (cl:reduce #'cl:+ (cl:slot-value msg 'rois) :key #'(cl:lambda (ele) (cl:declare (cl:ignorable ele)) (cl:+ (roslisp-msg-protocol:serialization-length ele))))
     4
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <TargetsInFrame>))
  "Converts a ROS message object to a list"
  (cl:list 'TargetsInFrame
    (cl:cons ':header (header msg))
    (cl:cons ':frame_id (frame_id msg))
    (cl:cons ':height (height msg))
    (cl:cons ':width (width msg))
    (cl:cons ':fps (fps msg))
    (cl:cons ':fov_x (fov_x msg))
    (cl:cons ':fov_y (fov_y msg))
    (cl:cons ':targets (targets msg))
    (cl:cons ':rois (rois msg))
    (cl:cons ':no_track_frame_count (no_track_frame_count msg))
    (cl:cons ':tracking_state (tracking_state msg))
))
