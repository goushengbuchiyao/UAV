// Auto-generated. Do not edit!

// (in-package uav_msgs.msg)


"use strict";

const _serializer = _ros_msg_utils.Serialize;
const _arraySerializer = _serializer.Array;
const _deserializer = _ros_msg_utils.Deserialize;
const _arrayDeserializer = _deserializer.Array;
const _finder = _ros_msg_utils.Find;
const _getByteLength = _ros_msg_utils.getByteLength;
let mavros_msgs = _finder('mavros_msgs');

//-----------------------------------------------------------

class Waypoint {
  constructor(initObj={}) {
    if (initObj === null) {
      // initObj === null is a special case for deserialization where we don't initialize fields
      this.waypoint_id = null;
      this.waypoint = null;
    }
    else {
      if (initObj.hasOwnProperty('waypoint_id')) {
        this.waypoint_id = initObj.waypoint_id
      }
      else {
        this.waypoint_id = 0;
      }
      if (initObj.hasOwnProperty('waypoint')) {
        this.waypoint = initObj.waypoint
      }
      else {
        this.waypoint = new mavros_msgs.msg.Waypoint();
      }
    }
  }

  static serialize(obj, buffer, bufferOffset) {
    // Serializes a message object of type Waypoint
    // Serialize message field [waypoint_id]
    bufferOffset = _serializer.int32(obj.waypoint_id, buffer, bufferOffset);
    // Serialize message field [waypoint]
    bufferOffset = mavros_msgs.msg.Waypoint.serialize(obj.waypoint, buffer, bufferOffset);
    return bufferOffset;
  }

  static deserialize(buffer, bufferOffset=[0]) {
    //deserializes a message object of type Waypoint
    let len;
    let data = new Waypoint(null);
    // Deserialize message field [waypoint_id]
    data.waypoint_id = _deserializer.int32(buffer, bufferOffset);
    // Deserialize message field [waypoint]
    data.waypoint = mavros_msgs.msg.Waypoint.deserialize(buffer, bufferOffset);
    return data;
  }

  static getMessageSize(object) {
    return 49;
  }

  static datatype() {
    // Returns string type for a message object
    return 'uav_msgs/Waypoint';
  }

  static md5sum() {
    //Returns md5sum for a message object
    return 'a6f99f03f8a3405b686baeb3a31c59e9';
  }

  static messageDefinition() {
    // Returns full string definition for message
    return `
    int32 waypoint_id
    mavros_msgs/Waypoint waypoint
    
    ================================================================================
    MSG: mavros_msgs/Waypoint
    # Waypoint.msg
    #
    # ROS representation of MAVLink MISSION_ITEM
    # See mavlink documentation
    
    
    
    # see enum MAV_FRAME
    uint8 frame
    uint8 FRAME_GLOBAL = 0
    uint8 FRAME_LOCAL_NED = 1
    uint8 FRAME_MISSION = 2
    uint8 FRAME_GLOBAL_REL_ALT = 3
    uint8 FRAME_LOCAL_ENU = 4
    uint8 FRAME_GLOBAL_INT = 5
    uint8 FRAME_GLOBAL_RELATIVE_ALT_INT = 6
    uint8 FRAME_LOCAL_OFFSET_NED = 7
    uint8 FRAME_BODY_NED = 8
    uint8 FRAME_BODY_OFFSET_NED = 9
    uint8 FRAME_GLOBAL_TERRAIN_ALT = 10
    uint8 FRAME_GLOBAL_TERRAIN_ALT_INT = 11
    uint8 FRAME_BODY_FRD = 12
    uint8 FRAME_RESERVED_13 = 13
    uint8 FRAME_RESERVED_14 = 14
    uint8 FRAME_RESERVED_15 = 15
    uint8 FRAME_RESERVED_16 = 16
    uint8 FRAME_RESERVED_17 = 17
    uint8 FRAME_RESERVED_18 = 18
    uint8 FRAME_RESERVED_19 = 19
    uint8 FRAME_LOCAL_FRD = 20
    uint8 FRAME_LOCAL_FLU = 21
    
    # see enum MAV_CMD and CommandCode.msg
    uint16 command
    
    bool is_current
    bool autocontinue
    # meaning of this params described in enum MAV_CMD
    float32 param1
    float32 param2
    float32 param3
    float32 param4
    float64 x_lat
    float64 y_long
    float64 z_alt
    
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

    if (msg.waypoint !== undefined) {
      resolved.waypoint = mavros_msgs.msg.Waypoint.Resolve(msg.waypoint)
    }
    else {
      resolved.waypoint = new mavros_msgs.msg.Waypoint()
    }

    return resolved;
    }
};

module.exports = Waypoint;
