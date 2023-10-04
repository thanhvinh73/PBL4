from flask import Blueprint, jsonify, request
from flask_jwt_extended import (create_access_token, 
                                create_refresh_token, 
                                jwt_required, 
                                get_jwt, 
                                get_jwt_identity,
                                current_user)
from werkzeug.security import generate_password_hash
from models.user import User
from models.token_block_list import TokenBlockList

from utils import uniqueid, valid_request

auth_bp = Blueprint("auth", __name__)

@auth_bp.route("/register", methods=["POST"])
def register():
    requires = ["username", "password"]
    req = request.get_json()
    if not valid_request(req, requires):
        return jsonify({"status": 400, "error":{"code": "ERR.AUTH001"}}), 400
    user = User.get_user_by_username(username=req.get('username'))
    if user is not None:
        return jsonify({"status": 400, "error":{"code": "ERR.AUTH002"}}), 403

    new_user = User(
        id=uniqueid(),
        username=req.get("username"),
        password=generate_password_hash(req.get("password")),
        email=req.get("email")
    )
    new_user.save()
        
    return jsonify({"status": 200, "data": new_user.toJson()}), 200

@auth_bp.route("/refresh-token", methods=["GET"])
@jwt_required(refresh=True)
def refresh_token():
    identity = get_jwt_identity()
    new_access_token = create_access_token(identity=identity)
    return jsonify({
        "status": 200,
        "data": {
                "access_token": new_access_token,
                "refresh_token": create_refresh_token(identity=identity),
        }
    }), 200

@auth_bp.route("/login", methods=["POST"])
def login():
    requires = ["username", "password"]
    req = request.get_json()
    if not valid_request(req, requires):
        return jsonify({"status": 400, "error":{"code": "ERR.AUTH001"}}), 400
    user = User.get_user_by_username(username=req.get('username'))
    if user and (user.check_password(password=req.get("password"))):
        return jsonify({
            "status": 200,
            "data": {
                "access_token": create_access_token(identity=user.username),
                "refresh_token": create_refresh_token(identity=user.username),
            }
        }), 200
    return jsonify({
        "status": 400,
        "error": {
            "code": "ERR.AUTH003"
        }
    }), 400

@auth_bp.route("/revoke", methods=["POST"])
@jwt_required(verify_type=False)
def logout():
    jwt = get_jwt()
    jti = jwt['jti']
    token_type = jwt['type']

    token_b = TokenBlockList(
        id=uniqueid(),
        jti=jti)
    token_b.save()

    return jsonify({
        "status": 200,
        "data": token_b.toJson()
    }), 200

@auth_bp.route("/whoami", methods=["GET"])
@jwt_required()
def whoami():
    return jsonify({
        "message": "Hello world!",
        "user_details": current_user.username
    }), 200
