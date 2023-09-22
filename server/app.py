from flask import Flask, request
from flask_cors import CORS, cross_origin
import pyautogui


app = Flask(__name__)
CORS(app)
app.config['CORS_HEADERS'] = 'Content-Type'

# init variables
screenWidth, screenHeight = pyautogui.size()
currentMouseX, currentMouseY = pyautogui.position()
pyautogui.FAILSAFE = True

@app.route("/")
def home():
    return "Hello world"

@app.route("/next", methods=["GET"])
def next_slide():
    pyautogui.press(keys=pyautogui.RIGHT)
    return {"status": 200}

@app.route("/back", methods=["GET"])
def back_slide():
    pyautogui.press(keys=pyautogui.LEFT)
    return {"status": 200}

@app.route("/start", methods=["GET"])
def start_slide():
    pyautogui.press(keys='f5')
    return {"status": 200}

@app.route("/stop", methods=["GET"])
def stop_slide():
    pyautogui.press(keys='esc')
    return {"status": 200}








if (__name__) == "__main__":
    app.run(debug=True)
