import cv2
import numpy as np
import mediapipe as mp
import os
from public_data import actions, no_sequences, sequence_length, mediapipe_detection, draw_styled_landmarks, extract_keypoints, mp_holistic

DATA_INPUT_PATH = os.path.join("prepared_data/Final_Result")
DATA_OUTPUT_PATH = os.path.join("numpy_data")

for action in actions:
    for sequence in range(no_sequences):
        try:
            os.makedirs(os.path.join(
                DATA_OUTPUT_PATH, action, str(sequence)))
        except:
            pass


for action in actions:
    for sequence in range(no_sequences):
        cap = cv2.VideoCapture(os.path.join(
            DATA_INPUT_PATH, action, "{}.mp4".format(sequence)))
        with mp_holistic.Holistic(
            min_detection_confidence=0.5, min_tracking_confidence=0.5
        ) as holistic:
            while cap.isOpened():
                for frame_num in range(sequence_length):
                    ret, frame = cap.read()
                    image, results = mediapipe_detection(frame, holistic)
                    draw_styled_landmarks(image, results)
                    keypoints = extract_keypoints(results)
                    cv2.imshow('OpenCV Feed', image)
                    npy_path = os.path.join(
                        DATA_OUTPUT_PATH,  action, str(sequence), str(frame_num))
                    np.save(npy_path, keypoints)
                    print(
                        f"Action: {action} - file: {sequence}.mp4 - DONE")
                    if cv2.waitKey(25) & 0xFF == ord("q"):
                        break
                cap.release()
            cv2.destroyAllWindows()
