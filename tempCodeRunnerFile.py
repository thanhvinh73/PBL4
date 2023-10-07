    # log_dir = os.path.join('Logs')
    # tb_callback = TensorBoard(log_dir=log_dir)

    # model = Sequential()
    # model.add(LSTM(64, return_sequences=True, activation='relu', input_shape=(30,1662)))
    # model.add(LSTM(128, return_sequences=True, activation='relu'))
    # model.add(LSTM(64, return_sequences=False, activation='relu'))
    # model.add(Dense(64, activation='relu'))
    # model.add(Dense(32, activation='relu'))
    # model.add(Dense(actions.shape[0], activation='softmax'))

    # model.compile(optimizer='Adam', loss='categorical_crossentropy', metrics=['categorical_accuracy'])
    # model.fit(X_train, y_train, epochs=200, callbacks=[tb_callback])
    # # model.save('action.h5')

   
    
    # model.load_weights("action.h5")
    # res = model.predict(X_test)
    # print(actions[np.argmax(res[0])])
    # print(actions[np.argmax(y_test[0])])
    # from sklearn.metrics import multilabel_confusion_matrix,accuracy_score
    # y_pred = model.predict(X_train)
    # y_true = np.argmax(y_train,axis=1).tolist()
    # y_pred = np.argmax(y_pred,axis=1).tolist()
    
    # from scipy import stats
    # colors = [(245,117,16), (117,245,16), (16,117,245),(16,117,245)]
    # def prob_viz(res, actions, input_frame, colors):
    #     output_frame = input_frame.copy()
    #     for num, prob in enumerate(res):
    #         cv2.rectangle(output_frame, (0,60+num*40), (int(prob*100), 90+num*40), colors[num], -1)
    #         cv2.putText(output_frame, actions[num], (0, 85+num*40), cv2.FONT_HERSHEY_SIMPLEX, 1, (255,255,255), 2, cv2.LINE_AA)
        
    #     return output_frame
    # sequence = []
    # sentence = []
    # predictions = []
    # threshold = 0.85
    
    # cap = cv2.VideoCapture(0)
    # #Đặt mediapipe model https://www.youtube.com/watch?v=doDUihpj6ro&t=422s 21:00 có giải thích
    # #có thể chỉnh hai thông số cho phù hợp
    # with mp_holistic.Holistic(min_detection_confidence= 0.5,min_tracking_confidence= 0.5) as holistic:
    #     while cap.isOpened():
    #         ret, frame = cap.read() #frame là hình ảnh lấy được từ camera
            
    #         #Bắt đầu nhận diện
    #         image, results = mediapipe_detection(frame, holistic)
    #         print(results)
            
    #         draw_styled_landmarks(image, results)
            
    #         keypoints = extract_keypoints(results)
    #         sequence.append(keypoints)
    #         sequence = sequence[-30:]
            
    #         if len(sequence) == 30:
    #             res = model.predict(np.expand_dims(sequence, axis=0))[0]
    #             print(actions[np.argmax(res)])
    #             predictions.append(np.argmax(res))
            
            
    #     #3. Viz logic
    #             if np.unique(predictions[-10:])[0]==np.argmax(res): 
    #                 if res[np.argmax(res)] > threshold: 
                        
    #                     if len(sentence) > 0: 
    #                         if actions[np.argmax(res)] != sentence[-1]:
    #                             sentence.append(actions[np.argmax(res)])
    #                     else:
    #                         sentence.append(actions[np.argmax(res)])

    #             if len(sentence) > 5: 
    #                 sentence = sentence[-5:]

    #         # Viz probabilities
    #             image = prob_viz(res, actions, image, colors)
            
    #         cv2.rectangle(image, (0,0), (640, 40), (245, 117, 16), -1)
    #         cv2.putText(image, ' '.join(sentence), (3,30), 
    #                     cv2.FONT_HERSHEY_SIMPLEX, 1, (255, 255, 255), 2, cv2.LINE_AA)
    #         cv2.imshow('OpenCV Feed', image)
                
    #         if cv2.waitKey(10) & 0xFF == ord('q'):
    #             break
    #     cap.release()
    #     cv2.destroyAllWindows()