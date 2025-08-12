
"use strict";

let UAVControlCommand = require('./UAVControlCommand.js');
let HoverCommand = require('./HoverCommand.js');
let TakeoffCommand = require('./TakeoffCommand.js');
let PositionControlGlobalCommand = require('./PositionControlGlobalCommand.js');
let SetModeCommand = require('./SetModeCommand.js');
let VelocityControlNEDCommand = require('./VelocityControlNEDCommand.js');
let PositionControlNEDCommand = require('./PositionControlNEDCommand.js');
let LandCommand = require('./LandCommand.js');
let ReturnToLaunchCommand = require('./ReturnToLaunchCommand.js');

module.exports = {
  UAVControlCommand: UAVControlCommand,
  HoverCommand: HoverCommand,
  TakeoffCommand: TakeoffCommand,
  PositionControlGlobalCommand: PositionControlGlobalCommand,
  SetModeCommand: SetModeCommand,
  VelocityControlNEDCommand: VelocityControlNEDCommand,
  PositionControlNEDCommand: PositionControlNEDCommand,
  LandCommand: LandCommand,
  ReturnToLaunchCommand: ReturnToLaunchCommand,
};
