;; Auto-generated. Do not edit!


(when (boundp 'uav_msgs::Waypoint)
  (if (not (find-package "UAV_MSGS"))
    (make-package "UAV_MSGS"))
  (shadow 'Waypoint (find-package "UAV_MSGS")))
(unless (find-package "UAV_MSGS::WAYPOINT")
  (make-package "UAV_MSGS::WAYPOINT"))

(in-package "ROS")
;;//! \htmlinclude Waypoint.msg.html


(defclass uav_msgs::Waypoint
  :super ros::object
  :slots (_waypoint_id _frame _command _latitude _longitude _altitude _is_current _autocontinue _hold_time ))

(defmethod uav_msgs::Waypoint
  (:init
   (&key
    ((:waypoint_id __waypoint_id) 0)
    ((:frame __frame) "")
    ((:command __command) "")
    ((:latitude __latitude) 0.0)
    ((:longitude __longitude) 0.0)
    ((:altitude __altitude) 0.0)
    ((:is_current __is_current) nil)
    ((:autocontinue __autocontinue) nil)
    ((:hold_time __hold_time) 0.0)
    )
   (send-super :init)
   (setq _waypoint_id (round __waypoint_id))
   (setq _frame (string __frame))
   (setq _command (string __command))
   (setq _latitude (float __latitude))
   (setq _longitude (float __longitude))
   (setq _altitude (float __altitude))
   (setq _is_current __is_current)
   (setq _autocontinue __autocontinue)
   (setq _hold_time (float __hold_time))
   self)
  (:waypoint_id
   (&optional __waypoint_id)
   (if __waypoint_id (setq _waypoint_id __waypoint_id)) _waypoint_id)
  (:frame
   (&optional __frame)
   (if __frame (setq _frame __frame)) _frame)
  (:command
   (&optional __command)
   (if __command (setq _command __command)) _command)
  (:latitude
   (&optional __latitude)
   (if __latitude (setq _latitude __latitude)) _latitude)
  (:longitude
   (&optional __longitude)
   (if __longitude (setq _longitude __longitude)) _longitude)
  (:altitude
   (&optional __altitude)
   (if __altitude (setq _altitude __altitude)) _altitude)
  (:is_current
   (&optional (__is_current :null))
   (if (not (eq __is_current :null)) (setq _is_current __is_current)) _is_current)
  (:autocontinue
   (&optional (__autocontinue :null))
   (if (not (eq __autocontinue :null)) (setq _autocontinue __autocontinue)) _autocontinue)
  (:hold_time
   (&optional __hold_time)
   (if __hold_time (setq _hold_time __hold_time)) _hold_time)
  (:serialization-length
   ()
   (+
    ;; int32 _waypoint_id
    4
    ;; string _frame
    4 (length _frame)
    ;; string _command
    4 (length _command)
    ;; float64 _latitude
    8
    ;; float64 _longitude
    8
    ;; float64 _altitude
    8
    ;; bool _is_current
    1
    ;; bool _autocontinue
    1
    ;; float64 _hold_time
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; int32 _waypoint_id
       (write-long _waypoint_id s)
     ;; string _frame
       (write-long (length _frame) s) (princ _frame s)
     ;; string _command
       (write-long (length _command) s) (princ _command s)
     ;; float64 _latitude
       (sys::poke _latitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _longitude
       (sys::poke _longitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _altitude
       (sys::poke _altitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; bool _is_current
       (if _is_current (write-byte -1 s) (write-byte 0 s))
     ;; bool _autocontinue
       (if _autocontinue (write-byte -1 s) (write-byte 0 s))
     ;; float64 _hold_time
       (sys::poke _hold_time (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; int32 _waypoint_id
     (setq _waypoint_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; string _frame
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _frame (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; string _command
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _command (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; float64 _latitude
     (setq _latitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _longitude
     (setq _longitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _altitude
     (setq _altitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; bool _is_current
     (setq _is_current (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _autocontinue
     (setq _autocontinue (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float64 _hold_time
     (setq _hold_time (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get uav_msgs::Waypoint :md5sum-) "d3f2cf73442657b7c4a745798b838c76")
(setf (get uav_msgs::Waypoint :datatype-) "uav_msgs/Waypoint")
(setf (get uav_msgs::Waypoint :definition-)
      "int32 waypoint_id          # 航点ID
string frame               # 坐标系类型
string command             # 航点指令类型
float64 latitude           # 纬度 (度)
float64 longitude          # 经度 (度)
float64 altitude           # 高度 (米)
bool is_current            # 是否为当前航点
bool autocontinue          # 是否自动继续到下一个航点
float64 hold_time          # 悬停时间 (秒)
")



(provide :uav_msgs/Waypoint "d3f2cf73442657b7c4a745798b838c76")


