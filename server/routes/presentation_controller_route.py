from flask import Blueprint, jsonify
import pyautogui

presentation_controller_bp = Blueprint("presentation_controller", __name__)


# init variables
screenWidth, screenHeight = pyautogui.size()
currentMouseX, currentMouseY = pyautogui.position()
pyautogui.FAILSAFE = True


@presentation_controller_bp.route("/")
def home():
    return jsonify({"status": 200}), 200


@presentation_controller_bp.route("/next", methods=["POST"])
def next_slide():
    pyautogui.press(keys=pyautogui.RIGHT)
    return jsonify({"status": 200}), 200


@presentation_controller_bp.route("/back", methods=["POST"])
def back_slide():
    pyautogui.press(keys=pyautogui.LEFT)
    return jsonify({"status": 200}), 200


@presentation_controller_bp.route("/start", methods=["POST"])
def start_slide():
    pyautogui.press(keys='f5')
    return jsonify({"status": 200}), 200


@presentation_controller_bp.route("/stop", methods=["POST"])
def stop_slide():
    pyautogui.press(keys='esc')
    return jsonify({"status": 200}), 200

