# set variables for different systems

battery_info=$1
supply_info=$2

# Get current date & time through and format
time_date=$(date +"%a %Y-%m-%d %H:%M")

# Get available space in GiB (change -BG parameter)
used_ram=$(free -h | grep Mem | awk '{print $3"/"$2}')

# Get mic mute status
mic_stat=$(if [ "$(pamixer --default-source --get-mute)" = "true" ]; then echo -n "❌"; else echo -n "🎤"; fi)

# Get Audio Volume & Mute
speaker_stat=$(pamixer --get-volume)$(if [ "$(pamixer --get-mute)" = "true" ]; then echo -n "🔇"; else echo -n "🔊"; fi)

# Get input method
input_method=$(if [ "$(pgrep wlanthy)" ]; then
    echo -n "日本語"
else
        echo -n $(swaymsg -t get_inputs -r |\
            jq '.[] | select(.type=="keyboard") |
            .xkb_active_layout_name' |\
            head -n1 | tr -d '"')
fi)

echo $input_method🌐$'\t'$mic_stat$speaker_stat$'\t'$used_ram💾$'\t'$time_date
