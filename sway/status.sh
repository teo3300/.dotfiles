# set variables for different systems
power_supply=ACAD
battery=BAT1
primary_drive=/dev/sda2

# Get current date & time through and format
time_date=$(date +"%a %Y-%m-%d %H:%M")

# Get battery status (faster than "cat BAT1")
if [[ "$(cat "/sys/class/power_supply/$power_supply/online")" == "1" ]]
then
    charging=⚡
else
    charging=🔋
fi

# Get battery pergentage
battery_percentage=$(busctl get-property\
    org.freedesktop.UPower\
    "/org/freedesktop/UPower/devices/battery_$battery"\
    org.freedesktop.UPower.Device\
    Percentage)
battery_percentage=${battery_percentage:2}

# Get backlight value (0-100)
backlight=$(brightnessctl g)

# Get available space in GiB (change -BG parameter)
avail_space=$(df -BG 	|\
    grep "$primary_drive" |\
    awk '{print $4}')

# Get Audio Volume & Mute
speaker_stat=$(amixer get Master |\
    awk '/Mono:+/ {getline; print $6=="[off]" ? $5"🔇" : $5"🔊" }' |\
    tr -d '[%]')

# Get Mic mute (omit level)
mic_stat=$(amixer get Capture |\
    awk '/Limits:+/ {getline; print $6=="[off]" ? "❌" : "🎤"}')

# Get thermal info about Core_0
thermal=$(sensors -u coretemp-isa-0000 | grep temp2_input | awk '{print $2}' | sed 's/\..*//')

echo $mic_stat$speaker_stat $avail_space💾 $backlight🔆 $battery_percentage$charging $thermal🌡 $time_date
