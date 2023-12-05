from enum import Enum

class LabelOrderDefault(Enum):
    FORWARD = 0
    BACKWARD = 1
    START = 2
    STOP = 3
    
    @classmethod
    def from_string(cls, label_order):
        for label in LabelOrderDefault:
            if label_order == label.name:
                return label
        return None
    
    def __str__(self) -> str:
        return self.name