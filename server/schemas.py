from marshmallow import fields, Schema

from helpers.enums.camera_url_status import CameraUrlStatus

class UserScheme(Schema):
    id = fields.String()
    username = fields.String()
    email = fields.String()
    role = fields.String()
    name = fields.String()
    
class CameraUrlScheme(Schema):
    id = fields.String()
    url = fields.String()
    create_at = fields.Integer()
    status = fields.String()
    ssid = fields.String()
    
class LabelOrderSchema(Schema):
    label_order = fields.Integer()
    label = fields.String()
    
