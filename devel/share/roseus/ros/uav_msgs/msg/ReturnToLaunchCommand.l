;; Auto-generated. Do not edit!


(when (boundp 'uav_msgs::ReturnToLaunchCommand)
  (if (not (find-package "UAV_MSGS"))
    (make-package "UAV_MSGS"))
  (shadow 'ReturnToLaunchCommand (find-package "UAV_MSGS")))
(unless (find-package "UAV_MSGS::RETURNTOLAUNCHCOMMAND")
  (make-package "UAV_MSGS::RETURNTOLAUNCHCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude ReturnToLaunchCommand.msg.html


(defclass uav_msgs::ReturnToLaunchCommand
  :super ros::object
  :slots (_altitude ))

(defmethod uav_msgs::ReturnToLaunchCommand
  (:init
   (&key
    ((:altitude __altitude) 0.0)
    )
   (send-super :init)
   (setq _altitude (float __altitude))
   self)
  (:altitude
   (&optional __altitude)
   (if __altitude (setq _altitude __altitude)) _altitude)
  (:serialization-length
   ()
   (+
    ;; float64 _altitude
    8
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float64 _altitude
       (sys::poke _altitude (send s :buffer) (send s :count) :double) (incf (stream-count s) 8)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float64 _altitude
     (setq _altitude (sys::peek buf ptr- :double)) (incf ptr- 8)
   ;;
   self)
  )

(setf (get uav_msgs::ReturnToLaunchCommand :md5sum-) "42af7eb0aaf91dc07d6880f800cabbb3")
(setf (get uav_msgs::ReturnToLaunchCommand :datatype-) "uav_msgs/ReturnToLaunchCommand")
(setf (get uav_msgs::ReturnToLaunchCommand :definition-)
      "float64 altitude

")



(provide :uav_msgs/ReturnToLaunchCommand "42af7eb0aaf91dc07d6880f800cabbb3")


