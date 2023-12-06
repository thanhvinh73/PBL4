from enum import Enum


class MainAction(Enum):
    LEFT = 0
    RIGHT = 1
    LEFT_AND_RIGHT = 2


def get_main_action(action: str) -> MainAction:
    match action:
        case "FORWARD":
            return MainAction.RIGHT
        case "Backward":
            return MainAction.LEFT
        case "Start":
            return MainAction.RIGHT
        case "Stop":
            return MainAction.LEFT
