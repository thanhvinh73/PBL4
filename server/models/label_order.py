from utils import get_db
from helpers.enums.label_order import LabelOrderDefault

class LabelOrder:
    def __init__(self, userId, label_order, label):
        self.userId = userId
        self.label_order = label_order
        self.label = label

    def __repr__(self) -> str:
        return f"<User 'userId': {self.userId},'label_order': {self.label_order},'label': {self.label}>"
    
    def toJson(self):
        return {
            "userId": self.userId,
            "label_order": self.label_order,
            "label": self.label
        }
    
    
    @classmethod
    def get_labels_by_userId(cls, userId):
        cursor = get_db().connection.cursor()
        cursor.execute('SELECT * FROM label_order WHERE userId = %s', [userId])
        labelOrders = cursor.fetchall()
        result = []
        for labelOrder in labelOrders:
            result.append(LabelOrder(userId=labelOrder[0], label_order=labelOrder[1], label=labelOrder[2]))
        return result
    
    @classmethod
    def create_default_label_order(cls, userId):
        if userId is None:
            return
        result = []
        for labelDefault in LabelOrderDefault:
            labelOrder = LabelOrder(userId=userId, label_order=labelDefault.value, label=labelDefault.name)
            labelOrder.save()
            result.append(labelOrder)
        return result
    
    @classmethod
    def change_order(cls, userId, label: LabelOrderDefault, label_1: LabelOrderDefault):
        if label is None or label_1 is None: 
            return
        db = get_db()
        cursor = db.connection.cursor()
        cursor.execute('UPDATE label_order SET label_order = %s WHERE userId = %s and label = %s', [label_1.value, userId, label.name])
        db.connection.commit()
        cursor.execute('UPDATE label_order SET label_order = %s WHERE userId = %s and label = %s', [label.value, userId, label_1.name])
        db.connection.commit()
        cursor.close()

    def save(self):
        db = get_db()
        cursor = db.connection.cursor()
        cursor.execute('INSERT INTO label_order (userId, label_order, label) VALUES (%s, %s, %s)', [self.userId, int(self.label_order), self.label])
        db.connection.commit()
        cursor.close()

    def delete(self):
        db = get_db()
        cursor = db.connection.cursor()
        cursor.execute('DELETE FROM label_order WHERE id = %s', [self.id])
        db.connection.commit()
        cursor.close()

        
