import tqdm
import random
import pathlib
import itertools
import collections

import os
import cv2
import numpy as np
import remotezip as rz

import tensorflow as tf

# Some modules to display an animation using imageio. 
import imageio
from IPython import display
from urllib import request
from tensorflow_docs.vis import embed


width, height = 720, 430

cap = cv2.VideoCapture(0)
cap.set(3, width) 
cap.set(4, height)

while True:
    img = cap.read()

    cv2.imshow("Image", img)
    key = cv2.waitKey(1)
    if key == ord('q'):
        break;

