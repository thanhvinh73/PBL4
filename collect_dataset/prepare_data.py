import os
from public_data import actions, normalize_video, no_sequences


DATA_INPUT_PATH = os.path.join('raw_data')
DATA_OUTPUT_PATH = os.path.join('prepared_data')


def makeOutputDirs():
    for action in actions:
        try:
            os.makedirs(os.path.join(DATA_OUTPUT_PATH, action))
            os.makedirs(os.path.join(
                f"{DATA_OUTPUT_PATH}/Final_Result", action))
        except:
            pass


if __name__ == "__main__":
    makeOutputDirs()
    normalize_video(DATA_INPUT_PATH, DATA_OUTPUT_PATH,
                    total_videos=no_sequences)
