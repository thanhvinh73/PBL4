from flask import Blueprint, jsonify, request
from flask_jwt_extended import jwt_required, get_jwt_identity
from helpers.enums.label_order import LabelOrderDefault
from models.user import User
from models.label_order import LabelOrder
from schemas import LabelOrderSchema

from utils import valid_request

label_order_bp = Blueprint("label_order", __name__)

@label_order_bp.post("/<userId>/default-label")
@jwt_required()
def create_label_default_for_user(userId):
    userId_token = get_jwt_identity()
    if userId_token != userId: 
        return jsonify({
            "status": 403,
            "error": {
                "code": "ERR.TOK003",
                "message": "You don't have permission to access!",
            }
        }), 403
    if User.get_user_by_id(userId) is None:
        return jsonify({
            "status": 400,
            "error": {
                "code": "ERR.USER001",
                "message": "User is not found!"
            }
        }), 400
    if LabelOrder.get_labels_by_userId(userId):
        return jsonify({
            "status": 400,
            "error": {
                "code": "ERR.LABEL001",
                "message": "Default label for this user was created!"
            }
        }), 400
    labelOrders = LabelOrder.create_default_label_order(userId)
    return jsonify({"status": 200, "data": LabelOrderSchema().dump(labelOrders, many=True)}), 200

@label_order_bp.get("/<userId>")
@jwt_required()
def get_labels_by_userId(userId):
    userId_token = get_jwt_identity()
    if userId_token != userId: 
        return jsonify({
            "status": 403,
            "error": {
                "code": "ERR.TOK003",
                "message": "You don't have permission to access!",
            }
        }), 403
    labels = LabelOrder.get_labels_by_userId(userId)
    return jsonify({"status": 200, "data": LabelOrderSchema().dump(labels, many=True)}), 200

@label_order_bp.patch("/<userId>/change-order")
@jwt_required()
def change_order(userId):
    userId_token = get_jwt_identity()
    requires = ["swap_labels"]
    req = request.get_json()
    if not valid_request(req, requires):
        return jsonify({"status": 400, "error":{"code": "ERR.LABEL002", "message": "Two label which were swaped is required!"}}), 400
    if userId_token != userId: 
        return jsonify({
            "status": 403,
            "error": {
                "code": "ERR.TOK003",
                "message": "You don't have permission to access!",
            }
        }), 403
    
    
    label = LabelOrderDefault.from_string(req.get("swap_labels")[0])
    label_1 = LabelOrderDefault.from_string(req.get("swap_labels")[1])
    if label is None or label_1 is None:
        return jsonify({"status": 400, "error":{"code": "ERR.LABEL003", "message": "Not found label!"}}), 400
    LabelOrder.change_order(userId, label, label_1)
    return jsonify({"status": 200, "data": LabelOrderSchema().dump(LabelOrder.get_labels_by_userId(userId), many=True)}), 200

