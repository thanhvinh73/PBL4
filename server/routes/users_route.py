from flask import Blueprint, request, jsonify
from flask_jwt_extended  import jwt_required, get_jwt, current_user
from models.user import User
from schemas import UserScheme

user_bp = Blueprint("users", __name__)

@user_bp.route("", methods=["GET"])
@jwt_required()
def get_user():
    if current_user is not None:
        return jsonify({
            "status": 200,
            "data": UserScheme().dump(current_user)
        }), 200
    return jsonify({
        "status": 400,
        "error": {
            "code": "ERR.USER001",
            "message": "User is not found!"
        }
    }), 400
   
@user_bp.route("/all", methods=["GET"])
@jwt_required()
def get_all_users():
    claims = get_jwt()
    if claims.get("is_admin") == True:
        users = User.get_list_users()
        result = UserScheme().dump(users, many=True)

        return jsonify({
            "status": 200,
            "usres": result
        }), 200
    return jsonify({
            "status": 401,
            "error": {
                "code": "ERR.TOK003",
                "message": "You don't have permission to access!",
            }
        }), 401
