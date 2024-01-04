import math
import multiprocessing
import os
import time
import cv2
from flask_jwt_extended import get_jwt_identity, jwt_required
import pyautogui
import mediapipe as mp
import numpy as np
from flask import Blueprint, jsonify, request
from helpers.app_data.public_data import draw_styled_landmarks, extract_keypoints, load_model, mediapipe_detection, mp_drawing, mp_holistic
from helpers.enums.label_order import LabelOrderDefault
from models.label_order import LabelOrder
from utils import valid_request


detection_bp = Blueprint("detection", __name__)
proc = None
user_id = None


@detection_bp.route("/<userId>", methods=["POST"])
@jwt_required()
def detect(userId):
    requires = ["camera_url"]
    req = request.get_json()
    if not valid_request(req, requires):
        return jsonify({"status": 400, "error": {"code": "ERR.DETECT001", "message": "UserId and CameraUrl must not be blank!"}}), 400
    userId_token = get_jwt_identity()
    cameraUrl = req.get("camera_url")
    if userId_token != userId:
        return jsonify({
            "status": 403,
            "error": {
                "code": "ERR.TOK003",
                "message": "You don't have permission to access!",
            }
        }), 403

    labels = LabelOrder.get_labels_by_userId(userId)
    actions = [label.label for i in range(
        len(labels)) for label in labels if label.label_order == i]

    global proc, user_id
    user_id = userId
    proc = multiprocessing.Process(
        target=model_detection, args=(cameraUrl, actions))
    proc.start()
    print(f"======> MULTIPROCESSING: {proc} - {user_id}")
    return jsonify({"status": 200, "data": userId}), 200


@detection_bp.patch("/cancel")
@jwt_required()
def cancel_detection():
    userId_token = get_jwt_identity()
    global proc, user_id
    if userId_token != user_id:
        return jsonify({
            "status": 400,
            "error": {
                "code": "ERR.DETECT002",
                "message": "You don't control the presentation!",
            }
        }), 400
    print(f"======> MULTIPROCESSING: {proc} - {user_id}")
    if proc is not None and proc.is_alive():
        proc.terminate()
        return jsonify({"status": 200, "data": "Cancel successfully!"}), 200
    else:
        return jsonify({"status": 400, "error": {"code": "ERR.DETECT003", "message": "Don't have any detection thread!"}}), 400


def model_detection(url: str, actions: list):
    holis = False
    scaling_factor = 1.5
    mp_hands = mp.solutions.hands
    model = load_model()
    model.load_weights(os.path.join(
        'helpers/trained_model', 'actionwithvalid125.keras'))

    sequence = []
    last_predict = ""
    threshold = 0.7
    count_frame = 0

    print(f"http://{url}:81/stream")
    cap = cv2.VideoCapture(f"http://{url}:81/stream")
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
                            indexTip_x, indexTip_y = int(
                                indexTip.x * frame.shape[1]), int(indexTip.y * frame.shape[0])
                            middleTip_x, middleTip_y = int(
                                middleTip.x * frame.shape[1]), int(middleTip.y * frame.shape[0])
                            ringTip_x, ringTip_y = int(
                                ringTip.x * frame.shape[1]), int(ringTip.y * frame.shape[0])
                            distance_indexmid = math.sqrt(
                                (middleTip_x - indexTip_x)**2 + (middleTip_y - indexTip_y)**2)
                            distance_indexring = math.sqrt(
                                (ringTip_x - middleTip_x)**2 + (ringTip_y - middleTip_y)**2)
                            if (indexTip.y <= indexDip.y and middleTip.y <= middleDip.y and ringTip.y <= ringDip.y and pinkyTip.y > pinkyDip.y and distance_indexmid > 30):
                                holis = True
                                time.sleep(1)
                    cv2.putText(image, last_predict, (10, 30),
                                cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2, cv2.LINE_AA)
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
                            match predicted_action:
                                case LabelOrderDefault.FORWARD.name:
                                    pyautogui.press(keys=pyautogui.RIGHT)
                                case LabelOrderDefault.BACKWARD.name:
                                    pyautogui.press(keys=pyautogui.LEFT)
                                case LabelOrderDefault.START.name:
                                    pyautogui.press(keys='f5')
                                case LabelOrderDefault.STOP.name:
                                    pyautogui.press(keys='esc')

                            holis = False
                        else:
                            print("NONE")
                        # Reset the sequence for the next 30 frames
                        sequence = []
                    cv2.imshow('OpenCV Feed', image)
                # Tắt camera bằng nút q
                if cv2.waitKey(10) & 0xFF == ord('q'):
                    break
            cap.release()
            cv2.destroyAllWindows()
