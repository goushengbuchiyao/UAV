# This Python file uses the following encoding: utf-8
"""autogenerated by genpy from px_uav_msgs/UGVCommand.msg. Do not edit."""
import codecs
import sys
python3 = True if sys.hexversion > 0x03000000 else False
import genpy
import struct

import std_msgs.msg

class UGVCommand(genpy.Message):
  _md5sum = "b962762976e3397032e3506cd36fbcbc"
  _type = "px_uav_msgs/UGVCommand"
  _has_header = True  # flag to mark the presence of a Header object
  _full_text = """std_msgs/Header header

## 控制命令的编号 防止接收到错误命令， 编号应该逐次递加
uint32 Command_ID

## 控制命令的模式 
uint8 Mode
# enum Mode 控制模式枚举
uint8 Hold=0
uint8 Direct_Control_BODY=1
uint8 Direct_Control_ENU=2
uint8 Point_Control=3
uint8 Path_Control=4
uint8 Test=5

float32[2] position_ref     ## [m]
float32 yaw_ref             ## [rad]

float32[2] linear_vel       ## [m/s]
float32 angular_vel         ## [rad/s]



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
"""
  # Pseudo-constants
  Hold = 0
  Direct_Control_BODY = 1
  Direct_Control_ENU = 2
  Point_Control = 3
  Path_Control = 4
  Test = 5

  __slots__ = ['header','Command_ID','Mode','position_ref','yaw_ref','linear_vel','angular_vel']
  _slot_types = ['std_msgs/Header','uint32','uint8','float32[2]','float32','float32[2]','float32']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.

    The available fields are:
       header,Command_ID,Mode,position_ref,yaw_ref,linear_vel,angular_vel

    :param args: complete set of field values, in .msg order
    :param kwds: use keyword arguments corresponding to message field names
    to set specific fields.
    """
    if args or kwds:
      super(UGVCommand, self).__init__(*args, **kwds)
      # message fields cannot be None, assign default values for those that are
      if self.header is None:
        self.header = std_msgs.msg.Header()
      if self.Command_ID is None:
        self.Command_ID = 0
      if self.Mode is None:
        self.Mode = 0
      if self.position_ref is None:
        self.position_ref = [0.] * 2
      if self.yaw_ref is None:
        self.yaw_ref = 0.
      if self.linear_vel is None:
        self.linear_vel = [0.] * 2
      if self.angular_vel is None:
        self.angular_vel = 0.
    else:
      self.header = std_msgs.msg.Header()
      self.Command_ID = 0
      self.Mode = 0
      self.position_ref = [0.] * 2
      self.yaw_ref = 0.
      self.linear_vel = [0.] * 2
      self.angular_vel = 0.

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    :param buff: buffer, ``StringIO``
    """
    try:
      _x = self
      buff.write(_get_struct_3I().pack(_x.header.seq, _x.header.stamp.secs, _x.header.stamp.nsecs))
      _x = self.header.frame_id
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self
      buff.write(_get_struct_IB().pack(_x.Command_ID, _x.Mode))
      buff.write(_get_struct_2f().pack(*self.position_ref))
      _x = self.yaw_ref
      buff.write(_get_struct_f().pack(_x))
      buff.write(_get_struct_2f().pack(*self.linear_vel))
      _x = self.angular_vel
      buff.write(_get_struct_f().pack(_x))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    :param str: byte array of serialized message, ``str``
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      if self.header is None:
        self.header = std_msgs.msg.Header()
      end = 0
      _x = self
      start = end
      end += 12
      (_x.header.seq, _x.header.stamp.secs, _x.header.stamp.nsecs,) = _get_struct_3I().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.header.frame_id = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.header.frame_id = str[start:end]
      _x = self
      start = end
      end += 5
      (_x.Command_ID, _x.Mode,) = _get_struct_IB().unpack(str[start:end])
      start = end
      end += 8
      self.position_ref = _get_struct_2f().unpack(str[start:end])
      start = end
      end += 4
      (self.yaw_ref,) = _get_struct_f().unpack(str[start:end])
      start = end
      end += 8
      self.linear_vel = _get_struct_2f().unpack(str[start:end])
      start = end
      end += 4
      (self.angular_vel,) = _get_struct_f().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    :param buff: buffer, ``StringIO``
    :param numpy: numpy python module
    """
    try:
      _x = self
      buff.write(_get_struct_3I().pack(_x.header.seq, _x.header.stamp.secs, _x.header.stamp.nsecs))
      _x = self.header.frame_id
      length = len(_x)
      if python3 or type(_x) == unicode:
        _x = _x.encode('utf-8')
        length = len(_x)
      buff.write(struct.Struct('<I%ss'%length).pack(length, _x))
      _x = self
      buff.write(_get_struct_IB().pack(_x.Command_ID, _x.Mode))
      buff.write(self.position_ref.tostring())
      _x = self.yaw_ref
      buff.write(_get_struct_f().pack(_x))
      buff.write(self.linear_vel.tostring())
      _x = self.angular_vel
      buff.write(_get_struct_f().pack(_x))
    except struct.error as se: self._check_types(struct.error("%s: '%s' when writing '%s'" % (type(se), str(se), str(locals().get('_x', self)))))
    except TypeError as te: self._check_types(ValueError("%s: '%s' when writing '%s'" % (type(te), str(te), str(locals().get('_x', self)))))

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    :param str: byte array of serialized message, ``str``
    :param numpy: numpy python module
    """
    if python3:
      codecs.lookup_error("rosmsg").msg_type = self._type
    try:
      if self.header is None:
        self.header = std_msgs.msg.Header()
      end = 0
      _x = self
      start = end
      end += 12
      (_x.header.seq, _x.header.stamp.secs, _x.header.stamp.nsecs,) = _get_struct_3I().unpack(str[start:end])
      start = end
      end += 4
      (length,) = _struct_I.unpack(str[start:end])
      start = end
      end += length
      if python3:
        self.header.frame_id = str[start:end].decode('utf-8', 'rosmsg')
      else:
        self.header.frame_id = str[start:end]
      _x = self
      start = end
      end += 5
      (_x.Command_ID, _x.Mode,) = _get_struct_IB().unpack(str[start:end])
      start = end
      end += 8
      self.position_ref = numpy.frombuffer(str[start:end], dtype=numpy.float32, count=2)
      start = end
      end += 4
      (self.yaw_ref,) = _get_struct_f().unpack(str[start:end])
      start = end
      end += 8
      self.linear_vel = numpy.frombuffer(str[start:end], dtype=numpy.float32, count=2)
      start = end
      end += 4
      (self.angular_vel,) = _get_struct_f().unpack(str[start:end])
      return self
    except struct.error as e:
      raise genpy.DeserializationError(e)  # most likely buffer underfill

_struct_I = genpy.struct_I
def _get_struct_I():
    global _struct_I
    return _struct_I
_struct_2f = None
def _get_struct_2f():
    global _struct_2f
    if _struct_2f is None:
        _struct_2f = struct.Struct("<2f")
    return _struct_2f
_struct_3I = None
def _get_struct_3I():
    global _struct_3I
    if _struct_3I is None:
        _struct_3I = struct.Struct("<3I")
    return _struct_3I
_struct_IB = None
def _get_struct_IB():
    global _struct_IB
    if _struct_IB is None:
        _struct_IB = struct.Struct("<IB")
    return _struct_IB
_struct_f = None
def _get_struct_f():
    global _struct_f
    if _struct_f is None:
        _struct_f = struct.Struct("<f")
    return _struct_f
