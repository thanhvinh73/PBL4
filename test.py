#pip install tensorflow opencv-python mediapipe sklearn matplotlib scikit-learn
import cv2
import numpy as np
import os
from matplotlib import pyplot as plt
import time
import mediapipe as mp
from sklearn.model_selection import train_test_split
from keras.utils import to_categorical

from keras.models import Sequential
from keras.layers import LSTM,Dense
from keras.callbacks import TensorBoard
#NHỚ BẤM Q VÀO CHƯƠNG TRÌNH ĐỂ TẮT

DATA_PATH = os.path.join('MP_Data')

actions = np.array(["Forward","Backward","Start","Stop"])

#30 video chứa data
no_sequences = 60

#video sẽ mang 30 frames
sequence_length = 30

#Tạo thư mục data tương ứng với actions
for action in actions:
    for sequence in range(no_sequences):
        try:
            os.makedirs(os.path.join(DATA_PATH,action,str(sequence)))
        except:
            pass
        


#Holistic Model nhận diện đối tượng và drawing util vẽ ra các line tương ứng 
mp_holistic = mp.solutions.holistic #Holistic model https://github.com/google/mediapipe/blob/master/docs/solutions/holistic.md
mp_drawing = mp.solutions.drawing_utils # Drawing utilities

#https://www.youtube.com/watch?v=doDUihpj6ro&t=422s 15:40 bắt đầu giải thích, 28:50 có demo xem chuyển màu
#tóm tắt là chuyển màu bình thường về một dạng màu khác (ko rõ có phải là trắng đen hay ko) để tiết kiệm bộ nhớ 
def mediapipe_detection(image,model):
    image = cv2.cvtColor(image, cv2.COLOR_BGR2RGB) #Đổi màu lượt đầu
    image.flags.writeable = False
    results = model.process(image)
    image.flags.writeable = True
    image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR) #Đổi màu lại như cũ
    return image, results

# vẽ các line lên màn hình
def draw_landmarks(image, results):
    mp_drawing.draw_landmarks(image, results.face_landmarks, mp_holistic.FACEMESH_CONTOURS) #Vẽ các điểm nối mặt , có thể dùng FACEMESH_TESSELATION thay thế
    mp_drawing.draw_landmarks(image, results.pose_landmarks, mp_holistic.POSE_CONNECTIONS) #Vẽ các điểm nối dáng
    mp_drawing.draw_landmarks(image, results.left_hand_landmarks, mp_holistic.HAND_CONNECTIONS) #Vẽ các điểm tay trái
    mp_drawing.draw_landmarks(image, results.right_hand_landmarks, mp_holistic.HAND_CONNECTIONS) #Vẽ các điểm tay phải
# Như trên nhưng đổi màu và độ dày các đường vẽ
def draw_styled_landmarks(image,results):
    mp_drawing.draw_landmarks(image, results.face_landmarks, mp_holistic.FACEMESH_CONTOURS,
                              mp_drawing.DrawingSpec(color=(80,110,10), thickness=1, circle_radius=1),
                              mp_drawing.DrawingSpec(color=(80,256,121), thickness=1, circle_radius=1)) #Vẽ các điểm nối mặt , có thể dùng FACEMESH_TESSELATION thay thế
    mp_drawing.draw_landmarks(image, results.pose_landmarks, mp_holistic.POSE_CONNECTIONS,
                              mp_drawing.DrawingSpec(color=(80,22,10), thickness=2, circle_radius=4),
                              mp_drawing.DrawingSpec(color=(80,44,121), thickness=2, circle_radius=2)) #Vẽ các điểm nối dáng
    mp_drawing.draw_landmarks(image, results.left_hand_landmarks, mp_holistic.HAND_CONNECTIONS,
                              mp_drawing.DrawingSpec(color=(121,22,76), thickness=2, circle_radius=4),
                              mp_drawing.DrawingSpec(color=(121,44,250), thickness=2, circle_radius=2)) #Vẽ các điểm tay trái
    mp_drawing.draw_landmarks(image, results.right_hand_landmarks, mp_holistic.HAND_CONNECTIONS,
                              mp_drawing.DrawingSpec(color=(245,117,66), thickness=2, circle_radius=4),
                              mp_drawing.DrawingSpec(color=(245,66,230), thickness=2, circle_radius=2)) #Vẽ các điểm tay phải
    
#Lấy ra các điểm nối https://www.youtube.com/watch?v=doDUihpj6ro&t=422s 40:00 có giải thích
def extract_keypoints(results):
    pose = np.array([[res.x,res.y,res.z,res.visibility] for res in results.pose_landmarks.landmark]).flatten() if results.pose_landmarks else np.zeros(132)
    face = np.array([[res.x,res.y,res.z] for res in results.face_landmarks.landmark]).flatten() if results.face_landmarks else np.zeros(1404)
    lh = np.array([[res.x,res.y,res.z] for res in results.left_hand_landmarks.landmark]).flatten() if results.left_hand_landmarks else np.zeros(21*3)
    rh = np.array([[res.x,res.y,res.z] for res in results.right_hand_landmarks.landmark]).flatten() if results.right_hand_landmarks else np.zeros(21*3)
    return np.concatenate([pose, face, lh, rh])


print("1.Collect Data")
print("2.Mở camera")
fun = input("Vui lòng chọn việc bạn muốn làm")
if fun == "1":
    #Collect Data qua camera (Quét từng frame lấy các điểm rồi lưu nó thành 1 numpy array)
    cap = cv2.VideoCapture(0)
    with mp_holistic.Holistic(min_detection_confidence= 0.5,min_tracking_confidence= 0.5) as holistic:
        for action in actions:
            for sequence in range (no_sequences):
                for frame_num in range(sequence_length):
                    ret, frame = cap.read() #frame là hình ảnh lấy được từ camera
                    #Bắt đầu nhận diện
                    image, results = mediapipe_detection(frame, holistic)
                    print(results)
                    #Vẽ các đường nối
                    draw_styled_landmarks(image, results)
                    if frame_num == 0:
                        cv2.putText(image, 'STARTING COLLECTION', (120,200),
                                    cv2.FONT_HERSHEY_SIMPLEX,1,(0,255,0),4,cv2.LINE_AA)
                        cv2.putText(image, 'Collecting frames for {} video number {}'.format(action,sequence), (15,12),
                                    cv2.FONT_HERSHEY_SIMPLEX,0.5,(0,0,255),4,cv2.LINE_AA)
                        cv2.waitKey(2000)
                    else:
                        cv2.putText(image, 'Collecting frames for {} video number {}'.format(action,sequence), (15,12),
                                    cv2.FONT_HERSHEY_SIMPLEX,0.5,(0,0,255),4,cv2.LINE_AA)
                    keypoints = extract_keypoints(results)
                    cv2.imshow('OpenCV Feed', image)
                    npy_path = os.path.join(DATA_PATH, action, str(sequence), str(frame_num))
                    np.save(npy_path, keypoints)
                    # Tắt camera bằng nút q
                    if cv2.waitKey(10) & 0xFF == ord('q'):
                        break
        cap.release()
        cv2.destroyAllWindows()
    #####

elif fun == "2":
    # Show màn hình
    cap = cv2.VideoCapture(0)
    cap.set(cv2.CAP_PROP_FRAME_WIDTH,1280)
    cap.set(cv2.CAP_PROP_FRAME_HEIGHT,720)
    #Đặt mediapipe model https://www.youtube.com/watch?v=doDUihpj6ro&t=422s 21:00 có giải thích
    #có thể chỉnh hai thông số cho phù hợp
    with mp_holistic.Holistic(min_detection_confidence= 0.5,min_tracking_confidence= 0.5) as holistic:
        while cap.isOpened():
            ret, frame = cap.read() #frame là hình ảnh lấy được từ camera
            
            #Bắt đầu nhận diện
            image, results = mediapipe_detection(frame, holistic)
            print(results)
            
            #Vẽ các đường nối
            draw_styled_landmarks(image, results)
            
            cv2.imshow('OpenCV Feed', image)
            # Tắt camera bằng nút q
            if cv2.waitKey(10) & 0xFF == ord('q'):
                break
        cap.release()
        cv2.destroyAllWindows()
    #####
else:
    label_map = {label:num for num, label in enumerate(actions)}
    sequences, labels = [], []
    for action in actions:
        for sequence in range(no_sequences):
            window = []
            for frame_num in range(sequence_length):
                res = np.load(os.path.join(DATA_PATH, action, str(sequence), "{}.npy".format(frame_num)))
                window.append(res)
            sequences.append(window)
            labels.append(label_map[action])
    X = np.array(sequences)
    y = to_categorical(labels).astype(int)
    X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.1)
    print(np.array(sequences).shape)
    print(y_test.shape)




    log_dir = os.path.join('Logs')
    tb_callback = TensorBoard(log_dir=log_dir)

    model = Sequential()
    model.add(LSTM(64, return_sequences=True, activation='relu', input_shape=(30,1662)))
    model.add(LSTM(128, return_sequences=True, activation='relu'))
    model.add(LSTM(64, return_sequences=False, activation='relu'))
    model.add(Dense(64, activation='relu'))
    model.add(Dense(32, activation='relu'))
    model.add(Dense(actions.shape[0], activation='softmax'))

    model.compile(optimizer='Adam', loss='categorical_crossentropy', metrics=['categorical_accuracy'])
    model.fit(X_train, y_train, epochs=200, callbacks=[tb_callback])
    model.save('action.h5')

   
    
    # model.load_weights("action.h5")
    res = model.predict(X_test)
    print(actions[np.argmax(res[0])])
    print(actions[np.argmax(y_test[0])])
    from sklearn.metrics import multilabel_confusion_matrix,accuracy_score
    y_pred = model.predict(X_train)
    y_true = np.argmax(y_train,axis=1).tolist()
    y_pred = np.argmax(y_pred,axis=1).tolist()
    
    from scipy import stats
    colors = [(245,117,16), (117,245,16), (16,117,245),(16,117,245)]
    def prob_viz(res, actions, input_frame, colors):
        output_frame = input_frame.copy()
        for num, prob in enumerate(res):
            cv2.rectangle(output_frame, (0,60+num*40), (int(prob*100), 90+num*40), colors[num], -1)
            cv2.putText(output_frame, actions[num], (0, 85+num*40), cv2.FONT_HERSHEY_SIMPLEX, 1, (255,255,255), 2, cv2.LINE_AA)
        
        return output_frame
    sequence = []
    sentence = []
    predictions = []
    threshold = 0.7
    
    cap = cv2.VideoCapture(0)
    #Đặt mediapipe model https://www.youtube.com/watch?v=doDUihpj6ro&t=422s 21:00 có giải thích
    #có thể chỉnh hai thông số cho phù hợp
    with mp_holistic.Holistic(min_detection_confidence= 0.5,min_tracking_confidence= 0.5) as holistic:
        while cap.isOpened():
            ret, frame = cap.read() #frame là hình ảnh lấy được từ camera
            
            #Bắt đầu nhận diện
            image, results = mediapipe_detection(frame, holistic)
            print(results)
            
            draw_styled_landmarks(image, results)
            
            keypoints = extract_keypoints(results)
            sequence.append(keypoints)
            sequence = sequence[-30:]
            
            if len(sequence) == 30:
                res = model.predict(np.expand_dims(sequence, axis=0))[0]
                print(actions[np.argmax(res)])
                predictions.append(np.argmax(res))
            
            
        #3. Viz logic
                if np.unique(predictions[-10:])[0]==np.argmax(res): 
                    if res[np.argmax(res)] > threshold: 
                        
                        if len(sentence) > 0: 
                            if actions[np.argmax(res)] != sentence[-1]:
                                sentence.append(actions[np.argmax(res)])
                        else:
                            sentence.append(actions[np.argmax(res)])

                if len(sentence) > 5: 
                    sentence = sentence[-5:]

            # Viz probabilities
                image = prob_viz(res, actions, image, colors)
            
            cv2.rectangle(image, (0,0), (640, 40), (245, 117, 16), -1)
            cv2.putText(image, ' '.join(sentence), (3,30), 
                        cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2, cv2.LINE_AA)
            cv2.imshow('OpenCV Feed', image)
                
            if cv2.waitKey(10) & 0xFF == ord('q'):
                break
        cap.release()
        cv2.destroyAllWindows()