from enum import Enum

class CameraUrlStatus(Enum):
    ACTIVE = 'ACTIVE'
    INACTIVE = 'INACTIVE'
    
    @classmethod
    def from_string(cls, urlStatus_str):
        for urlStatus in CameraUrlStatus:
            if urlStatus_str == urlStatus.name:
                return urlStatus
        return None
    
    def __str__(self) -> str:
        return self.name