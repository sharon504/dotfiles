# Battery Monitor - Icon Reference

The battery monitor now uses contextual icons that change based on battery level and charging state!

## Icon Display Logic

### When Discharging (on battery):
- **0-10%**: `battery-empty` - Empty battery icon (CRITICAL)
- **11-20%**: `battery-caution` - Caution battery icon (WARNING)  
- **21-40%**: `battery-low` - Low battery icon
- **41-80%**: `battery-good` - Good battery icon
- **81-100%**: `battery-full` - Full battery icon

### When Charging (plugged in):
- **0-10%**: `battery-empty-charging` - Empty battery with charging indicator
- **11-20%**: `battery-caution-charging` - Caution battery with charging indicator
- **21-40%**: `battery-low-charging` - Low battery with charging indicator
- **41-80%**: `battery-good-charging` - Good battery with charging indicator
- **81-100%**: `battery-full-charging` - Full battery with charging indicator

## Notification Examples

### Warning Notification (20% battery):
```
Icon: 🔋 battery-caution (yellow/orange battery)
Title: ⚠️ Battery Low: 20%
Message: Your battery is running low. Consider plugging in your charger soon.
Urgency: normal
Sound: alarm-clock-elapsed.oga
```

### Critical Notification (10% battery):
```
Icon: 🪫 battery-empty (red/critical battery)
Title: 🔋 CRITICAL: Battery at 10%!
Message: Your battery is critically low. Please plug in your charger immediately!
Urgency: critical
Sound: alarm-clock-elapsed.oga
```

## Icon Locations

All battery icons are system-provided from:
- `/usr/share/icons/Adwaita/`
- `/usr/share/icons/hicolor/`

These icons automatically adapt to your system theme!

## Testing

Run the test script to see the icons in action:
```bash
~/.config/niri/scripts/test-battery-notifications.sh
```

The test will show:
1. Warning notification with battery-caution icon (20%)
2. Critical notification with battery-empty icon (10%)
3. Sound alert playback

Note: Make sure dunst or mako is running to see the notifications!
