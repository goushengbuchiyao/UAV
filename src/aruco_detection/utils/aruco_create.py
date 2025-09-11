#!usr/bin/env python3
# -*- coding: utf-8 -*-
# cv4.7.0
import cv2
import numpy as np
from cv2 import aruco
import os

# script_dir = os.path.dirname(os.path.abspath(__file__))
# save_path = os.path.join(script_dir, "nested_aruco_19_43.png")

# # 生成嵌套的ArUco标记（内外层标记）
# # 创建ArUco字典
# dictionary = aruco.getPredefinedDictionary(aruco.DICT_6X6_1000)

# # cv 4.7.0
# # # 生成内外层标记
# # outer_marker = aruco.drawMarker(dictionary, 18, 800)  # ID=1, 尺寸200x200
# # inner_marker = aruco.drawMarker(dictionary, 1, 80)  # ID=2, 尺寸100x100

# # cv 4.12.0
# markerImage_out = np.zeros((800, 800), dtype=np.uint8)
# markerImage_in = np.zeros((80, 80), dtype=np.uint8)
# outer_marker = aruco.generateImageMarker(dictionary, 19, 800, markerImage_out, 1)
# inner_marker = aruco.generateImageMarker(dictionary, 43, 80, markerImage_in, 1)

# # 创建嵌套标记（将内层标记放置在外层标记中心）
# offset = 50  # 内外层间距
# nested_marker = outer_marker.copy()
# # nested_marker[110:190,360:440] = inner_marker
# nested_marker[360:440,360:440] = inner_marker
# # 保存结果到脚本目录
# cv2.imwrite(save_path, nested_marker)


# 349 43 
# 1 2 3 4
# 120 120 560
# 四角+嵌套二维码
script_dir = os.path.dirname(os.path.abspath(__file__))
save_path = os.path.join(script_dir, "nested_aruco_349_43-1-2-3-4.png")

# 生成嵌套的ArUco标记（内外层标记）
# 创建ArUco字典
dictionary = aruco.getPredefinedDictionary(aruco.DICT_6X6_1000)

# cv 4.7.0
# # 生成内外层标记
# outer_marker = aruco.drawMarker(dictionary, 18, 800)  # ID=1, 尺寸200x200
# inner_marker = aruco.drawMarker(dictionary, 1, 80)  # ID=2, 尺寸100x100

# cv 4.12.0
# 820*820
markerImage_ = np.full((820, 820), 255, dtype=np.uint8)
markerImage_out = np.zeros((560, 560), dtype=np.uint8)
markerImage_in_center = np.zeros((56, 56), dtype=np.uint8)
marker_Image_in_1 = np.zeros((120, 120), dtype=np.uint8)
marker_Image_in_2 = np.zeros((120, 120), dtype=np.uint8)
marker_Image_in_3 = np.zeros((120, 120), dtype=np.uint8)

markerImage_1 = np.zeros((120, 120), dtype=np.uint8)
markerImage_2 = np.zeros((120, 120), dtype=np.uint8)
markerImage_3 = np.zeros((120, 120), dtype=np.uint8)
markerImage_4 = np.zeros((120, 120), dtype=np.uint8)

marker_1 = aruco.generateImageMarker(dictionary, 1, 120, markerImage_1, 1)
marker_2 = aruco.generateImageMarker(dictionary, 2, 120, markerImage_2, 1)
marker_3 = aruco.generateImageMarker(dictionary, 3, 120, markerImage_3, 1)
marker_4 = aruco.generateImageMarker(dictionary, 4, 120, markerImage_4, 1)

outer_marker = aruco.generateImageMarker(dictionary, 349, 560, markerImage_out, 1)
inner_marker_center = aruco.generateImageMarker(dictionary, 43, 56, markerImage_in_center, 1)
marker_Image_in_1 = aruco.generateImageMarker(dictionary, 79, 56, marker_Image_in_1, 1)
marker_Image_in_2 = aruco.generateImageMarker(dictionary, 80, 56, marker_Image_in_2, 1)
marker_Image_in_3 = aruco.generateImageMarker(dictionary, 81, 56, marker_Image_in_3, 1)

# 创建嵌套标记（将内层标记放置在外层标记中心）
nested_marker = outer_marker.copy()
# nested_marker[110:190,360:440] = inner_marker
# 28 280 252
nested_marker[252:308,252:308] = inner_marker_center
# 560/8=70 7 70-28 49 112
nested_marker[77:133,112:168] = marker_Image_in_1
# 210 252 259
nested_marker[77:133,252:308] = marker_Image_in_2
# 350 392 399
nested_marker[77:133,392:448] = marker_Image_in_3

markerImage_[130:690,130:690] = nested_marker
markerImage_[10:130,10:130] = marker_1
markerImage_[10:130,690:810] = marker_2
markerImage_[690:810,10:130] = marker_3
markerImage_[690:810,690:810] = marker_4

# 保存结果到脚本目录
cv2.imwrite(save_path, markerImage_)