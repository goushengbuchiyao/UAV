; Auto-generated. Do not edit!


(cl:in-package px_uav_msgs-msg)


;//! \htmlinclude Target.msg.html

(cl:defclass <Target> (roslisp-msg-protocol:ros-message)
  ((cx
    :reader cx
    :initarg :cx
    :type cl:float
    :initform 0.0)
   (cy
    :reader cy
    :initarg :cy
    :type cl:float
    :initform 0.0)
   (w
    :reader w
    :initarg :w
    :type cl:float
    :initform 0.0)
   (h
    :reader h
    :initarg :h
    :type cl:float
    :initform 0.0)
   (score
    :reader score
    :initarg :score
    :type cl:float
    :initform 0.0)
   (category
    :reader category
    :initarg :category
    :type cl:string
    :initform "")
   (category_id
    :reader category_id
    :initarg :category_id
    :type cl:integer
    :initform 0)
   (tracked_id
    :reader tracked_id
    :initarg :tracked_id
    :type cl:integer
    :initform 0)
   (px
    :reader px
    :initarg :px
    :type cl:float
    :initform 0.0)
   (py
    :reader py
    :initarg :py
    :type cl:float
    :initform 0.0)
   (pz
    :reader pz
    :initarg :pz
    :type cl:float
    :initform 0.0)
   (los_ax
    :reader los_ax
    :initarg :los_ax
    :type cl:float
    :initform 0.0)
   (los_ay
    :reader los_ay
    :initarg :los_ay
    :type cl:float
    :initform 0.0)
   (yaw_a
    :reader yaw_a
    :initarg :yaw_a
    :type cl:float
    :initform 0.0)
   (mode
    :reader mode
    :initarg :mode
    :type cl:boolean
    :initform cl:nil)
   (sim_score
    :reader sim_score
    :initarg :sim_score
    :type cl:float
    :initform 0.0))
)

(cl:defclass Target (<Target>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <Target>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'Target)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name px_uav_msgs-msg:<Target> is deprecated: use px_uav_msgs-msg:Target instead.")))

(cl:ensure-generic-function 'cx-val :lambda-list '(m))
(cl:defmethod cx-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:cx-val is deprecated.  Use px_uav_msgs-msg:cx instead.")
  (cx m))

(cl:ensure-generic-function 'cy-val :lambda-list '(m))
(cl:defmethod cy-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:cy-val is deprecated.  Use px_uav_msgs-msg:cy instead.")
  (cy m))

(cl:ensure-generic-function 'w-val :lambda-list '(m))
(cl:defmethod w-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:w-val is deprecated.  Use px_uav_msgs-msg:w instead.")
  (w m))

(cl:ensure-generic-function 'h-val :lambda-list '(m))
(cl:defmethod h-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:h-val is deprecated.  Use px_uav_msgs-msg:h instead.")
  (h m))

(cl:ensure-generic-function 'score-val :lambda-list '(m))
(cl:defmethod score-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:score-val is deprecated.  Use px_uav_msgs-msg:score instead.")
  (score m))

(cl:ensure-generic-function 'category-val :lambda-list '(m))
(cl:defmethod category-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:category-val is deprecated.  Use px_uav_msgs-msg:category instead.")
  (category m))

(cl:ensure-generic-function 'category_id-val :lambda-list '(m))
(cl:defmethod category_id-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:category_id-val is deprecated.  Use px_uav_msgs-msg:category_id instead.")
  (category_id m))

(cl:ensure-generic-function 'tracked_id-val :lambda-list '(m))
(cl:defmethod tracked_id-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:tracked_id-val is deprecated.  Use px_uav_msgs-msg:tracked_id instead.")
  (tracked_id m))

(cl:ensure-generic-function 'px-val :lambda-list '(m))
(cl:defmethod px-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:px-val is deprecated.  Use px_uav_msgs-msg:px instead.")
  (px m))

(cl:ensure-generic-function 'py-val :lambda-list '(m))
(cl:defmethod py-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:py-val is deprecated.  Use px_uav_msgs-msg:py instead.")
  (py m))

(cl:ensure-generic-function 'pz-val :lambda-list '(m))
(cl:defmethod pz-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:pz-val is deprecated.  Use px_uav_msgs-msg:pz instead.")
  (pz m))

(cl:ensure-generic-function 'los_ax-val :lambda-list '(m))
(cl:defmethod los_ax-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:los_ax-val is deprecated.  Use px_uav_msgs-msg:los_ax instead.")
  (los_ax m))

(cl:ensure-generic-function 'los_ay-val :lambda-list '(m))
(cl:defmethod los_ay-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:los_ay-val is deprecated.  Use px_uav_msgs-msg:los_ay instead.")
  (los_ay m))

(cl:ensure-generic-function 'yaw_a-val :lambda-list '(m))
(cl:defmethod yaw_a-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:yaw_a-val is deprecated.  Use px_uav_msgs-msg:yaw_a instead.")
  (yaw_a m))

(cl:ensure-generic-function 'mode-val :lambda-list '(m))
(cl:defmethod mode-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:mode-val is deprecated.  Use px_uav_msgs-msg:mode instead.")
  (mode m))

(cl:ensure-generic-function 'sim_score-val :lambda-list '(m))
(cl:defmethod sim_score-val ((m <Target>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader px_uav_msgs-msg:sim_score-val is deprecated.  Use px_uav_msgs-msg:sim_score instead.")
  (sim_score m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <Target>) ostream)
  "Serializes a message object of type '<Target>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'cx))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'cy))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'w))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'h))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'score))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'category))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'category))
  (cl:let* ((signed (cl:slot-value msg 'category_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let* ((signed (cl:slot-value msg 'tracked_id)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 4294967296) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) unsigned) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) unsigned) ostream)
    )
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'px))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'py))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'pz))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'los_ax))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'los_ay))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'yaw_a))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'mode) 1 0)) ostream)
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'sim_score))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <Target>) istream)
  "Deserializes a message object of type '<Target>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'cx) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'cy) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'w) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'h) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'score) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'category) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'category) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'category_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) unsigned) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'tracked_id) (cl:if (cl:< unsigned 2147483648) unsigned (cl:- unsigned 4294967296))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'px) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'py) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'pz) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'los_ax) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'los_ay) (roslisp-utils:decode-single-float-bits bits)))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'yaw_a) (roslisp-utils:decode-single-float-bits bits)))
    (cl:setf (cl:slot-value msg 'mode) (cl:not (cl:zerop (cl:read-byte istream))))
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'sim_score) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<Target>)))
  "Returns string type for a message object of type '<Target>"
  "px_uav_msgs/Target")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'Target)))
  "Returns string type for a message object of type 'Target"
  "px_uav_msgs/Target")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<Target>)))
  "Returns md5sum for a message object of type '<Target>"
  "3623dd3b471832f212700e5baf3ce9ed")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'Target)))
  "Returns md5sum for a message object of type 'Target"
  "3623dd3b471832f212700e5baf3ce9ed")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<Target>)))
  "Returns full string definition for message of type '<Target>"
  (cl:format cl:nil "~%## 目标中心的水平位置 [0,1]~%float32 cx~%## 目标中心的垂直位置 [0,1]~%float32 cy~%~%## 目标宽度/图像宽度 [0,1]~%float32 w~%## 目标高度/图像高度 [0,1]~%float32 h~%~%## 目标置信度 [0,1]~%float32 score~%~%## 目标类别名称~%string category~%## 目标类别编号 从0开始计算~%int32 category_id~%~%## 目标跟踪ID号~%int32 tracked_id~%~%## 目标3D位置 单位：m~%float32 px~%float32 py~%float32 pz~%~%## 目标中心点的视线角度 [相机系下：右方x角度为正，下方y角度为正] 单位：度~%float32 los_ax~%float32 los_ay~%~%## 偏航角误差 [图像系下：垂直向上为0°，右半圈顺时针0~~180°，左半圈逆时针0~~-180°]~%float32 yaw_a~%~%## detection(false/0) or tracked(true/1)~%bool mode~%~%## CosineSimilarity~%float32 sim_score~%~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'Target)))
  "Returns full string definition for message of type 'Target"
  (cl:format cl:nil "~%## 目标中心的水平位置 [0,1]~%float32 cx~%## 目标中心的垂直位置 [0,1]~%float32 cy~%~%## 目标宽度/图像宽度 [0,1]~%float32 w~%## 目标高度/图像高度 [0,1]~%float32 h~%~%## 目标置信度 [0,1]~%float32 score~%~%## 目标类别名称~%string category~%## 目标类别编号 从0开始计算~%int32 category_id~%~%## 目标跟踪ID号~%int32 tracked_id~%~%## 目标3D位置 单位：m~%float32 px~%float32 py~%float32 pz~%~%## 目标中心点的视线角度 [相机系下：右方x角度为正，下方y角度为正] 单位：度~%float32 los_ax~%float32 los_ay~%~%## 偏航角误差 [图像系下：垂直向上为0°，右半圈顺时针0~~180°，左半圈逆时针0~~-180°]~%float32 yaw_a~%~%## detection(false/0) or tracked(true/1)~%bool mode~%~%## CosineSimilarity~%float32 sim_score~%~%~%~%~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <Target>))
  (cl:+ 0
     4
     4
     4
     4
     4
     4 (cl:length (cl:slot-value msg 'category))
     4
     4
     4
     4
     4
     4
     4
     4
     1
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <Target>))
  "Converts a ROS message object to a list"
  (cl:list 'Target
    (cl:cons ':cx (cx msg))
    (cl:cons ':cy (cy msg))
    (cl:cons ':w (w msg))
    (cl:cons ':h (h msg))
    (cl:cons ':score (score msg))
    (cl:cons ':category (category msg))
    (cl:cons ':category_id (category_id msg))
    (cl:cons ':tracked_id (tracked_id msg))
    (cl:cons ':px (px msg))
    (cl:cons ':py (py msg))
    (cl:cons ':pz (pz msg))
    (cl:cons ':los_ax (los_ax msg))
    (cl:cons ':los_ay (los_ay msg))
    (cl:cons ':yaw_a (yaw_a msg))
    (cl:cons ':mode (mode msg))
    (cl:cons ':sim_score (sim_score msg))
))
