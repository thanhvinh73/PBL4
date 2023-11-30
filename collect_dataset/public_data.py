import os
import numpy as np
import cv2
import mediapipe as mp
from keras.models import Sequential
from keras.layers import LSTM, Dense
from moviepy.editor import VideoFileClip
import moviepy.video.fx.all as vfx
from main_action_enum import get_main_action, MainAction

no_sequences = 105
sequence_length = 30
actions = np.array(["Forward", "Backward", "Start"])


mp_holistic = mp.solutions.holistic
mp_drawing = mp.solutions.drawing_utils  # Drawing utilities


def mediapipe_detection(image, model):
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


def load_model():
    model = Sequential()
    model.add(LSTM(16, return_sequences=True,
                   activation='relu', input_shape=(30, 258)))
    # model.add(LSTM(64, return_sequences=True, activation='relu'))
    # model.add(Dropout(0.2))
    model.add(LSTM(32, return_sequences=False, activation='relu'))
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


def change_fps_color_size(data_input_path: str, data_output_path: str, total_videos: int):
    target_width = 900
    target_height = 600
    for action in actions:
        for sequence in range(total_videos):
            input_video_path = os.path.join(
                data_input_path, action, "{}.mp4".format(sequence))
            output_video_path = f'{data_output_path}/{action}/{sequence}.mp4'

            cap = cv2.VideoCapture(input_video_path)

            # Check video's original values
            check_video_values(action, sequence, input_video_path)

            new_fps = 15

            fourcc = cv2.VideoWriter_fourcc(*'mp4v')
            out = cv2.VideoWriter(output_video_path, fourcc,
                                  new_fps, (target_width, target_height))

            # Change Fps, color, size of video
            while cap.isOpened():
                ret, frame = cap.read()
                if not ret:
                    break
                frame = cv2.resize(frame, (target_width, target_height))
                frame = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
                out.write(frame)

            cap.release()
            out.release()
            cv2.destroyAllWindows()


def change_duration(data_input_path: str, data_output_path: str, total_videos: int):
    for action in actions:
        for sequence in range(total_videos):
            input_video_path = f'{data_input_path}/{action}/{sequence}.mp4'
            output_video_path = f'{data_output_path}/Final_Result/{action}/{sequence}.mp4'

            video = VideoFileClip(input_video_path)
            original_duration = video.duration
            target_duration = 2

            # Change speed of video
            speed_change_video = video.fx(
                vfx.speedx, original_duration / target_duration)
            speed_change_video.write_videofile(output_video_path)
            check_video_values(action, sequence, output_video_path)


def normalize_video(data_input_path: str, data_output_path: str, total_videos: int):
    change_fps_color_size(data_input_path, data_output_path, total_videos)
    change_duration(data_output_path, data_output_path, total_videos)
