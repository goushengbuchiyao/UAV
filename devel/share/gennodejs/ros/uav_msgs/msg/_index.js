
"use strict";

let UAVControlCommand = require('./UAVControlCommand.js');
let HoverCommand = require('./HoverCommand.js');
let ROI = require('./ROI.js');
let WaypointsCommand = require('./WaypointsCommand.js');
let TakeoffCommand = require('./TakeoffCommand.js');
let PositionControlGlobalCommand = require('./PositionControlGlobalCommand.js');
let Target = require('./Target.js');
let TargetsInFrame = require('./TargetsInFrame.js');
let SetModeCommand = require('./SetModeCommand.js');
let VelocityControlNEDCommand = require('./VelocityControlNEDCommand.js');
let PositionControlNEDCommand = require('./PositionControlNEDCommand.js');
let LandCommand = require('./LandCommand.js');
let ReturnToLaunchCommand = require('./ReturnToLaunchCommand.js');
let Waypoint = require('./Waypoint.js');

module.exports = {
  UAVControlCommand: UAVControlCommand,
  HoverCommand: HoverCommand,
  ROI: ROI,
  WaypointsCommand: WaypointsCommand,
  TakeoffCommand: TakeoffCommand,
  PositionControlGlobalCommand: PositionControlGlobalCommand,
  Target: Target,
  TargetsInFrame: TargetsInFrame,
  SetModeCommand: SetModeCommand,
  VelocityControlNEDCommand: VelocityControlNEDCommand,
  PositionControlNEDCommand: PositionControlNEDCommand,
  LandCommand: LandCommand,
  ReturnToLaunchCommand: ReturnToLaunchCommand,
  Waypoint: Waypoint,
};
