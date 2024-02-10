import os
import shutil
import time

source_dir = "/home/alpha/.config/"
destin_dir = "/home/alpha/dotfiles/"

file_name = ["wal", "pulse"]


def moveFile(file_name, source_dir, destin_dir):
    destination = os.path.join(destin_dir, file_name)
    source = os.path.join(source_dir, file_name)
    print(destination, source)
    shutil.move(source, destination)
    time.sleep(3)
    os.system(f"ln -s {destination} {source}")


for file in file_name:
    moveFile(file, source_dir, destin_dir)
