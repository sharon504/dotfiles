#!/bin/sh
wallpapersDir="/home/alpha/dotfiles/hypr/.wallpapers"
trans="--transition-fps 60 --transition-type outer --transition-step 90"
# Get a list of all image files in the wallpapers directory
wallpapers=("$wallpapersDir"/*)

# Start an infinite loop
while true; do
    # Check if the wallpapers array is empty
    if [ ${#wallpapers[@]} -eq 0 ]; then
        # If the array is empty, refill it with the image files
        wallpapers=("$wallpapersDir"/*)
    fi

    # Select a random wallpaper from the array
    wallpaperIndex=$(( RANDOM % ${#wallpapers[@]} ))
    selectedWallpaper="${wallpapers[$wallpaperIndex]}"

    # Remove the selected wallpaper from the array
    swww img "$selectedWallpaper" $trans
    unset "wallpapers[$wallpaperIndex]"

    # Delay for 2 hours before selecting the next wallpaper
    wal -i $(cat ~/.cache/swww/eDP-1)
    bash ~/dotfiles/waybar/launch.sh
    rm -rf ~/.cache/current_wallpaper.jpg
    cp  $(cat ~/.cache/swww/eDP-1) ~/.cache/current_wallpaper.jpg
    convert ~/.cache/current_wallpaper.jpg ~/.cache/current_wallpaper.png
    rm -rf ~/.cache/current_wallpaper.jpg
    echo $(cat ~/.cache/wal/colors-waybar.css) > ~/.cache/wal/colors-wlogout.css
    sleep 2h
done

