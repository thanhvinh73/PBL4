import pyautogui

# get width & height of current screen
screenWidth, screenHeight = pyautogui.size()
# get position (coordinates) of mouse
currentMouseX, currentMouseY = pyautogui.position()

pyautogui.moveTo(currentMouseX, currentMouseY) # Move the mouse to XY coordinates

pyautogui.click() # Click the mouse
pyautogui.click(x=currentMouseX + 100, y=currentMouseY, duration=0.5) # Move the mouse to XY coordinates and click it


pyautogui.move(xOffset=400, yOffset=0, duration=0.5) # Move the mouse 400 pixels to the right of its current position
pyautogui.doubleClick() # Double click the mouse
pyautogui.moveTo(currentMouseX + 200, currentMouseY + 200, duration=2, tween=pyautogui.easeInQuad)  # Use tweening/easing function to move mouse over 2 seconds.

pyautogui.write(message='Hello world!', interval=0.25) # type with quarter-second pause in between each key

pyautogui.press('esc') # Press the Esc key. All key names are in pyautogui.KEY_NAMES

with pyautogui.hold('shift'):  # Press the Shift key down and hold it.
    pyautogui.press(['a', 'b', 'c', 'd'])  # Press the left arrow key 4 times.
# Shift key is released automatically.

pyautogui.hotkey('ctrl', 'c') # Press the Ctrl-C hotkey combination.

pyautogui.alert('This is the message to display.') # Make an alert box appear and pause the program until OK is clicked.
