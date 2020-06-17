# grayscale conversion experiments

from PIL import Image
import matplotlib.pyplot as plt

img = Image.open("Dalai_Lama.jpg")
img.show()

histograms = []

# "L" is grayscale mode, thus interpreting all pixel values as a
# shade of gray 

def displayGrayScaledImage(pixels):
    grayScaleImg = Image.new("L", (img.size[0], img.size[1]), 255)
    grayScaleImg.putdata(pixels)
    grayScaleImg.show()

    histograms.append(grayScaleImg.histogram())

# by averaging the R,G,B values (notice how the image gets encoded in a
# single banded channel, related to the average of the image's original
# 3 channels, and how the mode of the image is such that each pixel,
# represented by a single integer ranging from 0 to 255, stands for a
# color in the grayscale spectrum -- thus the questions becomes not
# whether or not to have an image grayscaled, but how to have it best).

def getRGBAverage(pixel):
    return int((pixel[0] + pixel[1] + pixel[2])/3)

averagedPixels = []

for pixel in list(img.getdata()):
    averagedPixels.append(getRGBAverage(pixel))

displayGrayScaledImage(averagedPixels)

# by obtaining the luminosity (luma 601 / luma 709). Luma pursuits
# the luminosity of a pixel, characterizing it accordingly to the
# different degrees of luminosity from all red, green and blue
# (thus the different coefficients). The luma 709 transform
# attempts to also consider the change in displaying technologies. 

def getLuminosity(pixel, model):
    if model == 601:
        return int((299/1000)*pixel[0] + (587/1000)*pixel[1] + (114/1000)*pixel[2])
    elif model == 709:
        return int((212/1000)*pixel[0] + (715/1000)*pixel[1] + (72/1000)*pixel[2])

# luma 601

luminosityOfPixels = []

for pixel in list(img.getdata()):
    luminosityOfPixels.append(getLuminosity(pixel, 601))

displayGrayScaledImage(luminosityOfPixels)

# luma 709

luminosityOfPixels = []

for pixel in list(img.getdata()):
    luminosityOfPixels.append(getLuminosity(pixel, 709))

displayGrayScaledImage(luminosityOfPixels)

# histograms representative of each approach to gray scale. 
# the left values indicate more darkness, while the right 
# ones more clarity -- how stereotypical.

figure, axes = plt.subplots(3)
axes[0].bar(list(range(256)), histograms[0])
axes[0].set_title("RGB Average")
axes[1].bar(list(range(256)), histograms[1])
axes[1].set_title("luma 601")
axes[2].bar(list(range(256)), histograms[2])
axes[2].set_title("luma 712")
plt.show()

