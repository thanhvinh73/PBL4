from enum import Enum

class Roles(Enum):
    USER = 'USER'
    ADMIN = 'ADMIN'
    
    @classmethod
    def from_string(cls, role_str):
        for role in Roles:
            if role_str == role.name:
                return role
        return None
    
    def __str__(self) -> str:
        return self.name