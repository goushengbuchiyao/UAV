;; Auto-generated. Do not edit!


(when (boundp 'uav_msgs::WaypointsCommand)
  (if (not (find-package "UAV_MSGS"))
    (make-package "UAV_MSGS"))
  (shadow 'WaypointsCommand (find-package "UAV_MSGS")))
(unless (find-package "UAV_MSGS::WAYPOINTSCOMMAND")
  (make-package "UAV_MSGS::WAYPOINTSCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude WaypointsCommand.msg.html


(defclass uav_msgs::WaypointsCommand
  :super ros::object
  :slots (_start_immediately _waypoints ))

(defmethod uav_msgs::WaypointsCommand
  (:init
   (&key
    ((:start_immediately __start_immediately) nil)
    ((:waypoints __waypoints) ())
    )
   (send-super :init)
   (setq _start_immediately __start_immediately)
   (setq _waypoints __waypoints)
   self)
  (:start_immediately
   (&optional (__start_immediately :null))
   (if (not (eq __start_immediately :null)) (setq _start_immediately __start_immediately)) _start_immediately)
  (:waypoints
   (&rest __waypoints)
   (if (keywordp (car __waypoints))
       (send* _waypoints __waypoints)
     (progn
       (if __waypoints (setq _waypoints (car __waypoints)))
       _waypoints)))
  (:serialization-length
   ()
   (+
    ;; bool _start_immediately
    1
    ;; uav_msgs/Waypoint[] _waypoints
    (apply #'+ (send-all _waypoints :serialization-length)) 4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; bool _start_immediately
       (if _start_immediately (write-byte -1 s) (write-byte 0 s))
     ;; uav_msgs/Waypoint[] _waypoints
     (write-long (length _waypoints) s)
     (dolist (elem _waypoints)
       (send elem :serialize s)
       )
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; bool _start_immediately
     (setq _start_immediately (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uav_msgs/Waypoint[] _waypoints
   (let (n)
     (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4)
     (setq _waypoints (let (r) (dotimes (i n) (push (instance uav_msgs::Waypoint :init) r)) r))
     (dolist (elem- _waypoints)
     (send elem- :deserialize buf ptr-) (incf ptr- (send elem- :serialization-length))
     ))
   ;;
   self)
  )

(setf (get uav_msgs::WaypointsCommand :md5sum-) "dca3761828b95042e94f1dee6fa350dd")
(setf (get uav_msgs::WaypointsCommand :datatype-) "uav_msgs/WaypointsCommand")
(setf (get uav_msgs::WaypointsCommand :definition-)
      "bool start_immediately     # 是否立即执行航点
Waypoint[] waypoints       # 航点列表
================================================================================
MSG: uav_msgs/Waypoint
int32 waypoint_id          # 航点ID
string frame               # 坐标系类型
string command             # 航点指令类型
float64 latitude           # 纬度 (度)
float64 longitude          # 经度 (度)
float64 altitude           # 高度 (米)
bool is_current            # 是否为当前航点
bool autocontinue          # 是否自动继续到下一个航点
float64 hold_time          # 悬停时间 (秒)
")



(provide :uav_msgs/WaypointsCommand "dca3761828b95042e94f1dee6fa350dd")


