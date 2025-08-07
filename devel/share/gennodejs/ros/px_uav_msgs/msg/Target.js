// Auto-generated. Do not edit!

// (in-package px_uav_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Target {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.cx = null;
      this.cy = null;
      this.w = null;
      this.h = null;
      this.score = null;
      this.category = null;
      this.category_id = null;
      this.tracked_id = null;
      this.px = null;
      this.py = null;
      this.pz = null;
      this.los_ax = null;
      this.los_ay = null;
      this.yaw_a = null;
      this.mode = null;
      this.sim_score = null;
    }
    else {
      if (initObj.hasOwnProperty('cx')) {
        this.cx = initObj.cx
      }
      else {
        this.cx = 0.0;
      }
      if (initObj.hasOwnProperty('cy')) {
        this.cy = initObj.cy
      }
      else {
        this.cy = 0.0;
      }
      if (initObj.hasOwnProperty('w')) {
        this.w = initObj.w
      }
      else {
        this.w = 0.0;
      }
      if (initObj.hasOwnProperty('h')) {
        this.h = initObj.h
      }
      else {
        this.h = 0.0;
      }
      if (initObj.hasOwnProperty('score')) {
        this.score = initObj.score
      }
      else {
        this.score = 0.0;
      }
      if (initObj.hasOwnProperty('category')) {
        this.category = initObj.category
      }
      else {
        this.category = '';
      }
      if (initObj.hasOwnProperty('category_id')) {
        this.category_id = initObj.category_id
      }
      else {
        this.category_id = 0;
      }
      if (initObj.hasOwnProperty('tracked_id')) {
        this.tracked_id = initObj.tracked_id
      }
      else {
        this.tracked_id = 0;
      }
      if (initObj.hasOwnProperty('px')) {
        this.px = initObj.px
      }
      else {
        this.px = 0.0;
      }
      if (initObj.hasOwnProperty('py')) {
        this.py = initObj.py
      }
      else {
        this.py = 0.0;
      }
      if (initObj.hasOwnProperty('pz')) {
        this.pz = initObj.pz
      }
      else {
        this.pz = 0.0;
      }
      if (initObj.hasOwnProperty('los_ax')) {
        this.los_ax = initObj.los_ax
      }
      else {
        this.los_ax = 0.0;
      }
      if (initObj.hasOwnProperty('los_ay')) {
        this.los_ay = initObj.los_ay
      }
      else {
        this.los_ay = 0.0;
      }
      if (initObj.hasOwnProperty('yaw_a')) {
        this.yaw_a = initObj.yaw_a
      }
      else {
        this.yaw_a = 0.0;
      }
      if (initObj.hasOwnProperty('mode')) {
        this.mode = initObj.mode
      }
      else {
        this.mode = false;
      }
      if (initObj.hasOwnProperty('sim_score')) {
        this.sim_score = initObj.sim_score
      }
      else {
        this.sim_score = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Target
    // Serialize message field [cx]
    bufferOffset = _serializer.float32(obj.cx, buffer, bufferOffset);
    // Serialize message field [cy]
    bufferOffset = _serializer.float32(obj.cy, buffer, bufferOffset);
    // Serialize message field [w]
    bufferOffset = _serializer.float32(obj.w, buffer, bufferOffset);
    // Serialize message field [h]
    bufferOffset = _serializer.float32(obj.h, buffer, bufferOffset);
    // Serialize message field [score]
    bufferOffset = _serializer.float32(obj.score, buffer, bufferOffset);
    // Serialize message field [category]
    bufferOffset = _serializer.string(obj.category, buffer, bufferOffset);
    // Serialize message field [category_id]
    bufferOffset = _serializer.int32(obj.category_id, buffer, bufferOffset);
    // Serialize message field [tracked_id]
    bufferOffset = _serializer.int32(obj.tracked_id, buffer, bufferOffset);
    // Serialize message field [px]
    bufferOffset = _serializer.float32(obj.px, buffer, bufferOffset);
    // Serialize message field [py]
    bufferOffset = _serializer.float32(obj.py, buffer, bufferOffset);
    // Serialize message field [pz]
    bufferOffset = _serializer.float32(obj.pz, buffer, bufferOffset);
    // Serialize message field [los_ax]
    bufferOffset = _serializer.float32(obj.los_ax, buffer, bufferOffset);
    // Serialize message field [los_ay]
    bufferOffset = _serializer.float32(obj.los_ay, buffer, bufferOffset);
    // Serialize message field [yaw_a]
    bufferOffset = _serializer.float32(obj.yaw_a, buffer, bufferOffset);
    // Serialize message field [mode]
    bufferOffset = _serializer.bool(obj.mode, buffer, bufferOffset);
    // Serialize message field [sim_score]
    bufferOffset = _serializer.float32(obj.sim_score, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Target
    let len;
    let data = new Target(null);
    // Deserialize message field [cx]
    data.cx = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [cy]
    data.cy = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [w]
    data.w = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [h]
    data.h = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [score]
    data.score = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [category]
    data.category = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [category_id]
    data.category_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [tracked_id]
    data.tracked_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [px]
    data.px = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [py]
    data.py = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [pz]
    data.pz = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [los_ax]
    data.los_ax = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [los_ay]
    data.los_ay = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [yaw_a]
    data.yaw_a = _deserializer.float32(buffer, bufferOffset);
    // Deserialize message field [mode]
    data.mode = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [sim_score]
    data.sim_score = _deserializer.float32(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.category);
    return length + 61;
  }

  static datatype() {
    // Returns string type for a message object
    return 'px_uav_msgs/Target';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return '3623dd3b471832f212700e5baf3ce9ed';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
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
    
    
    
    
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Target(null);
    if (msg.cx !== undefined) {
      resolved.cx = msg.cx;
    }
    else {
      resolved.cx = 0.0
    }

    if (msg.cy !== undefined) {
      resolved.cy = msg.cy;
    }
    else {
      resolved.cy = 0.0
    }

    if (msg.w !== undefined) {
      resolved.w = msg.w;
    }
    else {
      resolved.w = 0.0
    }

    if (msg.h !== undefined) {
      resolved.h = msg.h;
    }
    else {
      resolved.h = 0.0
    }

    if (msg.score !== undefined) {
      resolved.score = msg.score;
    }
    else {
      resolved.score = 0.0
    }

    if (msg.category !== undefined) {
      resolved.category = msg.category;
    }
    else {
      resolved.category = ''
    }

    if (msg.category_id !== undefined) {
      resolved.category_id = msg.category_id;
    }
    else {
      resolved.category_id = 0
    }

    if (msg.tracked_id !== undefined) {
      resolved.tracked_id = msg.tracked_id;
    }
    else {
      resolved.tracked_id = 0
    }

    if (msg.px !== undefined) {
      resolved.px = msg.px;
    }
    else {
      resolved.px = 0.0
    }

    if (msg.py !== undefined) {
      resolved.py = msg.py;
    }
    else {
      resolved.py = 0.0
    }

    if (msg.pz !== undefined) {
      resolved.pz = msg.pz;
    }
    else {
      resolved.pz = 0.0
    }

    if (msg.los_ax !== undefined) {
      resolved.los_ax = msg.los_ax;
    }
    else {
      resolved.los_ax = 0.0
    }

    if (msg.los_ay !== undefined) {
      resolved.los_ay = msg.los_ay;
    }
    else {
      resolved.los_ay = 0.0
    }

    if (msg.yaw_a !== undefined) {
      resolved.yaw_a = msg.yaw_a;
    }
    else {
      resolved.yaw_a = 0.0
    }

    if (msg.mode !== undefined) {
      resolved.mode = msg.mode;
    }
    else {
      resolved.mode = false
    }

    if (msg.sim_score !== undefined) {
      resolved.sim_score = msg.sim_score;
    }
    else {
      resolved.sim_score = 0.0
    }

    return resolved;
    }
};

module.exports = Target;
