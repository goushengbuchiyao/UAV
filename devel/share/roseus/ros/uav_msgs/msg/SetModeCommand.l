;; Auto-generated. Do not edit!


(when (boundp 'uav_msgs::SetModeCommand)
  (if (not (find-package "UAV_MSGS"))
    (make-package "UAV_MSGS"))
  (shadow 'SetModeCommand (find-package "UAV_MSGS")))
(unless (find-package "UAV_MSGS::SETMODECOMMAND")
  (make-package "UAV_MSGS::SETMODECOMMAND"))

(in-package "ROS")
;;//! \htmlinclude SetModeCommand.msg.html


(defclass uav_msgs::SetModeCommand
  :super ros::object
  :slots (_mode ))

(defmethod uav_msgs::SetModeCommand
  (:init
   (&key
    ((:mode __mode) "")
    )
   (send-super :init)
   (setq _mode (string __mode))
   self)
  (:mode
   (&optional __mode)
   (if __mode (setq _mode __mode)) _mode)
  (:serialization-length
   ()
   (+
    ;; string _mode
    4 (length _mode)
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; string _mode
       (write-long (length _mode) s) (princ _mode s)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; string _mode
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _mode (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;;
   self)
  )

(setf (get uav_msgs::SetModeCommand :md5sum-) "e84dc3ad5dc323bb64f0aca01c2d1eef")
(setf (get uav_msgs::SetModeCommand :datatype-) "uav_msgs/SetModeCommand")
(setf (get uav_msgs::SetModeCommand :definition-)
      "string mode

")



(provide :uav_msgs/SetModeCommand "e84dc3ad5dc323bb64f0aca01c2d1eef")


