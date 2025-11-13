#!/bin/bash

# Waypaper post-command script
# Converts wallpaper to JPEG and updates pywal colors

WALLPAPER="$1"
CACHE_DIR="$HOME/.cache"
OUTPUT_FILE="$CACHE_DIR/current_wallpaper.jpg"

# Create cache directory if it doesn't exist
mkdir -p "$CACHE_DIR"

# Check if the wallpaper file exists
if [[ ! -f "$WALLPAPER" ]]; then
    echo "Error: Wallpaper file not found: $WALLPAPER"
    exit 1
fi

# Get the file extension (lowercase)
EXT="${WALLPAPER##*.}"
EXT="${EXT,,}"

# Convert PNG to JPEG or copy if already JPEG
if [[ "$EXT" == "png" ]]; then
    echo "Converting PNG to JPEG..."
    convert "$WALLPAPER" -quality 95 "$OUTPUT_FILE"
elif [[ "$EXT" == "jpg" || "$EXT" == "jpeg" ]]; then
    echo "Copying JPEG..."
    cp "$WALLPAPER" "$OUTPUT_FILE"
else
    echo "Unsupported format: $EXT. Attempting conversion..."
    convert "$WALLPAPER" -quality 95 "$OUTPUT_FILE"
fi

# Update pywal colors
if command -v wal &> /dev/null; then
    echo "Updating pywal colors..."
    wal -i "$WALLPAPER"
else
    echo "Warning: wal not found, skipping color scheme update"
fi

# Restart waybar
if pgrep waybar &> /dev/null; then
    echo "Restarting waybar..."
    killall waybar
    waybar &
fi

echo "Wallpaper setup complete!"
