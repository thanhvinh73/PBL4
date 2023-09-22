import numpy as np
import pandas as pd

from keras.layers import LSTM, Dense, Dropout
from keras.models import Sequential

from sklearn.model_selection import train_test_split

# Đọc dữ liệu
handswing_df = pd.read_csv(filepath_or_buffer="./backup/HANDSWING.csv")

X = []
y = []
no_of_timesteps = 10

dataset = handswing_df.iloc[:, 1:].values
n_sample = len(dataset)
for i in range(no_of_timesteps, n_sample):
    X.append(dataset[i - no_of_timesteps:i, :])   
    y.append(1)

X = np.array(X)

print(X.shape)
