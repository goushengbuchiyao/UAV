#!usr/bin/env python3
# -*- coding: utf-8 -*-
# cv4.7.0
import cv2
import numpy as np
from cv2 import aruco
import os

script_dir = os.path.dirname(os.path.abspath(__file__))
save_path = os.path.join(script_dir, "nested_aruco_19_43.png")

# 生成嵌套的ArUco标记（内外层标记）
# 创建ArUco字典
dictionary = aruco.getPredefinedDictionary(aruco.DICT_6X6_1000)

# cv 4.7.0
# # 生成内外层标记
# outer_marker = aruco.drawMarker(dictionary, 18, 800)  # ID=1, 尺寸200x200
# inner_marker = aruco.drawMarker(dictionary, 1, 80)  # ID=2, 尺寸100x100

# cv 4.12.0
markerImage_out = np.zeros((800, 800), dtype=np.uint8)
markerImage_in = np.zeros((80, 80), dtype=np.uint8)
outer_marker = aruco.generateImageMarker(dictionary, 19, 800, markerImage_out, 1)
inner_marker = aruco.generateImageMarker(dictionary, 43, 80, markerImage_in, 1)

# 创建嵌套标记（将内层标记放置在外层标记中心）
offset = 50  # 内外层间距
nested_marker = outer_marker.copy()
# nested_marker[110:190,360:440] = inner_marker
nested_marker[360:440,360:440] = inner_marker
# 保存结果到脚本目录
cv2.imwrite(save_path, nested_marker)