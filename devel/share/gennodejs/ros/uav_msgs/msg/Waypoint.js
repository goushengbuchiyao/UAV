// Auto-generated. Do not edit!

// (in-package uav_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;

//-----------------------------------------------------------

class Waypoint {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.waypoint_id = null;
      this.frame = null;
      this.command = null;
      this.latitude = null;
      this.longitude = null;
      this.altitude = null;
      this.is_current = null;
      this.autocontinue = null;
      this.hold_time = null;
    }
    else {
      if (initObj.hasOwnProperty('waypoint_id')) {
        this.waypoint_id = initObj.waypoint_id
      }
      else {
        this.waypoint_id = 0;
      }
      if (initObj.hasOwnProperty('frame')) {
        this.frame = initObj.frame
      }
      else {
        this.frame = '';
      }
      if (initObj.hasOwnProperty('command')) {
        this.command = initObj.command
      }
      else {
        this.command = '';
      }
      if (initObj.hasOwnProperty('latitude')) {
        this.latitude = initObj.latitude
      }
      else {
        this.latitude = 0.0;
      }
      if (initObj.hasOwnProperty('longitude')) {
        this.longitude = initObj.longitude
      }
      else {
        this.longitude = 0.0;
      }
      if (initObj.hasOwnProperty('altitude')) {
        this.altitude = initObj.altitude
      }
      else {
        this.altitude = 0.0;
      }
      if (initObj.hasOwnProperty('is_current')) {
        this.is_current = initObj.is_current
      }
      else {
        this.is_current = false;
      }
      if (initObj.hasOwnProperty('autocontinue')) {
        this.autocontinue = initObj.autocontinue
      }
      else {
        this.autocontinue = false;
      }
      if (initObj.hasOwnProperty('hold_time')) {
        this.hold_time = initObj.hold_time
      }
      else {
        this.hold_time = 0.0;
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Waypoint
    // Serialize message field [waypoint_id]
    bufferOffset = _serializer.int32(obj.waypoint_id, buffer, bufferOffset);
    // Serialize message field [frame]
    bufferOffset = _serializer.string(obj.frame, buffer, bufferOffset);
    // Serialize message field [command]
    bufferOffset = _serializer.string(obj.command, buffer, bufferOffset);
    // Serialize message field [latitude]
    bufferOffset = _serializer.float64(obj.latitude, buffer, bufferOffset);
    // Serialize message field [longitude]
    bufferOffset = _serializer.float64(obj.longitude, buffer, bufferOffset);
    // Serialize message field [altitude]
    bufferOffset = _serializer.float64(obj.altitude, buffer, bufferOffset);
    // Serialize message field [is_current]
    bufferOffset = _serializer.bool(obj.is_current, buffer, bufferOffset);
    // Serialize message field [autocontinue]
    bufferOffset = _serializer.bool(obj.autocontinue, buffer, bufferOffset);
    // Serialize message field [hold_time]
    bufferOffset = _serializer.float64(obj.hold_time, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Waypoint
    let len;
    let data = new Waypoint(null);
    // Deserialize message field [waypoint_id]
    data.waypoint_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [frame]
    data.frame = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [command]
    data.command = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [latitude]
    data.latitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [longitude]
    data.longitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [altitude]
    data.altitude = _deserializer.float64(buffer, bufferOffset);
    // Deserialize message field [is_current]
    data.is_current = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [autocontinue]
    data.autocontinue = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [hold_time]
    data.hold_time = _deserializer.float64(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.frame);
    length += _getByteLength(object.command);
    return length + 46;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uav_msgs/Waypoint';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'd3f2cf73442657b7c4a745798b838c76';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 waypoint_id          # 航点ID
    string frame               # 坐标系类型
    string command             # 航点指令类型
    float64 latitude           # 纬度 (度)
    float64 longitude          # 经度 (度)
    float64 altitude           # 高度 (米)
    bool is_current            # 是否为当前航点
    bool autocontinue          # 是否自动继续到下一个航点
    float64 hold_time          # 悬停时间 (秒)
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new Waypoint(null);
    if (msg.waypoint_id !== undefined) {
      resolved.waypoint_id = msg.waypoint_id;
    }
    else {
      resolved.waypoint_id = 0
    }

    if (msg.frame !== undefined) {
      resolved.frame = msg.frame;
    }
    else {
      resolved.frame = ''
    }

    if (msg.command !== undefined) {
      resolved.command = msg.command;
    }
    else {
      resolved.command = ''
    }

    if (msg.latitude !== undefined) {
      resolved.latitude = msg.latitude;
    }
    else {
      resolved.latitude = 0.0
    }

    if (msg.longitude !== undefined) {
      resolved.longitude = msg.longitude;
    }
    else {
      resolved.longitude = 0.0
    }

    if (msg.altitude !== undefined) {
      resolved.altitude = msg.altitude;
    }
    else {
      resolved.altitude = 0.0
    }

    if (msg.is_current !== undefined) {
      resolved.is_current = msg.is_current;
    }
    else {
      resolved.is_current = false
    }

    if (msg.autocontinue !== undefined) {
      resolved.autocontinue = msg.autocontinue;
    }
    else {
      resolved.autocontinue = false
    }

    if (msg.hold_time !== undefined) {
      resolved.hold_time = msg.hold_time;
    }
    else {
      resolved.hold_time = 0.0
    }

    return resolved;
    }
};

module.exports = Waypoint;
