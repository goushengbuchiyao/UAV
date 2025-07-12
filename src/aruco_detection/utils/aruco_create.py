#!usr/bin/env python3
# -*- coding: utf-8 -*-

import cv2
import numpy as np
from cv2 import aruco
import os
script_dir = os.path.dirname(os.path.abspath(__file__))
save_path = os.path.join(script_dir, "nested_aruco.png")

# 生成嵌套的ArUco标记（内外层标记）
# 创建ArUco字典
dictionary = aruco.getPredefinedDictionary(aruco.DICT_6X6_1000)

# 生成内外层标记
outer_marker = aruco.drawMarker(dictionary, 18, 800)  # ID=1, 尺寸200x200
inner_marker = aruco.drawMarker(dictionary, 1, 80)  # ID=2, 尺寸100x100

# 创建嵌套标记（将内层标记放置在外层标记中心）
offset = 50  # 内外层间距
nested_marker = outer_marker.copy()
nested_marker[110:190,360:440] = inner_marker

# 保存结果到脚本目录
cv2.imwrite(save_path, nested_marker)
