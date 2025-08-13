;; Auto-generated. Do not edit!


(when (boundp 'px_uav_msgs::TextInfo)
  (if (not (find-package "PX_UAV_MSGS"))
    (make-package "PX_UAV_MSGS"))
  (shadow 'TextInfo (find-package "PX_UAV_MSGS")))
(unless (find-package "PX_UAV_MSGS::TEXTINFO")
  (make-package "PX_UAV_MSGS::TEXTINFO"))

(in-package "ROS")
;;//! \htmlinclude TextInfo.msg.html
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*INFO*" (find-package "PX_UAV_MSGS::TEXTINFO"))
(shadow '*INFO* (find-package "PX_UAV_MSGS::TEXTINFO"))
(defconstant px_uav_msgs::TextInfo::*INFO* 0)
(intern "*WARN*" (find-package "PX_UAV_MSGS::TEXTINFO"))
(shadow '*WARN* (find-package "PX_UAV_MSGS::TEXTINFO"))
(defconstant px_uav_msgs::TextInfo::*WARN* 1)
(intern "*ERROR*" (find-package "PX_UAV_MSGS::TEXTINFO"))
(shadow '*ERROR* (find-package "PX_UAV_MSGS::TEXTINFO"))
(defconstant px_uav_msgs::TextInfo::*ERROR* 2)
(intern "*FATAL*" (find-package "PX_UAV_MSGS::TEXTINFO"))
(shadow '*FATAL* (find-package "PX_UAV_MSGS::TEXTINFO"))
(defconstant px_uav_msgs::TextInfo::*FATAL* 3)

(defun px_uav_msgs::TextInfo-to-symbol (const)
  (cond
        ((= const 0) 'px_uav_msgs::TextInfo::*INFO*)
        ((= const 1) 'px_uav_msgs::TextInfo::*WARN*)
        ((= const 2) 'px_uav_msgs::TextInfo::*ERROR*)
        ((= const 3) 'px_uav_msgs::TextInfo::*FATAL*)
        (t nil)))

(defclass px_uav_msgs::TextInfo
  :super ros::object
  :slots (_header _MessageType _Message ))

(defmethod px_uav_msgs::TextInfo
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:MessageType __MessageType) 0)
    ((:Message __Message) "")
    )
   (send-super :init)
   (setq _header __header)
   (setq _MessageType (round __MessageType))
   (setq _Message (string __Message))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:MessageType
   (&optional __MessageType)
   (if __MessageType (setq _MessageType __MessageType)) _MessageType)
  (:Message
   (&optional __Message)
   (if __Message (setq _Message __Message)) _Message)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _MessageType
    1
    ;; string _Message
    4 (length _Message)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _MessageType
       (write-byte _MessageType s)
     ;; string _Message
       (write-long (length _Message) s) (princ _Message s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _MessageType
     (setq _MessageType (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; string _Message
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _Message (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get px_uav_msgs::TextInfo :md5sum-) "1c060392f27880babe5cdc68bd502409")
(setf (get px_uav_msgs::TextInfo :datatype-) "px_uav_msgs/TextInfo")
(setf (get px_uav_msgs::TextInfo :definition-)
      "#INFO:正常运行状况下反馈给地面站的信息,例如程序正常启动,状态切换的提示信息等.
uint8 INFO=0
#WARN:无人机或软件程序出现意外情况,依然能正常启动或继续执行任务,小概率会出现危险状况,例如无人机RTK无法维持退出到GPS,视觉跟踪目标突然丢失重新搜寻目标等.
uint8 WARN=1
#ERROR:无人机或软件程序出现重大意外情况,无法正常启动或继续执行任务,极有可能会出现危险状况,需要中断任务以及人为接管控制无人机,例如通信中断,无人机定位发散,ROS节点无法正常启动等.
uint8 ERROR=2
#FATAL:任务执行过程中,软件崩溃或无人机飞控崩溃导致无人机完全失控,需要迅速人为接管控制无人机降落减少炸机损失.
uint8 FATAL=3

std_msgs/Header header
uint8 MessageType
string Message
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

")



(provide :px_uav_msgs/TextInfo "1c060392f27880babe5cdc68bd502409")


