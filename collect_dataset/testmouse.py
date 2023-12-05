import mediapipe as mp
import cv2
import numpy as np
from mediapipe.framework.formats import landmark_pb2
import time
from math import sqrt
import win32api
import pyautogui

import websocket 
 
websock_url = "ws://192.168.39.158/Camera"
ws = websocket.WebSocket()
ws.connect(websock_url)
while ws.connected:
    img = np.asanyarray(bytearray(ws.recv())) 
    im = cv2.imdecode(img, cv2.IMREAD_COLOR)
    
    cv2.imshow("image", im)
    cv2.waitKey(10)


