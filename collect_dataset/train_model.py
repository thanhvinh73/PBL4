from sklearn.metrics import multilabel_confusion_matrix, accuracy_score
import numpy as np
import os
from sklearn.model_selection import train_test_split
from keras.utils import to_categorical
from keras.models import Sequential
from keras.layers import LSTM, Dense
from keras.callbacks import TensorBoard
from public_data import actions, no_sequences, sequence_length

DATA_PATH = os.path.join('numpy_data')

label_map = {label: num for num, label in enumerate(actions)}
sequences, labels = [], []
for action in actions:
    for sequence in range(no_sequences):
        window = []
        for frame_num in range(sequence_length):
            res = np.load(os.path.join(DATA_PATH, action, str(
                sequence), "{}.npy".format(frame_num)))
            window.append(res)
        sequences.append(window)
        labels.append(label_map[action])
X = np.array(sequences)
y = to_categorical(labels).astype(int)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.1)
print(np.array(sequences).shape)
print(y_test.shape)

tb_callback = TensorBoard(log_dir=os.path.join('Logs'))

model = Sequential()
model.add(LSTM(64, return_sequences=True,
               activation='relu', input_shape=(30, 258)))
model.add(LSTM(128, return_sequences=True, activation='relu'))
model.add(LSTM(64, return_sequences=False, activation='relu'))
model.add(Dense(64, activation='relu'))
model.add(Dense(32, activation='relu'))
model.add(Dense(actions.shape[0], activation='softmax'))

model.compile(optimizer='Adam', loss='categorical_crossentropy',
              metrics=['categorical_accuracy'])
model.fit(X_train, y_train, epochs=200, callbacks=[tb_callback])
model.save(os.path.join('trained_model', 'action.keras'))

# model.load_weights("action.h5")
res = model.predict(X_test)
print(actions[np.argmax(res[0])])
print(actions[np.argmax(y_test[0])])
y_pred = model.predict(X_train)
y_true = np.argmax(y_train, axis=1).tolist()
y_pred = np.argmax(y_pred, axis=1).tolist()
