#!/bin/bash
# Battery Monitor Script for Niri + Dank Material Shell
# Monitors battery level and sends notifications via dunst

# Configuration file
CONFIG_FILE="${XDG_CONFIG_HOME:-$HOME/.config}/niri/scripts/battery-monitor.conf"

# Default configuration values
WARNING_THRESHOLD=20
CRITICAL_THRESHOLD=10
REMINDER_INTERVAL=300  # 5 minutes in seconds
CHECK_INTERVAL=30      # Check battery every 30 seconds
WARNING_SOUND="/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga"
CRITICAL_SOUND="/usr/share/sounds/freedesktop/stereo/alarm-clock-elapsed.oga"
ENABLE_SOUND=true
ENABLE_REMINDERS=true

# Load configuration if it exists
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
fi

# State tracking file
STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}/battery-monitor"
mkdir -p "$STATE_DIR"
STATE_FILE="$STATE_DIR/state"

# Battery device (auto-detect or use BAT0)
BATTERY_DEVICE=""

# Function to find battery device
find_battery() {
    for bat in /org/freedesktop/UPower/devices/battery_BAT{0,1,2}; do
        if upower -i "$bat" &>/dev/null; then
            BATTERY_DEVICE="$bat"
            return 0
        fi
    done
    echo "ERROR: No battery device found!" >&2
    return 1
}

# Function to get battery percentage
get_battery_percentage() {
    upower -i "$BATTERY_DEVICE" | grep -E "percentage" | awk '{print $2}' | tr -d '%'
}

# Function to get battery state (charging/discharging)
get_battery_state() {
    upower -i "$BATTERY_DEVICE" | grep -E "state:" | awk '{print $2}'
}

# Function to play sound alert
play_sound() {
    local sound_file="$1"
    if [[ "$ENABLE_SOUND" == "true" ]] && [[ -f "$sound_file" ]]; then
        if command -v pw-play &>/dev/null; then
            pw-play "$sound_file" &>/dev/null &
        elif command -v paplay &>/dev/null; then
            paplay "$sound_file" &>/dev/null &
        fi
    fi
}

# Function to get appropriate battery icon based on level and state
get_battery_icon() {
    local percentage="$1"
    local state="$2"
    local icon=""
    
    # Determine icon based on battery level and state
    if [[ "$state" == "charging" ]] || [[ "$state" == "pending-charge" ]]; then
        if (( $(echo "$percentage <= 10" | bc -l) )); then
            icon="battery-empty-charging"
        elif (( $(echo "$percentage <= 20" | bc -l) )); then
            icon="battery-caution-charging"
        elif (( $(echo "$percentage <= 40" | bc -l) )); then
            icon="battery-low-charging"
        elif (( $(echo "$percentage <= 80" | bc -l) )); then
            icon="battery-good-charging"
        else
            icon="battery-full-charging"
        fi
    else
        if (( $(echo "$percentage <= 10" | bc -l) )); then
            icon="battery-empty"
        elif (( $(echo "$percentage <= 20" | bc -l) )); then
            icon="battery-caution"
        elif (( $(echo "$percentage <= 40" | bc -l) )); then
            icon="battery-low"
        elif (( $(echo "$percentage <= 80" | bc -l) )); then
            icon="battery-good"
        else
            icon="battery-full"
        fi
    fi
    
    echo "$icon"
}

# Function to send notification
send_notification() {
    local urgency="$1"
    local title="$2"
    local message="$3"
    local sound_file="$4"
    local percentage="$5"
    local state="$6"
    
    # Get appropriate battery icon
    local icon=$(get_battery_icon "$percentage" "$state")
    
    # Play sound if provided
    if [[ -n "$sound_file" ]]; then
        play_sound "$sound_file"
    fi
    
    # Send notification with icon
    if command -v dunstify &>/dev/null; then
        dunstify -u "$urgency" -i "$icon" -a "Battery Monitor" "$title" "$message"
    elif command -v notify-send &>/dev/null; then
        notify-send -u "$urgency" -i "$icon" -a "Battery Monitor" "$title" "$message"
    fi
}

# Function to read state
read_state() {
    if [[ -f "$STATE_FILE" ]]; then
        source "$STATE_FILE"
    else
        LAST_WARNING_TIME=0
        LAST_CRITICAL_TIME=0
        WARNING_NOTIFIED=false
        CRITICAL_NOTIFIED=false
    fi
}

# Function to write state
write_state() {
    cat > "$STATE_FILE" << EOF
LAST_WARNING_TIME=$LAST_WARNING_TIME
LAST_CRITICAL_TIME=$LAST_CRITICAL_TIME
WARNING_NOTIFIED=$WARNING_NOTIFIED
CRITICAL_NOTIFIED=$CRITICAL_NOTIFIED
EOF
}

# Function to check battery and send notifications
check_battery() {
    local percentage
    local state
    local current_time
    
    percentage=$(get_battery_percentage)
    state=$(get_battery_state)
    current_time=$(date +%s)
    
    # If charging, reset notification state
    if [[ "$state" == "charging" ]] || [[ "$state" == "fully-charged" ]]; then
        if [[ "$WARNING_NOTIFIED" == "true" ]] || [[ "$CRITICAL_NOTIFIED" == "true" ]]; then
            WARNING_NOTIFIED=false
            CRITICAL_NOTIFIED=false
            write_state
        fi
        return
    fi
    
    # Check critical threshold (10%)
    if (( $(echo "$percentage <= $CRITICAL_THRESHOLD" | bc -l) )); then
        local time_since_last=$((current_time - LAST_CRITICAL_TIME))
        
        # Send notification if:
        # 1. Never notified before, OR
        # 2. Reminders enabled and enough time passed
        if [[ "$CRITICAL_NOTIFIED" == "false" ]] || \
           [[ "$ENABLE_REMINDERS" == "true" && $time_since_last -ge $REMINDER_INTERVAL ]]; then
            
            send_notification "critical" \
                "🔋 CRITICAL: Battery at ${percentage}%!" \
                "Your battery is critically low. Please plug in your charger immediately!" \
                "$CRITICAL_SOUND" \
                "$percentage" \
                "$state"
            
            CRITICAL_NOTIFIED=true
            LAST_CRITICAL_TIME=$current_time
            write_state
        fi
        return
    fi
    
    # Check warning threshold (20%)
    if (( $(echo "$percentage <= $WARNING_THRESHOLD" | bc -l) )); then
        local time_since_last=$((current_time - LAST_WARNING_TIME))
        
        # Send notification if:
        # 1. Never notified before, OR
        # 2. Reminders enabled and enough time passed
        if [[ "$WARNING_NOTIFIED" == "false" ]] || \
           [[ "$ENABLE_REMINDERS" == "true" && $time_since_last -ge $REMINDER_INTERVAL ]]; then
            
            send_notification "normal" \
                "⚠️ Battery Low: ${percentage}%" \
                "Your battery is running low. Consider plugging in your charger soon." \
                "$WARNING_SOUND" \
                "$percentage" \
                "$state"
            
            WARNING_NOTIFIED=true
            LAST_WARNING_TIME=$current_time
            write_state
        fi
        return
    fi
    
    # If battery is above warning threshold, reset warning state
    if (( $(echo "$percentage > $WARNING_THRESHOLD" | bc -l) )); then
        if [[ "$WARNING_NOTIFIED" == "true" ]]; then
            WARNING_NOTIFIED=false
            write_state
        fi
    fi
}

# Main loop
main() {
    echo "Battery Monitor started at $(date)"
    
    # Find battery device
    if ! find_battery; then
        exit 1
    fi
    
    echo "Monitoring battery: $BATTERY_DEVICE"
    echo "Warning threshold: ${WARNING_THRESHOLD}%"
    echo "Critical threshold: ${CRITICAL_THRESHOLD}%"
    echo "Reminder interval: ${REMINDER_INTERVAL}s"
    
    # Read initial state
    read_state
    
    # Main monitoring loop
    while true; do
        check_battery
        sleep "$CHECK_INTERVAL"
    done
}

# Handle signals for clean shutdown
trap 'echo "Battery Monitor stopped at $(date)"; exit 0' SIGTERM SIGINT

# Run main function
main
