;; Auto-generated. Do not edit!


(when (boundp 'px_uav_msgs::Target)
  (if (not (find-package "PX_UAV_MSGS"))
    (make-package "PX_UAV_MSGS"))
  (shadow 'Target (find-package "PX_UAV_MSGS")))
(unless (find-package "PX_UAV_MSGS::TARGET")
  (make-package "PX_UAV_MSGS::TARGET"))

(in-package "ROS")
;;//! \htmlinclude Target.msg.html


(defclass px_uav_msgs::Target
  :super ros::object
  :slots (_cx _cy _w _h _score _category _category_id _tracked_id _px _py _pz _los_ax _los_ay _yaw_a _mode _sim_score ))

(defmethod px_uav_msgs::Target
  (:init
   (&key
    ((:cx __cx) 0.0)
    ((:cy __cy) 0.0)
    ((:w __w) 0.0)
    ((:h __h) 0.0)
    ((:score __score) 0.0)
    ((:category __category) "")
    ((:category_id __category_id) 0)
    ((:tracked_id __tracked_id) 0)
    ((:px __px) 0.0)
    ((:py __py) 0.0)
    ((:pz __pz) 0.0)
    ((:los_ax __los_ax) 0.0)
    ((:los_ay __los_ay) 0.0)
    ((:yaw_a __yaw_a) 0.0)
    ((:mode __mode) nil)
    ((:sim_score __sim_score) 0.0)
    )
   (send-super :init)
   (setq _cx (float __cx))
   (setq _cy (float __cy))
   (setq _w (float __w))
   (setq _h (float __h))
   (setq _score (float __score))
   (setq _category (string __category))
   (setq _category_id (round __category_id))
   (setq _tracked_id (round __tracked_id))
   (setq _px (float __px))
   (setq _py (float __py))
   (setq _pz (float __pz))
   (setq _los_ax (float __los_ax))
   (setq _los_ay (float __los_ay))
   (setq _yaw_a (float __yaw_a))
   (setq _mode __mode)
   (setq _sim_score (float __sim_score))
   self)
  (:cx
   (&optional __cx)
   (if __cx (setq _cx __cx)) _cx)
  (:cy
   (&optional __cy)
   (if __cy (setq _cy __cy)) _cy)
  (:w
   (&optional __w)
   (if __w (setq _w __w)) _w)
  (:h
   (&optional __h)
   (if __h (setq _h __h)) _h)
  (:score
   (&optional __score)
   (if __score (setq _score __score)) _score)
  (:category
   (&optional __category)
   (if __category (setq _category __category)) _category)
  (:category_id
   (&optional __category_id)
   (if __category_id (setq _category_id __category_id)) _category_id)
  (:tracked_id
   (&optional __tracked_id)
   (if __tracked_id (setq _tracked_id __tracked_id)) _tracked_id)
  (:px
   (&optional __px)
   (if __px (setq _px __px)) _px)
  (:py
   (&optional __py)
   (if __py (setq _py __py)) _py)
  (:pz
   (&optional __pz)
   (if __pz (setq _pz __pz)) _pz)
  (:los_ax
   (&optional __los_ax)
   (if __los_ax (setq _los_ax __los_ax)) _los_ax)
  (:los_ay
   (&optional __los_ay)
   (if __los_ay (setq _los_ay __los_ay)) _los_ay)
  (:yaw_a
   (&optional __yaw_a)
   (if __yaw_a (setq _yaw_a __yaw_a)) _yaw_a)
  (:mode
   (&optional (__mode :null))
   (if (not (eq __mode :null)) (setq _mode __mode)) _mode)
  (:sim_score
   (&optional __sim_score)
   (if __sim_score (setq _sim_score __sim_score)) _sim_score)
  (:serialization-length
   ()
   (+
    ;; float32 _cx
    4
    ;; float32 _cy
    4
    ;; float32 _w
    4
    ;; float32 _h
    4
    ;; float32 _score
    4
    ;; string _category
    4 (length _category)
    ;; int32 _category_id
    4
    ;; int32 _tracked_id
    4
    ;; float32 _px
    4
    ;; float32 _py
    4
    ;; float32 _pz
    4
    ;; float32 _los_ax
    4
    ;; float32 _los_ay
    4
    ;; float32 _yaw_a
    4
    ;; bool _mode
    1
    ;; float32 _sim_score
    4
    ))
  (:serialize
   (&optional strm)
   (let ((s (if strm strm
              (make-string-output-stream (send self :serialization-length)))))
     ;; float32 _cx
       (sys::poke _cx (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _cy
       (sys::poke _cy (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _w
       (sys::poke _w (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _h
       (sys::poke _h (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _score
       (sys::poke _score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; string _category
       (write-long (length _category) s) (princ _category s)
     ;; int32 _category_id
       (write-long _category_id s)
     ;; int32 _tracked_id
       (write-long _tracked_id s)
     ;; float32 _px
       (sys::poke _px (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _py
       (sys::poke _py (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _pz
       (sys::poke _pz (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _los_ax
       (sys::poke _los_ax (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _los_ay
       (sys::poke _los_ay (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; float32 _yaw_a
       (sys::poke _yaw_a (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;; bool _mode
       (if _mode (write-byte -1 s) (write-byte 0 s))
     ;; float32 _sim_score
       (sys::poke _sim_score (send s :buffer) (send s :count) :float) (incf (stream-count s) 4)
     ;;
     (if (null strm) (get-output-stream-string s))))
  (:deserialize
   (buf &optional (ptr- 0))
   ;; float32 _cx
     (setq _cx (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _cy
     (setq _cy (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _w
     (setq _w (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _h
     (setq _h (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _score
     (setq _score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; string _category
     (let (n) (setq n (sys::peek buf ptr- :integer)) (incf ptr- 4) (setq _category (subseq buf ptr- (+ ptr- n))) (incf ptr- n))
   ;; int32 _category_id
     (setq _category_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; int32 _tracked_id
     (setq _tracked_id (sys::peek buf ptr- :integer)) (incf ptr- 4)
   ;; float32 _px
     (setq _px (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _py
     (setq _py (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _pz
     (setq _pz (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _los_ax
     (setq _los_ax (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _los_ay
     (setq _los_ay (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; float32 _yaw_a
     (setq _yaw_a (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;; bool _mode
     (setq _mode (not (= 0 (sys::peek buf ptr- :char)))) (incf ptr- 1)
   ;; float32 _sim_score
     (setq _sim_score (sys::peek buf ptr- :float)) (incf ptr- 4)
   ;;
   self)
  )

(setf (get px_uav_msgs::Target :md5sum-) "3623dd3b471832f212700e5baf3ce9ed")
(setf (get px_uav_msgs::Target :datatype-) "px_uav_msgs/Target")
(setf (get px_uav_msgs::Target :definition-)
      "
## 目标中心的水平位置 [0,1]
float32 cx
## 目标中心的垂直位置 [0,1]
float32 cy

## 目标宽度/图像宽度 [0,1]
float32 w
## 目标高度/图像高度 [0,1]
float32 h

## 目标置信度 [0,1]
float32 score

## 目标类别名称
string category
## 目标类别编号 从0开始计算
int32 category_id

## 目标跟踪ID号
int32 tracked_id

## 目标3D位置 单位：m
float32 px
float32 py
float32 pz

## 目标中心点的视线角度 [相机系下：右方x角度为正，下方y角度为正] 单位：度
float32 los_ax
float32 los_ay

## 偏航角误差 [图像系下：垂直向上为0°，右半圈顺时针0~180°，左半圈逆时针0~-180°]
float32 yaw_a

## detection(false/0) or tracked(true/1)
bool mode

## CosineSimilarity
float32 sim_score





")



(provide :px_uav_msgs/Target "3623dd3b471832f212700e5baf3ce9ed")


