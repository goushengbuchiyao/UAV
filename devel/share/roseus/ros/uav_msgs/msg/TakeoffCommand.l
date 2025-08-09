;; Auto-generated. Do not edit!


(when (boundp 'uav_msgs::TakeoffCommand)
  (if (not (find-package "UAV_MSGS"))
    (make-package "UAV_MSGS"))
  (shadow 'TakeoffCommand (find-package "UAV_MSGS")))
(unless (find-package "UAV_MSGS::TAKEOFFCOMMAND")
  (make-package "UAV_MSGS::TAKEOFFCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude TakeoffCommand.msg.html


(defclass uav_msgs::TakeoffCommand
  :super ros::object
  :slots (_altitude _yaw ))

(defmethod uav_msgs::TakeoffCommand
  (:init
   (&key
    ((:altitude __altitude) 0.0)
    ((:yaw __yaw) 0.0)
    )
   (send-super :init)
   (setq _altitude (float __altitude))
   (setq _yaw (float __yaw))
   self)
  (:altitude
   (&optional __altitude)
   (if __altitude (setq _altitude __altitude)) _altitude)
  (:yaw
   (&optional __yaw)
   (if __yaw (setq _yaw __yaw)) _yaw)
  (:serialization-length
   ()
   (+
    ;; float64 _altitude
    8
    ;; float64 _yaw
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _altitude
       (sys::poke _altitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;; float64 _yaw
       (sys::poke _yaw (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _altitude
     (setq _altitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;; float64 _yaw
     (setq _yaw (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get uav_msgs::TakeoffCommand :md5sum-) "83cd6ff07b4a0c35e09bcaacfdff250a")
(setf (get uav_msgs::TakeoffCommand :datatype-) "uav_msgs/TakeoffCommand")
(setf (get uav_msgs::TakeoffCommand :definition-)
      "float64 altitude
float64 yaw

")



(provide :uav_msgs/TakeoffCommand "83cd6ff07b4a0c35e09bcaacfdff250a")


