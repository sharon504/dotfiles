#!/bin/bash
# Test script for battery monitor notifications
# This sends a test notification to verify the system is working

echo "Testing battery notification system..."
echo ""

# Test if dunst/notification daemon is running
if pgrep -x dunst >/dev/null || pgrep -x mako >/dev/null; then
    echo "✓ Notification daemon is running"
else
    echo "✗ WARNING: No notification daemon detected (dunst/mako)"
    echo "  You may need to start dunst or mako for notifications to work"
fi

# Test if sound works
if command -v pw-play &>/dev/null || command -v paplay &>/dev/null; then
    echo "✓ Audio player found"
else
    echo "✗ WARNING: No audio player found (pw-play/paplay)"
fi

# Check if sound file exists
SOUND_FILE="/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga"
if [[ -f "$SOUND_FILE" ]]; then
    echo "✓ Sound file exists: $SOUND_FILE"
else
    echo "✗ WARNING: Sound file not found: $SOUND_FILE"
fi

echo ""
echo "Sending test notifications..."
echo ""

# Test warning notification
echo "1. Sending WARNING notification (20% battery)..."
if command -v dunstify &>/dev/null; then
    dunstify -u normal -i "battery-caution" -a "Battery Monitor Test" \
        "⚠️ Battery Low: 20%" \
        "This is a TEST warning notification. Your battery monitor is working!"
elif command -v notify-send &>/dev/null; then
    notify-send -u normal -i "battery-caution" -a "Battery Monitor Test" \
        "⚠️ Battery Low: 20%" \
        "This is a TEST warning notification. Your battery monitor is working!"
fi

sleep 2

# Test critical notification
echo "2. Sending CRITICAL notification (10% battery)..."
if command -v dunstify &>/dev/null; then
    dunstify -u critical -i "battery-empty" -a "Battery Monitor Test" \
        "🔋 CRITICAL: Battery at 10%!" \
        "This is a TEST critical notification. Your battery monitor is working!"
elif command -v notify-send &>/dev/null; then
    notify-send -u critical -i "battery-empty" -a "Battery Monitor Test" \
        "🔋 CRITICAL: Battery at 10%!" \
        "This is a TEST critical notification. Your battery monitor is working!"
fi

sleep 2

# Test sound
echo "3. Testing sound alert..."
if command -v pw-play &>/dev/null; then
    pw-play "$SOUND_FILE" &>/dev/null &
    echo "   Playing sound with pw-play..."
elif command -v paplay &>/dev/null; then
    paplay "$SOUND_FILE" &>/dev/null &
    echo "   Playing sound with paplay..."
fi

echo ""
echo "✓ Test complete!"
echo ""
echo "Did you see the notifications and hear the sound?"
echo "If not, check:"
echo "  1. Notification daemon is running: pgrep -x dunst"
echo "  2. Audio is not muted"
echo "  3. Check logs: journalctl --user -u battery-monitor -f"
