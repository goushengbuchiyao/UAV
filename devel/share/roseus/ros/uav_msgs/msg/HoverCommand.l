;; Auto-generated. Do not edit!


(when (boundp 'uav_msgs::HoverCommand)
  (if (not (find-package "UAV_MSGS"))
    (make-package "UAV_MSGS"))
  (shadow 'HoverCommand (find-package "UAV_MSGS")))
(unless (find-package "UAV_MSGS::HOVERCOMMAND")
  (make-package "UAV_MSGS::HOVERCOMMAND"))

(in-package "ROS")
;;//! \htmlinclude HoverCommand.msg.html


(defclass uav_msgs::HoverCommand
  :super ros::object
  :slots (_mode ))

(defmethod uav_msgs::HoverCommand
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

(setf (get uav_msgs::HoverCommand :md5sum-) "e84dc3ad5dc323bb64f0aca01c2d1eef")
(setf (get uav_msgs::HoverCommand :datatype-) "uav_msgs/HoverCommand")
(setf (get uav_msgs::HoverCommand :definition-)
      "string mode
")



(provide :uav_msgs/HoverCommand "e84dc3ad5dc323bb64f0aca01c2d1eef")


