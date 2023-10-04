import os

class Config(object):
    SERVER_HOST = str(os.environ.get("SERVER_HOST"))
    CORS_HEADERS = "Content-Type"
    MYSQL_HOST = "localhost"
    MYSQL_USER = "root"
    MYSQL_PASSWORD = ""
    MYSQL_DB = "pbl4_presentation_controller"

    