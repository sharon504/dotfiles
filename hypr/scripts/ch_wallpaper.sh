#!/bin/sh
dir="/home/alpha/dotfiles/hypr/.wallpapers"
BG="$(find "$dir" -name '*.jpg' -o -name '*.png' | shuf -n1)"
trans="--transition-fps 60 --transition-type outer --transition-pos 0.726,0.977 --transition-step 90
"
swww img "$BG" $trans
wal -i $(cat ~/.cache/swww/eDP-1)
bash ~/dotfiles/waybar/launch.sh
rm -rf ~/.cache/current_wallpaper
ln -s $(cat ~/.cache/swww/eDP-1) ~/.cache/current_wallpaper
echo $(cat ~/.cache/wal/colors-waybar.css) > ~/.cache/wal/colors-wlogout.css

