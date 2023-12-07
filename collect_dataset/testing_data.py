import math
import os
import time
import cv2
import pandas as pd
import numpy as np
import mediapipe as mp
import pyautogui
from public_data import actions, mp_holistic, mp_drawing, mediapipe_detection, draw_styled_landmarks, extract_keypoints, load_model, normalize_video, load_model_rnn
DATA_PATH = os.path.join("data_test")
DATA_OUTPUT_PATH = os.path.join("data_test/prepared")
DATA_INPUT_PATH = os.path.join("data_test/raw")
no_sequences_tesing_data = 13


def makeOutputDirs():
    for action in actions:
        try:
            os.makedirs(os.path.join(DATA_OUTPUT_PATH, action))
            os.makedirs(os.path.join(
                f"{DATA_OUTPUT_PATH}/Final_Result", action))
        except:
            pass


def label_prediction(res) -> str:
    percent = res[np.argmax(res)]
    if percent < 0.7:
        return "No action"
    return actions[np.argmax(res)]


def print_prediction_to_csv(action: str, sequence: str, res):
    print(
        f"Actual Action: {action} - File: {sequence}.mp4 - Prediction: {label_prediction(res)}: {res[np.argmax(res)]}")
    df = pd.DataFrame({
        "Actual action": [action],
        "File": [f"{sequence}.mp4"],
        "Prediction": [label_prediction(res)],
        "Max_predict_percent": [res[np.argmax(res)]],
        "Percent_sumary": [f"{res}"]
    })
    df.to_csv(f"{DATA_PATH}/testing_data.csv",
              mode="a", header=False, index=False)


def testing_live():
    holis = False
    mp_hands = mp.solutions.hands
    model = load_model()
    model.load_weights(os.path.join(
        'trained_model', 'actionwithvalid125.keras'))
    last_predict = ""
    sequence = []
    threshold = 0.7

    cap = cv2.VideoCapture(0)
    cap.set(cv2.CAP_PROP_FRAME_WIDTH, 900)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT, 600)
    with mp_holistic.Holistic(min_detection_confidence=0.5, min_tracking_confidence=0.5) as holistic:
        with mp_hands.Hands(
                min_detection_confidence=0.5,
                min_tracking_confidence=0.5) as hands:
            while cap.isOpened():
                ret, frame = cap.read()  # frame là hình ảnh lấy được từ camera
                if (holis == False):
                    image, results = mediapipe_detection(frame, hands)
                    if results.multi_hand_landmarks:
                        for hand_landmarks in results.multi_hand_landmarks:
                            mp_drawing.draw_landmarks(
                                image, hand_landmarks, mp_hands.HAND_CONNECTIONS)
                            indexTip = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP]
                            indexDip = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_DIP]
                            middleTip = hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_TIP]
                            middleDip = hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_DIP]
                            ringTip = hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_TIP]
                            ringDip = hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_DIP]
                            pinkyTip = hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_TIP]
                            pinkyDip = hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_DIP]
                            indexTip_x, indexTip_y = int(indexTip.x * frame.shape[1]), int(indexTip.y * frame.shape[0])
                            middleTip_x, middleTip_y = int(middleTip.x * frame.shape[1]), int(middleTip.y * frame.shape[0])
                            ringTip_x, ringTip_y = int(ringTip.x * frame.shape[1]), int(ringTip.y * frame.shape[0])
                            distance_indexmid = math.sqrt((middleTip_x - indexTip_x)**2 + (middleTip_y - indexTip_y)**2)
                            distance_indexring = math.sqrt((ringTip_x - middleTip_x)**2 + (ringTip_y - middleTip_y)**2)
                            if (indexTip.y <= indexDip.y and middleTip.y <= middleDip.y and ringTip.y <= ringDip.y and pinkyTip.y > pinkyDip.y and distance_indexmid > 30):
                                holis = True
                                time.sleep(1)
                    cv2.putText(image, last_predict, (10, 30), cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2, cv2.LINE_AA)
                    cv2.imshow('OpenCV Feed', image)
                else:
                    image, results = mediapipe_detection(frame, holistic)
                    draw_styled_landmarks(image, results)
                    sequence.append(extract_keypoints(results))
                    if len(sequence) == 30:
                        res = model.predict(
                            np.expand_dims(sequence, axis=0))[0]
                        if res[np.argmax(res)] > threshold:
                            predicted_action = actions[np.argmax(res)]
                            print(predicted_action,
                                  res[np.argmax(res)], np.argmax(res))
                            last_predict = predicted_action
                            match np.argmax(res):
                                case 0:
                                    pyautogui.press('right')
                                case 1:
                                    pyautogui.press('left')
                                case 2:
                                    pyautogui.hotkey('alt', 'f5')
                                case 3:
                                    pyautogui.press('esc')
                            holis = False
                        sequence = []
                    cv2.imshow('OpenCV Feed', image)
                if cv2.waitKey(10) & 0xFF == ord('q'):
                    break
            cap.release()
            cv2.destroyAllWindows()


def testing():

    predictions = []
    sequence = []
    model = load_model()
    model.load_weights(os.path.join(
        'trained_model', 'action_85.keras'))
    correct_prediction_counter = []
    for action in actions:
        counter = 0
        for no_sequence in range(no_sequences_tesing_data):
            cap = cv2.VideoCapture(
                f"{DATA_OUTPUT_PATH}/Final_Result/{action}/{no_sequence}.mp4")

            with mp_holistic.Holistic(min_detection_confidence=0.5, min_tracking_confidence=0.5) as holistic:
                while cap.isOpened():
                    for frame_num in range(30):
                        ret, frame = cap.read()
                        image, results = mediapipe_detection(frame, holistic)
                        draw_styled_landmarks(image, results)
                        keypoints = extract_keypoints(results)
                        sequence.append(keypoints)
                        sequence = sequence[-30:]
                        cv2.imshow('OpenCV Feed', image)

                        if cv2.waitKey(25) & 0xFF == ord("q"):
                            break

                    res = model.predict(np.expand_dims(sequence, axis=0))[0]
                    print_prediction_to_csv(action, no_sequence, res)
                    if (action == actions[np.argmax(res)]):
                        counter += 1
                    predictions.append(np.argmax(res))
                    cap.release()
                    cv2.destroyAllWindows()
        correct_prediction_counter.append(counter)

    pd.DataFrame({
        "actions": actions,
        "total_video": np.full(4, no_sequences_tesing_data),
        "correct": correct_prediction_counter}).to_csv(f"{DATA_PATH}/test_data_sumary.csv", index=False)


if __name__ == "__main__":
    # data = {"Actual_action": ["Actual_action"],
    #         "File": ["File"],
    #         "Prediction": ["Prediction"],
    #         "Max_predict_percent": ["Max_predict_percent"],
    #         "Percent_sumary": ["Percent_sumary"]}
    # df = pd.DataFrame(data)
    # df.to_csv(f"{DATA_PATH}/testing_data.csv",
    #           index=False, header=False)
    print("-------------- TESTING MODEL --------------")
    print("   0. With preparing data")
    print("   1. Without preparing data")
    print("   2. Live")
    fun = input("Your choice: ")
    if fun == "0":
        # makeOutputDirs()
        # normalize_video(DATA_INPUT_PATH, DATA_OUTPUT_PATH,
        #                 total_videos=no_sequences_tesing_data)
        testing()
    elif fun == "1":
        testing()
    elif fun == "2":
        testing_live()
