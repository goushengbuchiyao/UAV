;; Auto-generated. Do not edit!


(when (boundp 'uav_msgs::LandCommand)
  (if (not (find-package "UAV_MSGS"))
    (make-package "UAV_MSGS"))
  (shadow 'LandCommand (find-package "UAV_MSGS")))
(unless (find-package "UAV_MSGS::LANDCOMMAND")
  (make-package "UAV_MSGS::LANDCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude LandCommand.msg.html


(defclass uav_msgs::LandCommand
  :super ros::object
  :slots (_yaw ))

(defmethod uav_msgs::LandCommand
  (:init
   (&key
    ((:yaw __yaw) 0.0)
    )
   (send-super :init)
   (setq _yaw (float __yaw))
   self)
  (:yaw
   (&optional __yaw)
   (if __yaw (setq _yaw __yaw)) _yaw)
  (:serialization-length
   ()
   (+
    ;; float64 _yaw
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _yaw
       (sys::poke _yaw (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _yaw
     (setq _yaw (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get uav_msgs::LandCommand :md5sum-) "08cb8274b6ddb17af5a842bca0b17db1")
(setf (get uav_msgs::LandCommand :datatype-) "uav_msgs/LandCommand")
(setf (get uav_msgs::LandCommand :definition-)
      "float64 yaw

")



(provide :uav_msgs/LandCommand "08cb8274b6ddb17af5a842bca0b17db1")


