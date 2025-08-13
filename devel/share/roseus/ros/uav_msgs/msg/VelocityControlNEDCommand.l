;; Auto-generated. Do not edit!


(when (boundp 'uav_msgs::VelocityControlNEDCommand)
  (if (not (find-package "UAV_MSGS"))
    (make-package "UAV_MSGS"))
  (shadow 'VelocityControlNEDCommand (find-package "UAV_MSGS")))
(unless (find-package "UAV_MSGS::VELOCITYCONTROLNEDCOMMAND")
  (make-package "UAV_MSGS::VELOCITYCONTROLNEDCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude VelocityControlNEDCommand.msg.html


(defclass uav_msgs::VelocityControlNEDCommand
  :super ros::object
  :slots (_vx _vy _vz _yaw_rate ))

(defmethod uav_msgs::VelocityControlNEDCommand
  (:init
   (&key
    ((:vx __vx) 0.0)
    ((:vy __vy) 0.0)
    ((:vz __vz) 0.0)
    ((:yaw_rate __yaw_rate) 0.0)
    )
   (send-super :init)
   (setq _vx (float __vx))
   (setq _vy (float __vy))
   (setq _vz (float __vz))
   (setq _yaw_rate (float __yaw_rate))
   self)
  (:vx
   (&optional __vx)
   (if __vx (setq _vx __vx)) _vx)
  (:vy
   (&optional __vy)
   (if __vy (setq _vy __vy)) _vy)
  (:vz
   (&optional __vz)
   (if __vz (setq _vz __vz)) _vz)
  (:yaw_rate
   (&optional __yaw_rate)
   (if __yaw_rate (setq _yaw_rate __yaw_rate)) _yaw_rate)
  (:serialization-length
   ()
   (+
    ;; float64 _vx
    8
    ;; float64 _vy
    8
    ;; float64 _vz
    8
    ;; float64 _yaw_rate
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _vx
       (sys::poke _vx (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _vy
       (sys::poke _vy (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _vz
       (sys::poke _vz (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _yaw_rate
       (sys::poke _yaw_rate (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _vx
     (setq _vx (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _vy
     (setq _vy (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _vz
     (setq _vz (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _yaw_rate
     (setq _yaw_rate (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get uav_msgs::VelocityControlNEDCommand :md5sum-) "4b632edbf148b4de86917df6b3e0c126")
(setf (get uav_msgs::VelocityControlNEDCommand :datatype-) "uav_msgs/VelocityControlNEDCommand")
(setf (get uav_msgs::VelocityControlNEDCommand :definition-)
      "float64 vx
float64 vy
float64 vz
float64 yaw_rate

")



(provide :uav_msgs/VelocityControlNEDCommand "4b632edbf148b4de86917df6b3e0c126")


