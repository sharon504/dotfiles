#!/bin/bash

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

source "${HOME}/.cache/wal/colors.sh"
background=$color0
background_alt=$color3
foreground=$color15
foreground_alt=$color2
highlight=$color4

# Launch Polybar, using default config location ~/.config/polybar/config
polybar main --config=~/.config/polybar/config.ini &

echo "Polybar launched..."
