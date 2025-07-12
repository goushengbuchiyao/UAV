;; Auto-generated. Do not edit!


(when (boundp 'px_uav_msgs::TargetsInFrame)
  (if (not (find-package "PX_UAV_MSGS"))
    (make-package "PX_UAV_MSGS"))
  (shadow 'TargetsInFrame (find-package "PX_UAV_MSGS")))
(unless (find-package "PX_UAV_MSGS::TARGETSINFRAME")
  (make-package "PX_UAV_MSGS::TARGETSINFRAME"))

(in-package "ROS")
;;//! \htmlinclude TargetsInFrame.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(defclass px_uav_msgs::TargetsInFrame
  :super ros::object
  :slots (_header _frame_id _height _width _fps _fov_x _fov_y _targets _rois _no_track_frame_count _tracking_state ))

(defmethod px_uav_msgs::TargetsInFrame
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:frame_id __frame_id) 0)
    ((:height __height) 0)
    ((:width __width) 0)
    ((:fps __fps) 0.0)
    ((:fov_x __fov_x) 0.0)
    ((:fov_y __fov_y) 0.0)
    ((:targets __targets) ())
    ((:rois __rois) ())
    ((:no_track_frame_count __no_track_frame_count) 0)
    ((:tracking_state __tracking_state) nil)
    )
   (send-super :init)
   (setq _header __header)
   (setq _frame_id (round __frame_id))
   (setq _height (round __height))
   (setq _width (round __width))
   (setq _fps (float __fps))
   (setq _fov_x (float __fov_x))
   (setq _fov_y (float __fov_y))
   (setq _targets __targets)
   (setq _rois __rois)
   (setq _no_track_frame_count (round __no_track_frame_count))
   (setq _tracking_state __tracking_state)
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:frame_id
   (&optional __frame_id)
   (if __frame_id (setq _frame_id __frame_id)) _frame_id)
  (:height
   (&optional __height)
   (if __height (setq _height __height)) _height)
  (:width
   (&optional __width)
   (if __width (setq _width __width)) _width)
  (:fps
   (&optional __fps)
   (if __fps (setq _fps __fps)) _fps)
  (:fov_x
   (&optional __fov_x)
   (if __fov_x (setq _fov_x __fov_x)) _fov_x)
  (:fov_y
   (&optional __fov_y)
   (if __fov_y (setq _fov_y __fov_y)) _fov_y)
  (:targets
   (&rest __targets)
   (if (keywordp (car __targets))
       (send* _targets __targets)
     (progn
       (if __targets (setq _targets (car __targets)))
       _targets)))
  (:rois
   (&rest __rois)
   (if (keywordp (car __rois))
       (send* _rois __rois)
     (progn
       (if __rois (setq _rois (car __rois)))
       _rois)))
  (:no_track_frame_count
   (&optional __no_track_frame_count)
   (if __no_track_frame_count (setq _no_track_frame_count __no_track_frame_count)) _no_track_frame_count)
  (:tracking_state
   (&optional (__tracking_state :null))
   (if (not (eq __tracking_state :null)) (setq _tracking_state __tracking_state)) _tracking_state)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; int32 _frame_id
    4
    ;; int32 _height
    4
    ;; int32 _width
    4
    ;; float32 _fps
    4
    ;; float32 _fov_x
    4
    ;; float32 _fov_y
    4
    ;; px_uav_msgs/Target[] _targets
    (apply #'+ (send-all _targets :serialization-length)) 4
    ;; px_uav_msgs/ROI[] _rois
    (apply #'+ (send-all _rois :serialization-length)) 4
    ;; int32 _no_track_frame_count
    4
    ;; bool _tracking_state
    1
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; int32 _frame_id
       (write-long _frame_id s)
     ;; int32 _height
       (write-long _height s)
     ;; int32 _width
       (write-long _width s)
     ;; float32 _fps
       (sys::poke _fps (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _fov_x
       (sys::poke _fov_x (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _fov_y
       (sys::poke _fov_y (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; px_uav_msgs/Target[] _targets
     (write-long (length _targets) s)
     (dolist (elem _targets)
       (send elem :serialize s)
       )
     ;; px_uav_msgs/ROI[] _rois
     (write-long (length _rois) s)
     (dolist (elem _rois)
       (send elem :serialize s)
       )
     ;; int32 _no_track_frame_count
       (write-long _no_track_frame_count s)
     ;; bool _tracking_state
       (if _tracking_state (write-byte -1 s) (write-byte 0 s))
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; int32 _frame_id
     (setq _frame_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _height
     (setq _height (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _width
     (setq _width (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _fps
     (setq _fps (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _fov_x
     (setq _fov_x (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _fov_y
     (setq _fov_y (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; px_uav_msgs/Target[] _targets
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _targets (let (r) (dotimes (i n) (push (instance px_uav_msgs::Target :init) r)) r))
     (dolist (elem- _targets)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; px_uav_msgs/ROI[] _rois
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _rois (let (r) (dotimes (i n) (push (instance px_uav_msgs::ROI :init) r)) r))
     (dolist (elem- _rois)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;; int32 _no_track_frame_count
     (setq _no_track_frame_count (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; bool _tracking_state
     (setq _tracking_state (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;;
   self)
  )

(setf (get px_uav_msgs::TargetsInFrame :md5sum-) "50723d8130f9d56db1f6a8f8b5c9622c")
(setf (get px_uav_msgs::TargetsInFrame :datatype-) "px_uav_msgs/TargetsInFrame")
(setf (get px_uav_msgs::TargetsInFrame :definition-)
      "## ROS Header
std_msgs/Header header

## 帧ID号
int32 frame_id

## 帧像素高度
int32 height
## 帧像素宽度
int32 width

## 当前检测/跟踪频率
float32 fps

## 当前成像设备的水平视场角，单位：度
float32 fov_x
## 当前成像设备的垂直视场角，单位：度
float32 fov_y

## 当前帧每个目标信息
Target[] targets

## 当前检测的兴趣区域，ROIs
ROI[] rois

##focusing solely on tracking , without considering detection
int32 no_track_frame_count

## 是否处于跟踪状态，0：否，1：是。当状态为1，targets为空表示丢失；targets不为空表示正常跟踪。
bool tracking_state

================================================================================
MSG: std_msgs/Header
# Standard metadata for higher-level stamped data types.
# This is generally used to communicate timestamped data 
# in a particular coordinate frame.
# 
# sequence ID: consecutively increasing ID 
uint32 seq
#Two-integer timestamp that is expressed as:
# * stamp.sec: seconds (stamp_secs) since epoch (in Python the variable is called 'secs')
# * stamp.nsec: nanoseconds since stamp_secs (in Python the variable is called 'nsecs')
# time-handling sugar is provided by the client library
time stamp
#Frame this data is associated with
string frame_id

================================================================================
MSG: px_uav_msgs/Target

## 目标中心的水平位置 [0,1]
float32 cx
## 目标中心的垂直位置 [0,1]
float32 cy

## 目标宽度/图像宽度 [0,1]
float32 w
## 目标高度/图像高度 [0,1]
float32 h

## 目标置信度 [0,1]
float32 score

## 目标类别名称
string category
## 目标类别编号 从0开始计算
int32 category_id

## 目标跟踪ID号
int32 tracked_id

## 目标3D位置 单位：m
float32 px
float32 py
float32 pz

## 目标中心点的视线角度 [相机系下：右方x角度为正，下方y角度为正] 单位：度
float32 los_ax
float32 los_ay

## 偏航角误差 [图像系下：垂直向上为0°，右半圈顺时针0~180°，左半圈逆时针0~-180°]
float32 yaw_a

## detection(false/0) or tracked(true/1)
bool mode

## CosineSimilarity
float32 sim_score





================================================================================
MSG: px_uav_msgs/ROI

## 区域左上角像素坐标
int32 x1
int32 y1

## 区域右下角像素坐标
int32 x2
int32 y2

")



(provide :px_uav_msgs/TargetsInFrame "50723d8130f9d56db1f6a8f8b5c9622c")


