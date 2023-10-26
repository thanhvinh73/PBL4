import os
import cv2
from keras.models import Sequential
from keras.layers import LSTM, Dense
import numpy as np
from public_data import actions, mp_holistic, mediapipe_detection, draw_styled_landmarks, extract_keypoints

predictions = []
sequence = []
model = Sequential()
model.add(LSTM(64, return_sequences=True,
               activation='relu', input_shape=(30, 258)))
model.add(LSTM(128, return_sequences=True, activation='relu'))
model.add(LSTM(64, return_sequences=False, activation='relu'))
model.add(Dense(64, activation='relu'))
model.add(Dense(32, activation='relu'))
model.add(Dense(actions.shape[0], activation='softmax'))
model.load_weights(os.path.join('trained_model', 'action.keras'))

cap = cv2.VideoCapture("data_test/0.mp4")
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
        print(actions[np.argmax(res)])
        predictions.append(np.argmax(res))
        cap.release()
        cv2.destroyAllWindows()
