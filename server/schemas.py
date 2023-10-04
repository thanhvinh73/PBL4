from marshmallow import fields, Schema

class UserScheme(Schema):
    id = fields.String()
    username = fields.String()
    password = fields.String()
    email = fields.String()