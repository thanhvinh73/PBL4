from flask import Blueprint, request, jsonify
from flask_jwt_extended  import jwt_required, get_jwt
from models.user import User
from schemas import UserScheme

user_bp = Blueprint("users", __name__)

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
                "code": "ERR.AUTH006",
                "message": "You don't have permission to access!",
            }
        }), 401
