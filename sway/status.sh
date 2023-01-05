# set variables for different systems

battery_info=$1
supply_info=$2

# Get current date & time through and format
time_date=$(date +"%a %Y-%m-%d %H:%M")

# Get battery status (faster than "cat BAT1")
if [[ -e $supply_info ]]; then
    if [[ "$(cat $supply_info/online)" == "1"  ]]; then
        charging=⚡
    else
        charging=🔋
    fi
else
    charging=""
fi

# Get battery pergentage
battery_percentage=$(expr $(expr $(cat $battery_info/charge_now) \* 100) / $(cat $battery_info/charge_full))

# Get backlight value (0-100)
backlight=$(brightnessctl g)

bl_ico=""
if [[ -n "$backlight" ]]; then
    bl_ico="🔆"
fi

# Get available space in GiB (change -BG parameter)
used_ram=$(free -h | grep Mem | awk '{print $3"/"$2}')

# Get Audio Volume & Mute
speaker_stat=$(pamixer --get-volume)$(if [ "$(pamixer --get-mute)" = "true" ]; then echo -n "🔇"; else echo -n "🔊"; fi)

# Get thermal info about Core_0
thermal=$(sensors -u | grep Core -A1 | grep temp | awk '{print $2}' | sed 's/\..*//')

# Get input method
input_method=$(if [ "$(pgrep wlanthy)" ]; then echo -n "日本語"; else echo -n "IT"; fi)

echo $input_method🌐 $speaker_stat $used_ram💾 $backlight$bl_ico $battery_percentage$charging $thermal🌡️ $time_date