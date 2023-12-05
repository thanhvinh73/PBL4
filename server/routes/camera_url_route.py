import time
from flask import Blueprint, jsonify, request
from models.camera_url import CameraUrl
from schemas import CameraUrlScheme
from helpers.enums.camera_url_status import CameraUrlStatus
from utils import uniqueid, valid_request

camera_url_bp = Blueprint("camera_url", __name__)

@camera_url_bp.route("/<id>", methods=["GET"])
def get_by_id(id):
    cameraUrl = CameraUrl.get_by_id(id)
    if cameraUrl is None:
        return jsonify({"status": 400, "error": {
                "code": "ERR.URL001",
                "message": "Camera Url not found!"
            }}), 400
    return jsonify({"status": 200, "data": CameraUrlScheme().dump(cameraUrl)}), 200

@camera_url_bp.route("/active", methods=["GET"])
def get_list_url_active():
    cameraUrls = CameraUrl.get_active_url()
    return jsonify({"status": 200, "data": CameraUrlScheme().dump(cameraUrls, many=True)}), 200

@camera_url_bp.route("", methods=["GET"])
def get_all():
    cameraUrls = CameraUrl.get_all()
    return jsonify({"status": 200, "data": CameraUrlScheme().dump(cameraUrls, many=True)}), 200

@camera_url_bp.patch("/<id>/inactive")
def inactive_camera_url(id):
    cameraUrl = CameraUrl.get_by_id(id)
    if cameraUrl is None:
        return jsonify({"status": 400, "error": {
                "code": "ERR.URL001",
                "message": "Camera Url not found!"
            }}), 400
    cameraUrl.status = CameraUrlStatus.INACTIVE
    try:
        cameraUrl.update()
        return jsonify({"status": 200, "data": CameraUrlScheme().dump(cameraUrl)}), 200
    except:
        return jsonify({"status": 400, "error": {
                "code": "ERR.URL002",
                "message": "Change status to inactive failed!"
            }}), 400

@camera_url_bp.post("")
def create_camera_url():
    requires = ["url", "ssid"]
    req = request.get_json()
    if not valid_request(req, requires):
        return jsonify({"status": 400, "error":{"code": "ERR.URL003"}}), 400
    try:
        cameraUrl = CameraUrl(
            id=uniqueid(),
            url=req.get('url'),
            create_at=time.time()*1000,
            status=CameraUrlStatus.ACTIVE,
            ssid=req.get("ssid")
        )
        cameraUrl.save()
        return jsonify({"status": 200, "data": CameraUrlScheme().dump(cameraUrl)}), 200
    except:
        return jsonify({"status": 400, "error": {
                "code": "ERR.URL004",
                "message": "Create camera url failed!"
            }}), 400
        
@camera_url_bp.get("/search")
def search_by_ssid():
    ssid_search = request.args.get("ssid")
    if ssid_search is None or ssid_search == "":
        cameraUrls = CameraUrl.get_active_url()
    else:
        cameraUrls = CameraUrl.get_by_ssid(ssid_search)
    return jsonify({"status": 200, "data": CameraUrlScheme().dump(cameraUrls, many=True)}), 200
    

