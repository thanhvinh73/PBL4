import uuid
from flask_mysqldb import MySQL
from flask_jwt_extended import JWTManager
from config import Config

db = None
jwt = JWTManager()


def init_db(app):
    app.config['MYSQL_HOST'] = Config.MYSQL_HOST
    app.config['MYSQL_USER'] = Config.MYSQL_USER
    app.config['MYSQL_PASSWORD'] = Config.MYSQL_PASSWORD
    app.config['MYSQL_DB'] = Config.MYSQL_DB
    global db
    db = MySQL(app)

def get_db():
    return db
    

def uniqueid() -> str:
    return str(uuid.uuid4())


def valid_request(request, requires) -> bool:
    if len(requires) == 0:
        return True
    for require in requires:
        if not require in request:
            return False
    return True

