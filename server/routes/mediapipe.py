from flask import Response, Blueprint, jsonify
import cv2

mediapipe_bp = Blueprint("mediapipe", __name__)
camera = cv2.VideoCapture(0)

def generate_frames():
    while True:
        success, frame = camera.read()
        if not success:
            break
        else:
            ret, buffer = cv2.imencode('.jpg', frame)
            frame = buffer.tobytes()
        yield(b'--frame\r\n'
                    b'Content-Type: image/jpeg\r\n\r\n' + frame + b'\r\n')


@mediapipe_bp.route("/", methods=["GET"])
def mediapipe():
    return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')

# @mediapipe_bp.route("/cancel", methods=["GET"])
# def mediapipe():
#     return Response(generate_frames(), mimetype='multipart/x-mixed-replace; boundary=frame')
    



