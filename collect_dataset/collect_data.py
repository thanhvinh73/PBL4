import cv2
import numpy as np
import mediapipe as mp
import os

DATA_INPUT_PATH = os.path.join("prepared_data/Final_Result")
DATA_OUTPUT_PATH = os.path.join("numpy_data")
mp_holistic = mp.solutions.holistic
mp_drawing = mp.solutions.drawing_utils
no_sequences = 30
sequence_length = 30
actions = np.array(["Forward", "Backward", "Start", "Stop"])

for action in actions:
    for sequence in range(no_sequences):
        try:
            os.makedirs(os.path.join(
                DATA_OUTPUT_PATH, action, str(sequence)))
        except:
            pass


def mediapipe_detection(image, model):
    # image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB)
    image.flags.writeable = False
    results = model.process(image)
    image.flags.writeable = True
    image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)
    return image, results


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
                    # cv2.imshow('OpenCV Feed', image)
                    npy_path = os.path.join(
                        DATA_OUTPUT_PATH,  action, str(sequence), str(frame_num))
                    np.save(npy_path, keypoints)
                    print(
                        f"Action: {action} - file: {sequence}.mp4 - DONE")
                    if cv2.waitKey(25) & 0xFF == ord("q"):
                        break
                cap.release()
            cv2.destroyAllWindows()
