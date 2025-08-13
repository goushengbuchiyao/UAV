// Auto-generated. Do not edit!

// (in-package uav_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let TakeoffCommand = require('./TakeoffCommand.js');
let LandCommand = require('./LandCommand.js');
let PositionControlNEDCommand = require('./PositionControlNEDCommand.js');
let PositionControlGlobalCommand = require('./PositionControlGlobalCommand.js');
let VelocityControlNEDCommand = require('./VelocityControlNEDCommand.js');
let ReturnToLaunchCommand = require('./ReturnToLaunchCommand.js');
let HoverCommand = require('./HoverCommand.js');
let SetModeCommand = require('./SetModeCommand.js');

//-----------------------------------------------------------

class UAVControlCommand {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.command_type = null;
      this.timestamp = null;
      this.target_system = null;
      this.takeoff = null;
      this.land = null;
      this.pos_ned = null;
      this.pos_global = null;
      this.vel_ned = null;
      this.rtl = null;
      this.hover = null;
      this.set_mode = null;
    }
    else {
      if (initObj.hasOwnProperty('command_type')) {
        this.command_type = initObj.command_type
      }
      else {
        this.command_type = '';
      }
      if (initObj.hasOwnProperty('timestamp')) {
        this.timestamp = initObj.timestamp
      }
      else {
        this.timestamp = {secs: 0, nsecs: 0};
      }
      if (initObj.hasOwnProperty('target_system')) {
        this.target_system = initObj.target_system
      }
      else {
        this.target_system = 0;
      }
      if (initObj.hasOwnProperty('takeoff')) {
        this.takeoff = initObj.takeoff
      }
      else {
        this.takeoff = new TakeoffCommand();
      }
      if (initObj.hasOwnProperty('land')) {
        this.land = initObj.land
      }
      else {
        this.land = new LandCommand();
      }
      if (initObj.hasOwnProperty('pos_ned')) {
        this.pos_ned = initObj.pos_ned
      }
      else {
        this.pos_ned = new PositionControlNEDCommand();
      }
      if (initObj.hasOwnProperty('pos_global')) {
        this.pos_global = initObj.pos_global
      }
      else {
        this.pos_global = new PositionControlGlobalCommand();
      }
      if (initObj.hasOwnProperty('vel_ned')) {
        this.vel_ned = initObj.vel_ned
      }
      else {
        this.vel_ned = new VelocityControlNEDCommand();
      }
      if (initObj.hasOwnProperty('rtl')) {
        this.rtl = initObj.rtl
      }
      else {
        this.rtl = new ReturnToLaunchCommand();
      }
      if (initObj.hasOwnProperty('hover')) {
        this.hover = initObj.hover
      }
      else {
        this.hover = new HoverCommand();
      }
      if (initObj.hasOwnProperty('set_mode')) {
        this.set_mode = initObj.set_mode
      }
      else {
        this.set_mode = new SetModeCommand();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type UAVControlCommand
    // Serialize message field [command_type]
    bufferOffset = _serializer.string(obj.command_type, buffer, bufferOffset);
    // Serialize message field [timestamp]
    bufferOffset = _serializer.time(obj.timestamp, buffer, bufferOffset);
    // Serialize message field [target_system]
    bufferOffset = _serializer.int32(obj.target_system, buffer, bufferOffset);
    // Serialize message field [takeoff]
    bufferOffset = TakeoffCommand.serialize(obj.takeoff, buffer, bufferOffset);
    // Serialize message field [land]
    bufferOffset = LandCommand.serialize(obj.land, buffer, bufferOffset);
    // Serialize message field [pos_ned]
    bufferOffset = PositionControlNEDCommand.serialize(obj.pos_ned, buffer, bufferOffset);
    // Serialize message field [pos_global]
    bufferOffset = PositionControlGlobalCommand.serialize(obj.pos_global, buffer, bufferOffset);
    // Serialize message field [vel_ned]
    bufferOffset = VelocityControlNEDCommand.serialize(obj.vel_ned, buffer, bufferOffset);
    // Serialize message field [rtl]
    bufferOffset = ReturnToLaunchCommand.serialize(obj.rtl, buffer, bufferOffset);
    // Serialize message field [hover]
    bufferOffset = HoverCommand.serialize(obj.hover, buffer, bufferOffset);
    // Serialize message field [set_mode]
    bufferOffset = SetModeCommand.serialize(obj.set_mode, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type UAVControlCommand
    let len;
    let data = new UAVControlCommand(null);
    // Deserialize message field [command_type]
    data.command_type = _deserializer.string(buffer, bufferOffset);
    // Deserialize message field [timestamp]
    data.timestamp = _deserializer.time(buffer, bufferOffset);
    // Deserialize message field [target_system]
    data.target_system = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [takeoff]
    data.takeoff = TakeoffCommand.deserialize(buffer, bufferOffset);
    // Deserialize message field [land]
    data.land = LandCommand.deserialize(buffer, bufferOffset);
    // Deserialize message field [pos_ned]
    data.pos_ned = PositionControlNEDCommand.deserialize(buffer, bufferOffset);
    // Deserialize message field [pos_global]
    data.pos_global = PositionControlGlobalCommand.deserialize(buffer, bufferOffset);
    // Deserialize message field [vel_ned]
    data.vel_ned = VelocityControlNEDCommand.deserialize(buffer, bufferOffset);
    // Deserialize message field [rtl]
    data.rtl = ReturnToLaunchCommand.deserialize(buffer, bufferOffset);
    // Deserialize message field [hover]
    data.hover = HoverCommand.deserialize(buffer, bufferOffset);
    // Deserialize message field [set_mode]
    data.set_mode = SetModeCommand.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    let length = 0;
    length += _getByteLength(object.command_type);
    length += HoverCommand.getMessageSize(object.hover);
    length += SetModeCommand.getMessageSize(object.set_mode);
    return length + 144;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uav_msgs/UAVControlCommand';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'e2c2bd3cd120b68b542da3a74da209fb';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    
    string command_type
    time timestamp
    int32 target_system
    
    TakeoffCommand takeoff
    LandCommand land
    PositionControlNEDCommand pos_ned
    PositionControlGlobalCommand pos_global
    VelocityControlNEDCommand vel_ned
    ReturnToLaunchCommand rtl
    HoverCommand hover
    SetModeCommand set_mode
    
    ================================================================================
    MSG: uav_msgs/TakeoffCommand
    float64 altitude
    float64 yaw
    
    ================================================================================
    MSG: uav_msgs/LandCommand
    float64 yaw
    
    ================================================================================
    MSG: uav_msgs/PositionControlNEDCommand
    float64 x
    float64 y
    float64 z
    float64 yaw
    
    ================================================================================
    MSG: uav_msgs/PositionControlGlobalCommand
    float64 latitude
    float64 longitude
    float64 altitude
    float64 yaw
    
    ================================================================================
    MSG: uav_msgs/VelocityControlNEDCommand
    float64 vx
    float64 vy
    float64 vz
    float64 yaw_rate
    
    ================================================================================
    MSG: uav_msgs/ReturnToLaunchCommand
    float64 altitude
    
    ================================================================================
    MSG: uav_msgs/HoverCommand
    string mode
    ================================================================================
    MSG: uav_msgs/SetModeCommand
    string mode
    
    `;
  }

  static Resolve(msg) {
    // deep-construct a valid message object instance of whatever was passed in
    if (typeof msg !== 'object' || msg === null) {
      msg = {};
    }
    const resolved = new UAVControlCommand(null);
    if (msg.command_type !== undefined) {
      resolved.command_type = msg.command_type;
    }
    else {
      resolved.command_type = ''
    }

    if (msg.timestamp !== undefined) {
      resolved.timestamp = msg.timestamp;
    }
    else {
      resolved.timestamp = {secs: 0, nsecs: 0}
    }

    if (msg.target_system !== undefined) {
      resolved.target_system = msg.target_system;
    }
    else {
      resolved.target_system = 0
    }

    if (msg.takeoff !== undefined) {
      resolved.takeoff = TakeoffCommand.Resolve(msg.takeoff)
    }
    else {
      resolved.takeoff = new TakeoffCommand()
    }

    if (msg.land !== undefined) {
      resolved.land = LandCommand.Resolve(msg.land)
    }
    else {
      resolved.land = new LandCommand()
    }

    if (msg.pos_ned !== undefined) {
      resolved.pos_ned = PositionControlNEDCommand.Resolve(msg.pos_ned)
    }
    else {
      resolved.pos_ned = new PositionControlNEDCommand()
    }

    if (msg.pos_global !== undefined) {
      resolved.pos_global = PositionControlGlobalCommand.Resolve(msg.pos_global)
    }
    else {
      resolved.pos_global = new PositionControlGlobalCommand()
    }

    if (msg.vel_ned !== undefined) {
      resolved.vel_ned = VelocityControlNEDCommand.Resolve(msg.vel_ned)
    }
    else {
      resolved.vel_ned = new VelocityControlNEDCommand()
    }

    if (msg.rtl !== undefined) {
      resolved.rtl = ReturnToLaunchCommand.Resolve(msg.rtl)
    }
    else {
      resolved.rtl = new ReturnToLaunchCommand()
    }

    if (msg.hover !== undefined) {
      resolved.hover = HoverCommand.Resolve(msg.hover)
    }
    else {
      resolved.hover = new HoverCommand()
    }

    if (msg.set_mode !== undefined) {
      resolved.set_mode = SetModeCommand.Resolve(msg.set_mode)
    }
    else {
      resolved.set_mode = new SetModeCommand()
    }

    return resolved;
    }
};

module.exports = UAVControlCommand;
