from utils import get_db
from helpers.enums.camera_url_status import CameraUrlStatus

class CameraUrl:
    def __init__(self, id, url, create_at, ssid, status = CameraUrlStatus.INACTIVE):
        self.id = id
        self.url = url
        self.create_at = create_at
        self.status = status
        self.ssid = ssid

    def __repr__(self) -> str:
        return f"<User 'id': {self.id},'url': {self.url}, 'ssid': {self.ssid}, 'create_at': {self.create_at},'status': {self.status.value}>"
    
    def toJson(self):
        return {
            "id": self.id,
            "url": self.url,
            "create_at": self.create_at,
            "status": self.status.value,
            "ssid": self.ssid
        }
    
    
    @classmethod
    def get_by_id(cls, cameraUrlId):
        cursor = get_db().connection.cursor()
        cursor.execute('SELECT * FROM camera_url WHERE id = %s', [cameraUrlId])
        cameraUrl = cursor.fetchone()
        if cameraUrl is not None:
            return CameraUrl(id=cameraUrl[0], url=cameraUrl[1], create_at=cameraUrl[2], status=CameraUrlStatus.from_string(cameraUrl[3]), ssid=cameraUrl[4])
        return None
    
    @classmethod
    def get_all(cls):
        cursor = get_db().connection.cursor()
        cursor.execute('SELECT * FROM camera_url')
        listUrl = cursor.fetchall()
        result = []
        for cameraUrl in listUrl:
            result.append(CameraUrl(id=cameraUrl[0], url=cameraUrl[1], create_at=cameraUrl[2], status=CameraUrlStatus.from_string(cameraUrl[3]), ssid=cameraUrl[4]))
        return result
    
    @classmethod
    def get_active_url(cls):
        cursor = get_db().connection.cursor()
        cursor.execute('SELECT * FROM camera_url WHERE status = %s', [CameraUrlStatus.ACTIVE.value])
        listUrl = cursor.fetchall()
        result = []
        for cameraUrl in listUrl:
            result.append(CameraUrl(id=cameraUrl[0], url=cameraUrl[1], create_at=cameraUrl[2], status=CameraUrlStatus.from_string(cameraUrl[3]), ssid=cameraUrl[4]))
        return result
    
    @classmethod
    def get_by_ssid(cls, ssid):
        cursor = get_db().connection.cursor()
        likeString = "'%" + ssid + "%'"
        cursor.execute(f'SELECT * FROM camera_url WHERE ssid LIKE {likeString} AND status = "{CameraUrlStatus.ACTIVE.value}"', )
        listUrl = cursor.fetchall()
        result = []
        for cameraUrl in listUrl:
            result.append(CameraUrl(id=cameraUrl[0], url=cameraUrl[1], create_at=cameraUrl[2], status=CameraUrlStatus.from_string(cameraUrl[3]), ssid=cameraUrl[4]))
        return result

    def update(self):
        db = get_db()
        cursor = db.connection.cursor()
        cursor.execute('UPDATE camera_url SET url = %s, create_at = %s, status = %s, ssid = %s WHERE id = %s', [self.url, int(self.create_at), self.status.value, self.ssid, self.id])
        db.connection.commit()
        cursor.close()
        

    def save(self):
        db = get_db()
        cursor = db.connection.cursor()
        cursor.execute('INSERT INTO camera_url (id, url, create_at, status, ssid) VALUES (%s, %s, %s, %s, %s)', [self.id, self.url, int(self.create_at), self.status.value, self.ssid])
        db.connection.commit()
        cursor.close()

    def delete(self):
        db = get_db()
        cursor = db.connection.cursor()
        cursor.execute('DELETE FROM camera_url WHERE id = %s', [self.id])
        db.connection.commit()
        cursor.close()

        
