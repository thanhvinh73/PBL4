import numpy as np
import os
import matplotlib.pyplot as plt
from sklearn.metrics import multilabel_confusion_matrix, accuracy_score, ConfusionMatrixDisplay
from keras.utils import to_categorical
from keras.models import Sequential, Model
from keras.callbacks import TensorBoard
from sklearn.model_selection import train_test_split
from public_data import actions, no_sequences, sequence_length, load_model, load_model_rnn
from keras.layers import LSTM, Dense
import seaborn as sns

DATA_PATH = os.path.join('numpy_data')
DATA_TEST_PATH = os.path.join('numpy_data_test')

label_map = {label: num for num, label in enumerate(actions)}
sequences, labels = [], []
for action in actions:
    for sequence in range(0,135):
        window = []
        for frame_num in range(sequence_length):
            res = np.load(os.path.join(DATA_PATH, action, str(
                sequence), "{}.npy".format(frame_num)))
            window.append(res)
        sequences.append(window)
        labels.append(label_map[action])
X = np.array(sequences)
y = to_categorical(labels).astype(int)
X_train, X_test, y_train, y_test = train_test_split(X, y, test_size=0.2)
# print(np.array(sequences).shape)
print(X_train.shape)
print(X_test.shape)
print(y_train.shape)
print(y_test.shape)

# label_map = {label: num for num, label in enumerate(actions)}
# sequences, labels = [], []
# for action in actions:
#     for sequence in range(90,110):
#         window = []
#         for frame_num in range(sequence_length):
#             res = np.load(os.path.join(DATA_PATH, action, str(
#                 sequence), "{}.npy".format(frame_num)))
#             window.append(res)
#         sequences.append(window)
#         labels.append(label_map[action])
# X_test = np.array(sequences)
# y_test = to_categorical(labels).astype(int)

# no_sequences_test = 25
# label_map = {label: num for num, label in enumerate(actions)}
# sequences, labels = [], []
# for action in actions:
#     for sequence in range(100,135):
#         window = []
#         for frame_num in range(sequence_length):
#             res = np.load(os.path.join(DATA_PATH, action, str(
#                 sequence), "{}.npy".format(frame_num)))
#             window.append(res)
#         sequences.append(window)
#         labels.append(label_map[action])
# X_val = np.array(sequences)
# y_val = to_categorical(labels).astype(int)
from keras.callbacks import EarlyStopping
early_stopping = EarlyStopping(monitor='val_loss', patience=10, restore_best_weights=True)
tb_callback = TensorBoard(log_dir=os.path.join('Logs'))
from keras.optimizers import Adam
optimizer = Adam(learning_rate=0.0001)
model = load_model()
model.compile(optimizer=optimizer, loss='categorical_crossentropy',
              metrics=['categorical_accuracy'])
model.summary()
# history = model.fit(X_train, y_train, epochs= 150, callbacks=[tb_callback], validation_split=0.2)
# validation_data=(X_val,y_val)
# model.save(os.path.join('trained_model', 'actionwithvalidlstm.keras'))
# plt.plot(history.history['categorical_accuracy'], label='Train Categorical Accuracy')
# plt.plot(history.history['val_categorical_accuracy'], label='Validation Categorical Accuracy')
# plt.xlabel('Epochs')
# plt.ylabel('Categorical Accuracy')
# plt.legend()
# plt.show()
# plt.plot(history.history['loss'], label='Train Loss')
# plt.plot(history.history['val_loss'], label='Valid Loss')
# plt.xlabel('Epochs')
# plt.ylabel('Loss')
# plt.legend()
# plt.show()
model.load_weights(os.path.join(
    'trained_model', 'actionwithvalid125.keras'))


yhat = model.predict(X_test)
ytrue = np.argmax(y_test, axis=1).tolist()
yhat = np.argmax(yhat, axis=1).tolist()
print(multilabel_confusion_matrix(ytrue, yhat))
print(accuracy_score(ytrue, yhat))

conf_mat = multilabel_confusion_matrix(ytrue, yhat)
class_names = ["Forward", "Backward", "Start", "Stop"]
fig, axes = plt.subplots(nrows=2, ncols=2, figsize=(12, 10))
for i, class_name in enumerate(class_names):
    row = i // 2
    col = i % 2
    sns.heatmap(conf_mat[i], annot=True, fmt='d', cmap='viridis',
                xticklabels=["True Negative", "True Positive"],
                yticklabels=["True Negative", "True Positive"],
                annot_kws={"size": 16},
                ax=axes[row, col])
    axes[row, col].set_title(f'Confusion Matrix for Class {class_name}')
    axes[row, col].set_xlabel("Predicted Label")
    axes[row, col].set_ylabel("True Label")
plt.tight_layout()
plt.show()
# res = model.predict(X_test)
# print(actions[np.argmax(res[0])])
# print(actions[np.argmax(y_test[0])])
# y_pred = model.predict(X_train)
# y_true = np.argmax(y_train, axis=1).tolist()
# y_pred = np.argmax(y_pred, axis=1).tolist()
