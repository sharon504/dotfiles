#/bin/sh

if [ -f "/usr/bin/swayidle" ]; then
    echo "swayidle is installed."
    swayidle -w timeout 1800 'swaylock -f -c 000000' \
            timeout 1900 'hyprctl dispatch dpms off' \
            resume 'hyprctl dispatch dpms on' \
            timeout 2000 'systemctl suspend' \
            before-sleep 'swaylock -f -c 000000' &

    # swayidle -w timeout 1800 'swaylock -f' timeout 1860 'hyprctl dispatch dpms off' resume 'hyprctl dispatch dpms on'
else
    echo "swayidle not installed."
fi;

