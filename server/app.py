from flask import Flask, jsonify
from flask_cors import CORS
from routes.auth_route import auth_bp
from routes.users_route import user_bp
from routes.presentation_controller_route import presentation_controller_bp
from routes.mediapipe import mediapipe_bp
from routes.camera_url_route import camera_url_bp
from routes.label_order_route import label_order_bp
from routes.detection_route import detection_bp
from config import Config
from utils import  init_db, jwt
from models.user import User
from models.token_block_list import TokenBlockList


def create_app():
    app = Flask(__name__)
    CORS(app)
    app.config['CORS_HEADERS'] = Config.CORS_HEADERS
    app.config["JWT_SECRET_KEY"] = "45a88190df62c88fdf9f3492" 
    app.config['SECRET_KEY'] = 'secret!'

    #initialize exts
    init_db(app)
    jwt.init_app(app)

    #register bluepints
    app.register_blueprint(auth_bp, url_prefix="/api/auth")
    app.register_blueprint(user_bp, url_prefix="/api/users")
    app.register_blueprint(presentation_controller_bp, url_prefix="/api/presentation-controller")
    app.register_blueprint(mediapipe_bp, url_prefix="/api/mediapipe")
    app.register_blueprint(camera_url_bp, url_prefix="/api/camera-url")
    app.register_blueprint(label_order_bp, url_prefix="/api/label-order")
    app.register_blueprint(detection_bp, url_prefix="/api/detection")

    
    @jwt.user_lookup_loader
    def user_lookup_callback(jwt_headers, jwt_data):
        identity = jwt_data['sub']
        return User.get_user_by_id(identity)
        
    # additional claims
    @jwt.additional_claims_loader
    def make_additional_claims(identity): 
        pass

    #JWT error handlers
    @jwt.invalid_token_loader
    def invalid_token_callback(error):
        return jsonify({
            "status": 401,
            "error": {
                "code": "ERR.TOK001",
                "message": "Signature verification failed!",
            }
        }), 401
    
    @jwt.expired_token_loader
    def expired_token_callback(jwt_header, jwt_data):
        return jsonify({
            "status": 401,
            "error": {
                "code": "ERR.TOK002",
                "message": "Token has expired!",
            }
        }), 401
    
    @jwt.unauthorized_loader
    def missing_token_callback(error):
        return jsonify({
            "status": 403,
            "error": {
                "code": "ERR.TOK003",
                "message": "You don't have permission to access!",
            }
        }), 403
    
    @jwt.token_in_blocklist_loader
    def token_in_block_list_callback(jwt_header, jwt_data):
        jti = jwt_data['jti']

        return TokenBlockList.check_token_in(jti=jti)
    
    @jwt.revoked_token_loader
    def token_revoke(jwt_header, jwt_data):
        return jsonify({
            "status": 401,
            "error": {
                "code": "ERR.TOK004",
                "message": "Token has been revoked!",
            }
        }), 401
        
    return app

if (__name__) == "__main__":
    app = create_app()
    # Handle 404 error
    @app.errorhandler(404)
    def not_found_url(e):
        return jsonify({
            "status": 404,
            "error": {
                "code": "ERR.NOTFOUND",
                "message": "URL is not found!"
            }
        }), 400

    app.run(debug=True, port=8080)