from werkzeug.security import check_password_hash
from utils import get_db
import json

class User:
    def __init__(self, id, username, password, email = None):
        self.id = id
        self.username = username
        self.password = password
        self.email = email

    def __repr__(self) -> str:
        return f"<User {self.username}"
    
    def toJson(self):
        return {
            "id": self.id,
            "username": self.username,
            "password": self.password,
            "email": self.email
        }
    

    def check_password(self, password) -> bool:
        return check_password_hash(self.password, password)
    
    @classmethod
    def get_user_by_username(cls, username):
        cursor = get_db().connection.cursor()
        cursor.execute('SELECT * FROM user WHERE username = %s', [username])
        user = cursor.fetchone()
        if user is not None:
            return User(id=user[0], username=user[1], password=user[2], email=user[3])
        return None
    
    @classmethod
    def get_list_users(cls):
        cursor = get_db().connection.cursor()
        cursor.execute('SELECT * FROM user')
        listUsers = cursor.fetchall()
        result = []
        for user in listUsers:
            result.append(User(id=user[0], username=user[1], password=user[2], email=user[3]))
        return result


    def save(self):
        db = get_db()
        cursor = db.connection.cursor()
        cursor.execute('INSERT INTO user VALUES (%s, %s, %s, %s)', [self.id, self.username, self.password, self.email])
        db.connection.commit()
        cursor.close()

    def delete(self):
        db = get_db()
        cursor = db.connection.cursor()
        cursor.execute('DELETE FROM user WHERE id = %s', [self.id])
        db.connection.commit()
        cursor.close()

        
