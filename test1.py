import cv2
import numpy as np
import os
from matplotlib import pyplot as plt
import time
import mediapipe as mp
import requests

ESP32_CAMERA_IP = 'http://192.168.1.9'

def get_frame_from_esp32_camera():
    try:
        response = requests.get(ESP32_CAMERA_IP)
        frame_data = np.frombuffer(response.content, dtype=np.uint8)
        frame = cv2.imdecode(frame_data, cv2.IMREAD_COLOR)
        print('nikola')
        return frame
    except Exception as e:
        print(f"Error fetching frame from ESP32 camera: {e}")
        return None
while True:
    get_frame_from_esp32_camera()
