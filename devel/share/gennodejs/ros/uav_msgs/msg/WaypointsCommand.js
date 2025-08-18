// Auto-generated. Do not edit!

// (in-package uav_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let Waypoint = require('./Waypoint.js');

//-----------------------------------------------------------

class WaypointsCommand {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.start_immediately = null;
      this.waypoints = null;
    }
    else {
      if (initObj.hasOwnProperty('start_immediately')) {
        this.start_immediately = initObj.start_immediately
      }
      else {
        this.start_immediately = false;
      }
      if (initObj.hasOwnProperty('waypoints')) {
        this.waypoints = initObj.waypoints
      }
      else {
        this.waypoints = [];
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type WaypointsCommand
    // Serialize message field [start_immediately]
    bufferOffset = _serializer.bool(obj.start_immediately, buffer, bufferOffset);
    // Serialize message field [waypoints]
    // Serialize the length for message field [waypoints]
    bufferOffset = _serializer.uint32(obj.waypoints.length, buffer, bufferOffset);
    obj.waypoints.forEach((val) => {
      bufferOffset = Waypoint.serialize(val, buffer, bufferOffset);
    });
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type WaypointsCommand
    let len;
    let data = new WaypointsCommand(null);
    // Deserialize message field [start_immediately]
    data.start_immediately = _deserializer.bool(buffer, bufferOffset);
    // Deserialize message field [waypoints]
    // Deserialize array length for message field [waypoints]
    len = _deserializer.uint32(buffer, bufferOffset);
    data.waypoints = new Array(len);
    for (let i = 0; i < len; ++i) {
      data.waypoints[i] = Waypoint.deserialize(buffer, bufferOffset)
    }
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    object.waypoints.forEach((val) => {
      length += Waypoint.getMessageSize(val);
    });
    return length + 5;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uav_msgs/WaypointsCommand';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'dca3761828b95042e94f1dee6fa350dd';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    bool start_immediately     # 是否立即执行航点
    Waypoint[] waypoints       # 航点列表
    ================================================================================
    MSG: uav_msgs/Waypoint
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
    const resolved = new WaypointsCommand(null);
    if (msg.start_immediately !== undefined) {
      resolved.start_immediately = msg.start_immediately;
    }
    else {
      resolved.start_immediately = false
    }

    if (msg.waypoints !== undefined) {
      resolved.waypoints = new Array(msg.waypoints.length);
      for (let i = 0; i < resolved.waypoints.length; ++i) {
        resolved.waypoints[i] = Waypoint.Resolve(msg.waypoints[i]);
      }
    }
    else {
      resolved.waypoints = []
    }

    return resolved;
    }
};

module.exports = WaypointsCommand;
