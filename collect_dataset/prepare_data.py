import cv2
import os
import numpy as np
from moviepy.editor import VideoFileClip
import moviepy.video.fx.all as vfx

target_width = 900
target_height = 600
max_frames = 30
frame_count = 0

DATA_PATH = os.path.join('prepared_data')
no_sequences = 30
sequence_length = 30
actions = np.array(["Forward", "Backward", "Start", "Stop"])


def check_video_values(action: str, sequence: str, input_video_path: str):
    cap = cv2.VideoCapture(input_video_path)
    original_fps, original_total_frames = cap.get(
        cv2.CAP_PROP_FPS), cap.get(cv2.CAP_PROP_FRAME_COUNT)
    print(
        f"Action: {action} - file: {sequence}.mp4 - fps: {original_fps} - total_frames: {original_total_frames}")


def makeOutputDirs():
    for action in actions:
        for sequence in range(no_sequences):
            try:
                os.makedirs(os.path.join(DATA_PATH, action))
                os.makedirs(os.path.join(f"{DATA_PATH}/Final_Result", action))
            except:
                pass


def change_fps_color_size():
    for action in actions:
        for sequence in range(no_sequences):
            input_video_path = os.path.join(
                f"raw_data/nhan_data", action, "{}.mp4".format(sequence))
            output_video_path = f'{DATA_PATH}/{action}/{sequence}.mp4'

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


def change_duration():
    for action in actions:
        for sequence in range(no_sequences):
            input_video_path = f'{DATA_PATH}/{action}/{sequence}.mp4'
            output_video_path = f'{DATA_PATH}/Final_Result/{action}/{sequence}.mp4'

            video = VideoFileClip(input_video_path)
            original_duration = video.duration
            target_duration = 2

            # Change speed of video
            speed_change_video = video.fx(
                vfx.speedx, original_duration / target_duration)
            speed_change_video.write_videofile(output_video_path)
            check_video_values(action, sequence, output_video_path)


if __name__ == "__main__":
    makeOutputDirs()
    change_fps_color_size()
    change_duration()
