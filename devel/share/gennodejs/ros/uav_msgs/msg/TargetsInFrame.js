// Auto-generated. Do not edit!

// (in-package uav_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Target = require('./Target.js');
let ROI = require('./ROI.js');
let std_msgs = _finder('std_msgs');

//-----------------------------------------------------------

class TargetsInFrame {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.header = null;
      this.frame_id = null;
      this.height = null;
      this.width = null;
      this.fps = null;
      this.fov_x = null;
      this.fov_y = null;
      this.targets = null;
      this.rois = null;
      this.no_track_frame_count = null;
      this.tracking_state = null;
    }
    else {
      if (initObj.hasOwnProperty('header')) {
        this.header = initObj.header
      }
      else {
        this.header = new std_msgs.msg.Header();
      }
      if (initObj.hasOwnProperty('frame_id')) {
        this.frame_id = initObj.frame_id
      }
      else {
        this.frame_id = 0;
      }
      if (initObj.hasOwnProperty('height')) {
        this.height = initObj.height
      }
      else {
        this.height = 0;
      }
      if (initObj.hasOwnProperty('width')) {
        this.width = initObj.width
      }
      else {
        this.width = 0;
      }
      if (initObj.hasOwnProperty('fps')) {
        this.fps = initObj.fps
      }
      else {
        this.fps = 0.0;
      }
      if (initObj.hasOwnProperty('fov_x')) {
        this.fov_x = initObj.fov_x
      }
      else {
        this.fov_x = 0.0;
      }
      if (initObj.hasOwnProperty('fov_y')) {
        this.fov_y = initObj.fov_y
      }
      else {
        this.fov_y = 0.0;
      }
      if (initObj.hasOwnProperty('targets')) {
        this.targets = initObj.targets
      }
      else {
        this.targets = [];
      }
      if (initObj.hasOwnProperty('rois')) {
        this.rois = initObj.rois
      }
      else {
        this.rois = [];
      }
      if (initObj.hasOwnProperty('no_track_frame_count')) {
        this.no_track_frame_count = initObj.no_track_frame_count
      }
      else {
        this.no_track_frame_count = 0;
      }
      if (initObj.hasOwnProperty('tracking_state')) {
        this.tracking_state = initObj.tracking_state
      }
      else {
        this.tracking_state = false;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type TargetsInFrame
    // Serialize message field [header]
    bufferOffset = std_msgs.msg.Header.serialize(obj.header, buffer, bufferOffset);
    // Serialize message field [frame_id]
    bufferOffset = _serializer.int32(obj.frame_id, buffer, bufferOffset);
    // Serialize message field [height]
    bufferOffset = _serializer.int32(obj.height, buffer, bufferOffset);
    // Serialize message field [width]
    bufferOffset = _serializer.int32(obj.width, buffer, bufferOffset);
    // Serialize message field [fps]
    bufferOffset = _serializer.float32(obj.fps, buffer, bufferOffset);
    // Serialize message field [fov_x]
    bufferOffset = _serializer.float32(obj.fov_x, buffer, bufferOffset);
    // Serialize message field [fov_y]
    bufferOffset = _serializer.float32(obj.fov_y, buffer, bufferOffset);
    // Serialize message field [targets]
    // Serialize the length for message field [targets]
    bufferOffset = _serializer.uint32(obj.targets.length, buffer, bufferOffset);
    obj.targets.forEach((val) => {
      bufferOffset = Target.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [rois]
    // Serialize the length for message field [rois]
    bufferOffset = _serializer.uint32(obj.rois.length, buffer, bufferOffset);
    obj.rois.forEach((val) => {
      bufferOffset = ROI.serialize(val, buffer, bufferOffset);
    });
    // Serialize message field [no_track_frame_count]
    bufferOffset = _serializer.int32(obj.no_track_frame_count, buffer, bufferOffset);
    // Serialize message field [tracking_state]
    bufferOffset = _serializer.bool(obj.tracking_state, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type TargetsInFrame
    let len;
    let data = new TargetsInFrame(null);
    // Deserialize message field [header]
    data.header = std_msgs.msg.Header.deserialize(buffer, bufferOffset);
    // Deserialize message field [frame_id]
    data.frame_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [height]
    data.height = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [width]
    data.width = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [fps]
    data.fps = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fov_x]
    data.fov_x = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [fov_y]
    data.fov_y = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [targets]
    // Deserialize array length for message field [targets]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.targets = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.targets[i] = Target.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [rois]
    // Deserialize array length for message field [rois]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.rois = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.rois[i] = ROI.deserialize(buffer, bufferOffset)
    }
    // Deserialize message field [no_track_frame_count]
    data.no_track_frame_count = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [tracking_state]
    data.tracking_state = _deserializer.bool(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += std_msgs.msg.Header.getMessageSize(object.header);
    object.targets.forEach((val) => {
      length += Target.getMessageSize(val);
    });
    length += 16 * object.rois.length;
    return length + 37;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uav_msgs/TargetsInFrame';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '50723d8130f9d56db1f6a8f8b5c9622c';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    ## ROS Header
    std_msgs/Header header
    
    ## 帧ID号
    int32 frame_id
    
    ## 帧像素高度
    int32 height
    ## 帧像素宽度
    int32 width
    
    ## 当前检测/跟踪频率
    float32 fps
    
    ## 当前成像设备的水平视场角，单位：度
    float32 fov_x
    ## 当前成像设备的垂直视场角，单位：度
    float32 fov_y
    
    ## 当前帧每个目标信息
    Target[] targets
    
    ## 当前检测的兴趣区域，ROIs
    ROI[] rois
    
    ##focusing solely on tracking , without considering detection
    int32 no_track_frame_count
    
    ## 是否处于跟踪状态，0：否，1：是。当状态为1，targets为空表示丢失；targets不为空表示正常跟踪。
    bool tracking_state
    
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
    MSG: uav_msgs/Target
    
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
    
    
    
    
    
    ================================================================================
    MSG: uav_msgs/ROI
    
    ## 区域左上角像素坐标
    int32 x1
    int32 y1
    
    ## 区域右下角像素坐标
    int32 x2
    int32 y2
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new TargetsInFrame(null);
    if (msg.header !== undefined) {
      resolved.header = std_msgs.msg.Header.Resolve(msg.header)
    }
    else {
      resolved.header = new std_msgs.msg.Header()
    }

    if (msg.frame_id !== undefined) {
      resolved.frame_id = msg.frame_id;
    }
    else {
      resolved.frame_id = 0
    }

    if (msg.height !== undefined) {
      resolved.height = msg.height;
    }
    else {
      resolved.height = 0
    }

    if (msg.width !== undefined) {
      resolved.width = msg.width;
    }
    else {
      resolved.width = 0
    }

    if (msg.fps !== undefined) {
      resolved.fps = msg.fps;
    }
    else {
      resolved.fps = 0.0
    }

    if (msg.fov_x !== undefined) {
      resolved.fov_x = msg.fov_x;
    }
    else {
      resolved.fov_x = 0.0
    }

    if (msg.fov_y !== undefined) {
      resolved.fov_y = msg.fov_y;
    }
    else {
      resolved.fov_y = 0.0
    }

    if (msg.targets !== undefined) {
      resolved.targets = new Array(msg.targets.length);
      for (let i = 0; i < resolved.targets.length; ++i) {
        resolved.targets[i] = Target.Resolve(msg.targets[i]);
      }
    }
    else {
      resolved.targets = []
    }

    if (msg.rois !== undefined) {
      resolved.rois = new Array(msg.rois.length);
      for (let i = 0; i < resolved.rois.length; ++i) {
        resolved.rois[i] = ROI.Resolve(msg.rois[i]);
      }
    }
    else {
      resolved.rois = []
    }

    if (msg.no_track_frame_count !== undefined) {
      resolved.no_track_frame_count = msg.no_track_frame_count;
    }
    else {
      resolved.no_track_frame_count = 0
    }

    if (msg.tracking_state !== undefined) {
      resolved.tracking_state = msg.tracking_state;
    }
    else {
      resolved.tracking_state = false
    }

    return resolved;
    }
};

module.exports = TargetsInFrame;
