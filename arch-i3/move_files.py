import os
import shutil
import time

destinDir= "/home/alpha/.config/"
sourceDir= "/home/alpha/dotfiles/"

folderList = []

for folder in os.listdir(sourceDir):
    if os.path.isdir(sourceDir + folder):
        folderList.append(folder)


for folder in folderList:
    os.symlink(sourceDir + folder, destinDir + folder)
