# grayscale transformation for videos. Alternates image processing between libraries PIL and cv2

import cv2
import numpy as np
from PIL import Image
from enum import Enum

# These are the possible ways to transform the video from ordinary chromatic scale to grayscale.
class Transform(Enum):
    RGA_AVG = 1
    LUMA_601 = 2
    LUMA_709 = 3
# To transform an image to grayscale by the RGB average way
def getRGBAverage(pixel):
    return int((pixel[0] + pixel[1] + pixel[2])/3)

# To transform an image to grayscale by the luma way (either 601 or 709)
def getLuminosity(pixel, model):
    if model == 601:
        return int((299/1000)*pixel[0] + (587/1000)*pixel[1] + (114/1000)*pixel[2])
    elif model == 709:
        return int((212/1000)*pixel[0] + (715/1000)*pixel[1] + (72/1000)*pixel[2])

# To turn an image to grayscale, following the method dictated by "transform", be it either 
# Transform.RGA_AVG, Transform.LUMA_601 or Transform.LUMA_709
def turnImageToGrayScale(image, transform):
    if transform == Transform.RGA_AVG:
        transformedPixels = [getRGBAverage(pixel) for pixel in list(image.getdata())]
    elif transform == Transform.LUMA_601:
        transformedPixels = [getLuminosity(pixel, 601) for pixel in list(image.getdata())]
    elif transform == Transform.LUMA_709:
        transformedPixels = [getLuminosity(pixel, 709) for pixel in list(image.getdata())]
    else:
        return None
    grayScaleImage = Image.new("L", (image.size[0], image.size[1]), 255)
    grayScaleImage.putdata(transformedPixels)
    return grayScaleImage

# To transform a video to grayscale by turning each of its fotograms to such scale, 
# following the method dictated by "transform", be it either Transform.RGA_AVG, 
# Transform.LUMA_601 or Transform.LUMA_709
def turnVideoToGrayScale(video, transform):
    grayScaledFrames = []
    while True:
        frameWasRead, frame = video.read()
        if frameWasRead:
            img = Image.fromarray(frame)
            frame = np.asarray(turnImageToGrayScale(img, transform))      
            grayScaledFrames.append(frame)
        else:
            break
    return grayScaledFrames, video.get(cv2.CAP_PROP_FPS)

#To display a video seen as a list of frames to be shown at a frame-per-second rate
def displayVideo(frames, fps):
    cv2.namedWindow("Video", cv2.WINDOW_NORMAL)
    cv2.resizeWindow("Video", 600, 600)
    for frame in frames:
        cv2.imshow("Video", frame)
        if cv2.waitKey(int(1000/fps)) & 0xFF == ord('q'):
            break
    cv2.destroyWindow("Video")

video = cv2.VideoCapture("steps.mp4")
videoFrames, videoFPS = turnVideoToGrayScale(video, Transform.RGA_AVG) # Choose a different Transform here...
displayVideo(videoFrames, videoFPS)

    
