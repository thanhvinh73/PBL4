import os
import time
import cv2
import pandas as pd
import numpy as np
import mediapipe as mp
import pyautogui
from public_data import actions, mp_holistic, mp_drawing, mediapipe_detection, draw_styled_landmarks, extract_keypoints, load_model, normalize_video

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
    scaling_factor = 1.5
    mp_hands = mp.solutions.hands
    model = load_model()
    model.load_weights(os.path.join(
        'trained_model', 'actionwithvalid125.keras'))

    sequence = []
    threshold = 0.7
    count_frame = 0
    
    cap = cv2.VideoCapture("http://192.168.107.158:81/stream")
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
                                indexTip = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y
                                indexDip = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_DIP].y
                                middleTip = hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_TIP].y
                                middleDip = hand_landmarks.landmark[mp_hands.HandLandmark.MIDDLE_FINGER_DIP].y
                                ringTip = hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_TIP].y
                                ringDip = hand_landmarks.landmark[mp_hands.HandLandmark.RING_FINGER_DIP].y
                                pinkyTip = hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_TIP].y
                                pinkyDip = hand_landmarks.landmark[mp_hands.HandLandmark.PINKY_DIP].y
                                if indexTip <= indexDip  and middleTip <= middleDip and ringTip <= ringDip and pinkyTip > pinkyDip:
                                    holis = True
                                    time.sleep(1)
                                screen_width, screen_height = pyautogui.size()
                                bbox_xmin = 0.5 - 480 / screen_width
                                bbox_ymin = 0.5 - 270 / screen_height
                                bbox_xmax = 0.5 + 480 / screen_width
                                bbox_ymax = 0.5 + 270 / screen_height
                                if indexTip <= indexDip and middleTip > middleDip and ringTip > ringDip and pinkyTip > pinkyDip:
                                    x = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].x
                                    y = hand_landmarks.landmark[mp_hands.HandLandmark.INDEX_FINGER_TIP].y
                                    rel_x = x - bbox_xmin
                                    rel_y = y - bbox_ymin
                                    scaled_x = rel_x * scaling_factor
                                    scaled_y = rel_y * scaling_factor
                                    final_x = bbox_xmin + scaled_x
                                    final_y = bbox_ymin + scaled_y
                                    if final_x < 0:
                                        final_x = 0
                                    elif final_x > 1:
                                        final_x = 1

                                    if final_y < 0:
                                        final_y = 0
                                    elif final_y > 1:
                                        final_y = 1
                                    if bbox_xmin <= x <= bbox_xmax and bbox_ymin <= y <= bbox_ymax:
                                        pyautogui.moveTo(
                                            final_x * screen_width, final_y * screen_height)
                                    else:
                                        pass
                                cv2.rectangle(image, (int(bbox_xmin * image.shape[1]), int(bbox_ymin * image.shape[0])), (int(
                                    bbox_xmax * image.shape[1]), int(bbox_ymax * image.shape[0])), (0, 255, 0), 2)
                        cv2.imshow('OpenCV Feed', image)
                    else:
                        image, results = mediapipe_detection(frame, holistic)
                        draw_styled_landmarks(image, results)
                        sequence.append(extract_keypoints(results))
                        if len(sequence) == 30:
                            res = model.predict(np.expand_dims(sequence, axis=0))[0]
                            if res[np.argmax(res)] > threshold:
                                predicted_action = actions[np.argmax(res)]
                                print(predicted_action, res[np.argmax(res)], np.argmax(res))
                                match np.argmax(res):
                                    case 0:
                                        pyautogui.press('right')
                                    case 1:
                                        pyautogui.press('left')
                                    case 2: 
                                        pyautogui.hotkey('alt','f5')
                                    case 3:
                                        pyautogui.press('esc')    
                                    
                                holis = False
                            
                            # Reset the sequence for the next 30 frames
                            sequence = []
                        cv2.imshow('OpenCV Feed', image)
                    # Tắt camera bằng nút q
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
            #   index=False, header=False)
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
