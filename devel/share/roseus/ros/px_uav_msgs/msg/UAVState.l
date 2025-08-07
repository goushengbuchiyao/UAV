;; Auto-generated. Do not edit!


(when (boundp 'px_uav_msgs::UAVState)
  (if (not (find-package "PX_UAV_MSGS"))
    (make-package "PX_UAV_MSGS"))
  (shadow 'UAVState (find-package "PX_UAV_MSGS")))
(unless (find-package "PX_UAV_MSGS::UAVSTATE")
  (make-package "PX_UAV_MSGS::UAVSTATE"))

(in-package "ROS")
;;//! \htmlinclude UAVState.msg.html
(if (not (find-package "GEOMETRY_MSGS"))
  (ros::roseus-add-msgs "geometry_msgs"))
(if (not (find-package "STD_MSGS"))
  (ros::roseus-add-msgs "std_msgs"))


(intern "*MOCAP*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*MOCAP* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*MOCAP* 0)
(intern "*T265*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*T265* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*T265* 1)
(intern "*GAZEBO*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*GAZEBO* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*GAZEBO* 2)
(intern "*FAKE_ODOM*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*FAKE_ODOM* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*FAKE_ODOM* 3)
(intern "*GPS*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*GPS* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*GPS* 4)
(intern "*RTK*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*RTK* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*RTK* 5)
(intern "*UWB*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*UWB* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*UWB* 6)
(intern "*VINS*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*VINS* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*VINS* 7)
(intern "*OPTICAL_FLOW*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*OPTICAL_FLOW* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*OPTICAL_FLOW* 8)
(intern "*VIOBOT*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*VIOBOT* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*VIOBOT* 9)
(intern "*MID360*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*MID360* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*MID360* 10)
(intern "*BSA_SLAM*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*BSA_SLAM* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*BSA_SLAM* 11)
(intern "*PROSIM*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*PROSIM* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*PROSIM* 12)
(intern "*GPS_FIX_TYPE_NO_GPS*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*GPS_FIX_TYPE_NO_GPS* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*GPS_FIX_TYPE_NO_GPS* 0)
(intern "*GPS_FIX_TYPE_NO_FIX*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*GPS_FIX_TYPE_NO_FIX* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*GPS_FIX_TYPE_NO_FIX* 1)
(intern "*GPS_FIX_TYPE_2D_FIX*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*GPS_FIX_TYPE_2D_FIX* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*GPS_FIX_TYPE_2D_FIX* 2)
(intern "*GPS_FIX_TYPE_3D_FIX*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*GPS_FIX_TYPE_3D_FIX* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*GPS_FIX_TYPE_3D_FIX* 3)
(intern "*GPS_FIX_TYPE_DGPS*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*GPS_FIX_TYPE_DGPS* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*GPS_FIX_TYPE_DGPS* 4)
(intern "*GPS_FIX_TYPE_RTK_FLOATR*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*GPS_FIX_TYPE_RTK_FLOATR* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*GPS_FIX_TYPE_RTK_FLOATR* 5)
(intern "*GPS_FIX_TYPE_RTK_FIXEDR*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*GPS_FIX_TYPE_RTK_FIXEDR* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*GPS_FIX_TYPE_RTK_FIXEDR* 6)
(intern "*GPS_FIX_TYPE_STATIC*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*GPS_FIX_TYPE_STATIC* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*GPS_FIX_TYPE_STATIC* 7)
(intern "*GPS_FIX_TYPE_PPP*" (find-package "PX_UAV_MSGS::UAVSTATE"))
(shadow '*GPS_FIX_TYPE_PPP* (find-package "PX_UAV_MSGS::UAVSTATE"))
(defconstant px_uav_msgs::UAVState::*GPS_FIX_TYPE_PPP* 8)

(defun px_uav_msgs::UAVState-to-symbol (const)
  (cond
        ((= const 0) 'px_uav_msgs::UAVState::*MOCAP*)
        ((= const 1) 'px_uav_msgs::UAVState::*T265*)
        ((= const 2) 'px_uav_msgs::UAVState::*GAZEBO*)
        ((= const 3) 'px_uav_msgs::UAVState::*FAKE_ODOM*)
        ((= const 4) 'px_uav_msgs::UAVState::*GPS*)
        ((= const 5) 'px_uav_msgs::UAVState::*RTK*)
        ((= const 6) 'px_uav_msgs::UAVState::*UWB*)
        ((= const 7) 'px_uav_msgs::UAVState::*VINS*)
        ((= const 8) 'px_uav_msgs::UAVState::*OPTICAL_FLOW*)
        ((= const 9) 'px_uav_msgs::UAVState::*viobot*)
        ((= const 10) 'px_uav_msgs::UAVState::*MID360*)
        ((= const 11) 'px_uav_msgs::UAVState::*BSA_SLAM*)
        ((= const 12) 'px_uav_msgs::UAVState::*ProSim*)
        ((= const 0) 'px_uav_msgs::UAVState::*GPS_FIX_TYPE_NO_GPS*)
        ((= const 1) 'px_uav_msgs::UAVState::*GPS_FIX_TYPE_NO_FIX*)
        ((= const 2) 'px_uav_msgs::UAVState::*GPS_FIX_TYPE_2D_FIX*)
        ((= const 3) 'px_uav_msgs::UAVState::*GPS_FIX_TYPE_3D_FIX*)
        ((= const 4) 'px_uav_msgs::UAVState::*GPS_FIX_TYPE_DGPS*)
        ((= const 5) 'px_uav_msgs::UAVState::*GPS_FIX_TYPE_RTK_FLOATR*)
        ((= const 6) 'px_uav_msgs::UAVState::*GPS_FIX_TYPE_RTK_FIXEDR*)
        ((= const 7) 'px_uav_msgs::UAVState::*GPS_FIX_TYPE_STATIC*)
        ((= const 8) 'px_uav_msgs::UAVState::*GPS_FIX_TYPE_PPP*)
        (t nil)))

(defclass px_uav_msgs::UAVState
  :super ros::object
  :slots (_header _uav_id _connected _armed _mode _location_source _odom_valid _gps_status _gps_num _position _range _latitude _longitude _altitude _rel_alt _velocity _attitude _attitude_q _attitude_rate _battery_state _battery_percetage ))

(defmethod px_uav_msgs::UAVState
  (:init
   (&key
    ((:header __header) (instance std_msgs::Header :init))
    ((:uav_id __uav_id) 0)
    ((:connected __connected) nil)
    ((:armed __armed) nil)
    ((:mode __mode) "")
    ((:location_source __location_source) 0)
    ((:odom_valid __odom_valid) nil)
    ((:gps_status __gps_status) 0)
    ((:gps_num __gps_num) 0)
    ((:position __position) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:range __range) 0.0)
    ((:latitude __latitude) 0.0)
    ((:longitude __longitude) 0.0)
    ((:altitude __altitude) 0.0)
    ((:rel_alt __rel_alt) 0.0)
    ((:velocity __velocity) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:attitude __attitude) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:attitude_q __attitude_q) (instance geometry_msgs::Quaternion :init))
    ((:attitude_rate __attitude_rate) (make-array 3 :initial-element 0.0 :element-type :float))
    ((:battery_state __battery_state) 0.0)
    ((:battery_percetage __battery_percetage) 0.0)
    )
   (send-super :init)
   (setq _header __header)
   (setq _uav_id (round __uav_id))
   (setq _connected __connected)
   (setq _armed __armed)
   (setq _mode (string __mode))
   (setq _location_source (round __location_source))
   (setq _odom_valid __odom_valid)
   (setq _gps_status (round __gps_status))
   (setq _gps_num (round __gps_num))
   (setq _position __position)
   (setq _range (float __range))
   (setq _latitude (float __latitude))
   (setq _longitude (float __longitude))
   (setq _altitude (float __altitude))
   (setq _rel_alt (float __rel_alt))
   (setq _velocity __velocity)
   (setq _attitude __attitude)
   (setq _attitude_q __attitude_q)
   (setq _attitude_rate __attitude_rate)
   (setq _battery_state (float __battery_state))
   (setq _battery_percetage (float __battery_percetage))
   self)
  (:header
   (&rest __header)
   (if (keywordp (car __header))
       (send* _header __header)
     (progn
       (if __header (setq _header (car __header)))
       _header)))
  (:uav_id
   (&optional __uav_id)
   (if __uav_id (setq _uav_id __uav_id)) _uav_id)
  (:connected
   (&optional (__connected :null))
   (if (not (eq __connected :null)) (setq _connected __connected)) _connected)
  (:armed
   (&optional (__armed :null))
   (if (not (eq __armed :null)) (setq _armed __armed)) _armed)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:location_source
   (&optional __location_source)
   (if __location_source (setq _location_source __location_source)) _location_source)
  (:odom_valid
   (&optional (__odom_valid :null))
   (if (not (eq __odom_valid :null)) (setq _odom_valid __odom_valid)) _odom_valid)
  (:gps_status
   (&optional __gps_status)
   (if __gps_status (setq _gps_status __gps_status)) _gps_status)
  (:gps_num
   (&optional __gps_num)
   (if __gps_num (setq _gps_num __gps_num)) _gps_num)
  (:position
   (&optional __position)
   (if __position (setq _position __position)) _position)
  (:range
   (&optional __range)
   (if __range (setq _range __range)) _range)
  (:latitude
   (&optional __latitude)
   (if __latitude (setq _latitude __latitude)) _latitude)
  (:longitude
   (&optional __longitude)
   (if __longitude (setq _longitude __longitude)) _longitude)
  (:altitude
   (&optional __altitude)
   (if __altitude (setq _altitude __altitude)) _altitude)
  (:rel_alt
   (&optional __rel_alt)
   (if __rel_alt (setq _rel_alt __rel_alt)) _rel_alt)
  (:velocity
   (&optional __velocity)
   (if __velocity (setq _velocity __velocity)) _velocity)
  (:attitude
   (&optional __attitude)
   (if __attitude (setq _attitude __attitude)) _attitude)
  (:attitude_q
   (&rest __attitude_q)
   (if (keywordp (car __attitude_q))
       (send* _attitude_q __attitude_q)
     (progn
       (if __attitude_q (setq _attitude_q (car __attitude_q)))
       _attitude_q)))
  (:attitude_rate
   (&optional __attitude_rate)
   (if __attitude_rate (setq _attitude_rate __attitude_rate)) _attitude_rate)
  (:battery_state
   (&optional __battery_state)
   (if __battery_state (setq _battery_state __battery_state)) _battery_state)
  (:battery_percetage
   (&optional __battery_percetage)
   (if __battery_percetage (setq _battery_percetage __battery_percetage)) _battery_percetage)
  (:serialization-length
   ()
   (+
    ;; std_msgs/Header _header
    (send _header :serialization-length)
    ;; uint8 _uav_id
    1
    ;; bool _connected
    1
    ;; bool _armed
    1
    ;; string _mode
    4 (length _mode)
    ;; uint8 _location_source
    1
    ;; bool _odom_valid
    1
    ;; uint8 _gps_status
    1
    ;; uint8 _gps_num
    1
    ;; float32[3] _position
    (* 4    3)
    ;; float32 _range
    4
    ;; float32 _latitude
    4
    ;; float32 _longitude
    4
    ;; float32 _altitude
    4
    ;; float32 _rel_alt
    4
    ;; float32[3] _velocity
    (* 4    3)
    ;; float32[3] _attitude
    (* 4    3)
    ;; geometry_msgs/Quaternion _attitude_q
    (send _attitude_q :serialization-length)
    ;; float32[3] _attitude_rate
    (* 4    3)
    ;; float32 _battery_state
    4
    ;; float32 _battery_percetage
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; std_msgs/Header _header
       (send _header :serialize s)
     ;; uint8 _uav_id
       (write-byte _uav_id s)
     ;; bool _connected
       (if _connected (write-byte -1 s) (write-byte 0 s))
     ;; bool _armed
       (if _armed (write-byte -1 s) (write-byte 0 s))
     ;; string _mode
       (write-long (length _mode) s) (princ _mode s)
     ;; uint8 _location_source
       (write-byte _location_source s)
     ;; bool _odom_valid
       (if _odom_valid (write-byte -1 s) (write-byte 0 s))
     ;; uint8 _gps_status
       (write-byte _gps_status s)
     ;; uint8 _gps_num
       (write-byte _gps_num s)
     ;; float32[3] _position
     (dotimes (i 3)
       (sys::poke (elt _position i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _range
       (sys::poke _range (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _latitude
       (sys::poke _latitude (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _longitude
       (sys::poke _longitude (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _altitude
       (sys::poke _altitude (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _rel_alt
       (sys::poke _rel_alt (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32[3] _velocity
     (dotimes (i 3)
       (sys::poke (elt _velocity i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32[3] _attitude
     (dotimes (i 3)
       (sys::poke (elt _attitude i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; geometry_msgs/Quaternion _attitude_q
       (send _attitude_q :serialize s)
     ;; float32[3] _attitude_rate
     (dotimes (i 3)
       (sys::poke (elt _attitude_rate i) (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
       )
     ;; float32 _battery_state
       (sys::poke _battery_state (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _battery_percetage
       (sys::poke _battery_percetage (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; std_msgs/Header _header
     (send _header :deserialize buf ptr-) (incf ptr- (send _header :serialization-length))
   ;; uint8 _uav_id
     (setq _uav_id (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; bool _connected
     (setq _connected (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; bool _armed
     (setq _armed (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; string _mode
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _mode (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; uint8 _location_source
     (setq _location_source (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; bool _odom_valid
     (setq _odom_valid (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; uint8 _gps_status
     (setq _gps_status (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; uint8 _gps_num
     (setq _gps_num (sys::peek buf ptr- :char)) (incf ptr- 1)
   ;; float32[3] _position
   (dotimes (i (length _position))
     (setf (elt _position i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32 _range
     (setq _range (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _latitude
     (setq _latitude (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _longitude
     (setq _longitude (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _altitude
     (setq _altitude (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _rel_alt
     (setq _rel_alt (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32[3] _velocity
   (dotimes (i (length _velocity))
     (setf (elt _velocity i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32[3] _attitude
   (dotimes (i (length _attitude))
     (setf (elt _attitude i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; geometry_msgs/Quaternion _attitude_q
     (send _attitude_q :deserialize buf ptr-) (incf ptr- (send _attitude_q :serialization-length))
   ;; float32[3] _attitude_rate
   (dotimes (i (length _attitude_rate))
     (setf (elt _attitude_rate i) (sys::peek buf ptr- :float)) (incf ptr- 4)
     )
   ;; float32 _battery_state
     (setq _battery_state (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _battery_percetage
     (setq _battery_percetage (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get px_uav_msgs::UAVState :md5sum-) "61e95e9b6634e22769af5718eecfc53c")
(setf (get px_uav_msgs::UAVState :datatype-) "px_uav_msgs/UAVState")
(setf (get px_uav_msgs::UAVState :definition-)
      "std_msgs/Header header

## 无人机编号 
uint8 uav_id

## 机载电脑是否连接上飞控，true已连接，false则不是
bool connected
## 是否解锁，true为已解锁，false则不是
bool armed
## PX4飞控当前飞行模式  int8
string mode
## 无人机定位来源
uint8 location_source
## 定位来源枚举
uint8 MOCAP=0
uint8 T265=1
uint8 GAZEBO=2
uint8 FAKE_ODOM=3
uint8 GPS = 4
uint8 RTK = 5
uint8 UWB = 6
uint8 VINS = 7
uint8 OPTICAL_FLOW = 8
uint8 viobot = 9
uint8 MID360 = 10
uint8 BSA_SLAM=11
uint8 ProSim = 12
## odom标志位
bool odom_valid

## GPS状态,变量对应状态可参考mavros_msgs/GPSRAW中的fix_type
uint8 gps_status
## GPS状态枚举
uint8 GPS_FIX_TYPE_NO_GPS=0
uint8 GPS_FIX_TYPE_NO_FIX=1
uint8 GPS_FIX_TYPE_2D_FIX=2
uint8 GPS_FIX_TYPE_3D_FIX=3
uint8 GPS_FIX_TYPE_DGPS=4
uint8 GPS_FIX_TYPE_RTK_FLOATR=5
uint8 GPS_FIX_TYPE_RTK_FIXEDR=6
uint8 GPS_FIX_TYPE_STATIC=7
uint8 GPS_FIX_TYPE_PPP=8
## GPS卫星数量
uint8 gps_num

## 无人机位置、速度、姿态
float32[3] position                 ## [m]
## 无人机定高雷达                     ## [m]
float32  range
## 无人机经度、纬度、高度
float32 latitude                       
float32 longitude
float32 altitude
float32 rel_alt
## 无人机速度、姿态
float32[3] velocity                 ## [m/s]
## 无人机姿态（欧拉角、四元数）
float32[3] attitude                 ## [rad]
geometry_msgs/Quaternion attitude_q ## 四元数
## 无人机姿态角速度
float32[3] attitude_rate            ## [rad/s]
## 无人机电池状态
float32 battery_state               ## [V]
float32 battery_percetage           ## [0-1]




    

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
MSG: geometry_msgs/Quaternion
# This represents an orientation in free space in quaternion form.

float64 x
float64 y
float64 z
float64 w

")



(provide :px_uav_msgs/UAVState "61e95e9b6634e22769af5718eecfc53c")


