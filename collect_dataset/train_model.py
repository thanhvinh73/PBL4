import numpy as np
import os
from sklearn.metrics import multilabel_confusion_matrix, accuracy_score
from keras.utils import to_categorical
from keras.callbacks import TensorBoard
from public_data import actions, no_sequences, sequence_length, load_model

DATA_PATH = os.path.join('numpy_data')
DATA_TEST_PATH = os.path.join('numpy_data_test')

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
# X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.1)
# print(np.array(sequences).shape)
# print(y_test.shape)


no_sequences_test = 10
label_map = {label: num for num, label in enumerate(actions)}
sequences, labels = [], []
for action in actions:
    for sequence in range(no_sequences_test):
        window = []
        for frame_num in range(sequence_length):
            res = np.load(os.path.join(DATA_TEST_PATH, action, str(
                sequence), "{}.npy".format(frame_num)))
            window.append(res)
        sequences.append(window)
        labels.append(label_map[action])
X_test = np.array(sequences)
y_test = to_categorical(labels).astype(int)


tb_callback = TensorBoard(log_dir=os.path.join('Logs'))

model = load_model()
model.compile(optimizer='Adam', loss='categorical_crossentropy',
              metrics=['categorical_accuracy'])
# model.load_weights(os.path.join(
#     'trained_model', 'action_85.keras'))
model.fit(X, y, epochs=80, callbacks=[tb_callback])
model.save(os.path.join('trained_model', 'action1.keras'))


yhat = model.predict(X_test)
ytrue = np.argmax(y_test, axis=1).tolist()
yhat = np.argmax(yhat, axis=1).tolist()
print(multilabel_confusion_matrix(ytrue, yhat))
print(accuracy_score(ytrue, yhat))


# res = model.predict(X_test)
# print(actions[np.argmax(res[0])])
# print(actions[np.argmax(y_test[0])])
# y_pred = model.predict(X_train)
# y_true = np.argmax(y_train, axis=1).tolist()
# y_pred = np.argmax(y_pred, axis=1).tolist()
