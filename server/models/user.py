from werkzeug.security import check_password_hash
from utils import get_db
from helpers.enums.roles import Roles

class User:
    def __init__(self, id, username, password, email = None, role = Roles.USER, name = None):
        self.id = id
        self.username = username
        self.password = password
        self.email = email
        self.role = role
        self.name = name

    def __repr__(self) -> str:
        return f"<User 'id': {self.id},'username': {self.username},'email': {self.email},'role': {self.role.value},'name':{ self.name}>"
    
    def toJson(self):
        return {
            "id": self.id,
            "username": self.username,
            "email": self.email,
            "role": self.role.value,
            "name": self.name,
        }
    

    def check_password(self, password) -> bool:
        return check_password_hash(self.password, password)
    
    @classmethod
    def get_user_by_username(cls, username):
        cursor = get_db().connection.cursor()
        cursor.execute('SELECT * FROM user WHERE username = %s', [username])
        user = cursor.fetchone()
        if user is not None:
            return User(id=user[0], username=user[1], password=user[2], email=user[3], role=Roles.from_string(user[4]), name=user[5])
        return None
    
    @classmethod
    def get_user_by_id(cls, userId):
        cursor = get_db().connection.cursor()
        cursor.execute('SELECT * FROM user WHERE id = %s', [userId])
        user = cursor.fetchone()
        if user is not None:
            return User(id=user[0], username=user[1], password=user[2], email=user[3], role=Roles.from_string(user[4]), name=user[5])
        return None
    
    @classmethod
    def get_list_users(cls):
        cursor = get_db().connection.cursor()
        cursor.execute('SELECT * FROM user')
        listUsers = cursor.fetchall()
        result = []
        for user in listUsers:
            result.append(User(id=user[0], username=user[1], password=user[2], email=user[3], role=Roles.from_string(user[4]), name=user[5]))
        return result

    def update(self):
        db = get_db()
        cursor = db.connection.cursor()
        cursor.execute('UPDATE user SET email = %s, name = %s WHERE id = %s', [self.email, self.name, self.id])
        db.connection.commit()
        cursor.close()

        

    def save(self):
        db = get_db()
        cursor = db.connection.cursor()
        cursor.execute('INSERT INTO user (id, username, password, email, role, name) VALUES (%s, %s, %s, %s, %s, %s)', [self.id, self.username, self.password, self.email, self.role.value, self.name])
        db.connection.commit()
        cursor.close()

    def delete(self):
        db = get_db()
        cursor = db.connection.cursor()
        cursor.execute('DELETE FROM user WHERE id = %s', [self.id])
        db.connection.commit()
        cursor.close()

        
