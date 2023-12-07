import numpy as np
import cv2
from helpers.app_data.main_action_enum import MainAction, get_main_action
import mediapipe as mp
from keras.models import Sequential
from keras.layers import LSTM, Dense, SimpleRNN

no_sequences = 135
sequence_length = 30
actions = np.array(["FORWARD", "BACKWARD", "START",'STOP'])


mp_holistic = mp.solutions.holistic
mp_drawing = mp.solutions.drawing_utils  # Drawing utilities


def mediapipe_detection(image, model):
    # image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    image.flags.writeable = False
    results = model.process(image)
    image.flags.writeable = True
    image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
    return image, results


def draw_landmarks(image, results, action: str):
    if get_main_action(action) == MainAction.LEFT_AND_RIGHT:
        mp_drawing.draw_landmarks(image, results.pose_landmarks,
                                  mp_holistic.POSE_CONNECTIONS)
    mp_drawing.draw_landmarks(image, results.left_hand_landmarks,
                              mp_holistic.HAND_CONNECTIONS)
    mp_drawing.draw_landmarks(image, results.right_hand_landmarks,
                              mp_holistic.HAND_CONNECTIONS)


def draw_styled_landmarks(image, results):
    mp_drawing.draw_landmarks(
        image,
        results.pose_landmarks,
        mp_holistic.POSE_CONNECTIONS,
        mp_drawing.DrawingSpec(
            color=(80, 22, 10), thickness=2, circle_radius=4),
        mp_drawing.DrawingSpec(color=(80, 44, 121),
                               thickness=2, circle_radius=2),
    )
    mp_drawing.draw_landmarks(
        image,
        results.left_hand_landmarks,
        mp_holistic.HAND_CONNECTIONS,
        mp_drawing.DrawingSpec(color=(121, 22, 76),
                               thickness=2, circle_radius=4),
        mp_drawing.DrawingSpec(color=(121, 44, 250),
                               thickness=2, circle_radius=2),
    )
    mp_drawing.draw_landmarks(
        image,
        results.right_hand_landmarks,
        mp_holistic.HAND_CONNECTIONS,
        mp_drawing.DrawingSpec(color=(245, 117, 66),
                               thickness=2, circle_radius=4),
        mp_drawing.DrawingSpec(color=(245, 66, 230),
                               thickness=2, circle_radius=2),
    )


def extract_keypoints(results):
    pose = (
        np.array(
            [
                [res.x, res.y, res.z, res.visibility]
                for res in results.pose_landmarks.landmark
            ]
        ).flatten()
        if results.pose_landmarks
        else np.zeros(132)
    )
    lh = (
        np.array(
            [[res.x, res.y, res.z]
                for res in results.left_hand_landmarks.landmark]
        ).flatten()
        if results.left_hand_landmarks
        else np.zeros(21 * 3)
    )
    rh = (
        np.array(
            [[res.x, res.y, res.z]
                for res in results.right_hand_landmarks.landmark]
        ).flatten()
        if results.right_hand_landmarks
        else np.zeros(21 * 3)
    )
    return np.concatenate([pose, lh, rh])

from keras.layers import Dropout
def load_model():
    model = Sequential()
    model.add(LSTM(16, return_sequences=True,
                   activation='relu', input_shape=(30, 258)))
    # model.add(LSTM(64, return_sequences=True, activation='relu'))
    # model.add(Dropout(0.2))
    model.add(LSTM(32, return_sequences=False, activation='relu'))
    # model.add(LSTM(64, return_sequences=True, activation='relu'))
    model.add(Dense(16, activation='relu'))
    model.add(Dense(actions.shape[0], activation='softmax'))
    return model

def load_model_rnn():
    model = Sequential()
    model.add(SimpleRNN(16, return_sequences=True,
                   activation='relu', input_shape=(30, 258)))
    # model.add(SimpleRNN(64, return_sequences=True, activation='relu'))
    # model.add(Dropout(0.2))
    model.add(SimpleRNN(32, return_sequences=False, activation='relu'))
    # model.add(Dense(64, activation='relu'))
    model.add(Dense(16, activation='relu'))
    model.add(Dense(actions.shape[0], activation='softmax'))
    return model

def check_video_values(action: str, sequence: str, input_video_path: str):
    cap = cv2.VideoCapture(input_video_path)
    original_fps, original_total_frames = cap.get(
        cv2.CAP_PROP_FPS), cap.get(cv2.CAP_PROP_FRAME_COUNT)
    print(
        f"Action: {action} - file: {sequence}.mp4 - fps: {original_fps} - total_frames: {original_total_frames}")








