# A tiny frames per second (fps) demonstrative exercise

import cv2

def playVideo(videoName, multiplier=1):

    video = cv2.VideoCapture(videoName)
    videoFPS = video.get(cv2.CAP_PROP_FPS) * multiplier

    windowName = str(videoFPS) + " fps"

    cv2.namedWindow(windowName, cv2.WINDOW_NORMAL)

    cv2.resizeWindow(windowName, 600, 600)

    while True:
        frameWasRead, frame = video.read()
        if frameWasRead:
            cv2.imshow(windowName, frame)
            if cv2.waitKey(int(1000/videoFPS)) & 0xFF == ord('q'):
                break
        else:
            break

    cv2.destroyWindow(windowName)

for i in range(5):
    playVideo("Cat_Eyes_Close.mp4", i)

# Perception vs. Reality (if there's even room for such argument)

# It is a balance of measurement and display, is it not? 

# Events happen along a timespan, at a certain rate (what rate?)

# Events are captured along a timespan, at a certain rate (that is,
# a number of fotograms per second are CAPTURED)

# Events are then displayed along a timespan, at a certain rate,
# that could well be different from the capture rate (e.g., slow motion)

# Is the what part of the event is actually being captured?

# Isn't phenomenality continuous?




