import os
import mediapipe as mp
import cv2
import numpy as np
from mediapipe.framework.formats import landmark_pb2
from keras.utils import plot_model
from public_data import actions, mp_holistic, mp_drawing, mediapipe_detection, draw_styled_landmarks, extract_keypoints, load_model, normalize_video, load_model_rnn

model = load_model()

model.load_weights(os.path.join(
        'trained_model', 'actionwithvalid125.keras'))

plot_model(model, to_file='model_plot.png', show_shapes=True, show_layer_names=True, show_layer_activations=True)
