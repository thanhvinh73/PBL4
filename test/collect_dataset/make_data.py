import cv2
import mediapipe as mp
import pandas as pd


width, height = 1280, 720

# Init mediapipe
mpPose = mp.solutions.pose
pose = mpPose.Pose()
mpDraw = mp.solutions.drawing_utils

cap = cv2.VideoCapture(0)
cap.set(3, width) 
cap.set(4, height)

lm_list = []
label = "HANDSWING"
no_of_frames = 100

def make_landmark_timestep(results):
    c_lm = []
    for index, lm in enumerate(results.pose_landmarks.landmark):
        print(lm)
        c_lm.append(lm.x)
        c_lm.append(lm.y)
        c_lm.append(lm.z)
        c_lm.append(lm.visibility)
    return c_lm

def draw_landmark_on_image(mpDraw, results, img):
    mpDraw.draw_landmarks(img, results.pose_landmarks, mpPose.POSE_CONNECTIONS)

    for index, lm in enumerate(results.pose_landmarks.landmark):
        h, w, c = img.shape
        cx, cy = int(lm.x * w), int(lm.y * h)
        cv2.circle(img, (cx, cy), 10, (0, 0, 255), cv2.FILLED)
    return img

while len(lm_list) <= no_of_frames:
    ret, frame = cap.read()
    if ret: 
        
        # recognize pose
        frameRGB = cv2.cvtColor(frame, cv2.COLOR_BGR2RGB)
        results = pose.process(frameRGB)

        if results.pose_landmarks:
            # ghi nhận thông số khung xương
            lm = make_landmark_timestep(results)
            lm_list.append(lm)  
            # vẽ khung xương lên ảnh
            frame = draw_landmark_on_image(mpDraw, results, frame)

        cv2.imshow("Image", frame)
        if cv2.waitKey(1) == ord('q'):
            break

# write to file csv
df = pd.DataFrame(lm_list)
df.to_csv(path_or_buf="./backup/" + label + ".csv")

cap.release()
cv2.destroyAllWindows()