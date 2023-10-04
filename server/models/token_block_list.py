from datetime import datetime
from utils import get_db
class TokenBlockList:
    def __init__(self, id, jti, create_at = datetime.now().microsecond):
        self.id = id
        self.jti = jti
        self.create_at = create_at

    def __repr__(self) -> str:
        return f"<Token {self.jti}>"
    
    def toJson(self):
        return {
            "id": self.id,
            "jti": self.jti,
            "create_at": self.create_at,
        }
    
    @classmethod
    def check_token_in(cls, jti) -> bool:
        cursor = get_db().connection.cursor()
        cursor.execute('SELECT * FROM token_block_list where jti = %s', [jti])
        token_in_block_list = cursor.fetchone()
        return token_in_block_list is not None
    
    def save(self):
        db = get_db()
        cursor = db.connection.cursor()
        cursor.execute('INSERT INTO token_block_list VALUES (%s, %s, %s)', [self.id, self.jti, self.create_at])
        db.connection.commit()
        cursor.close()