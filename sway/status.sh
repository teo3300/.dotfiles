# set variables for different systems
primary_drive=/dev/nvme0n1p3

# Get current date & time through and format
time_date=$(date +"%a %Y-%m-%d %H:%M")

# Get available space in GiB (change -BG parameter)
avail_space=$(df -BG 	|\
    grep "$primary_drive" |\
    awk '{print $4}')

# Get Audio Volume & Mute
speaker_stat=$(pamixer --get-volume)$(if [ "$(pamixer --get-mute)" = "true" ]; then echo -n "🔇"; else echo -n "🔊"; fi)

# Get thermal info about Core_0
thermal=$(sensors -u k10temp-pci-00c3 | grep temp1_input | awk '{print $2}' | sed 's/\..*//')

# Get input method
input_method=$(if [ "$(pgrep wlanthy)" ]; then echo -n "日本語"; else echo -n "IT"; fi)

echo $input_method🌐 $speaker_stat $avail_space💾 $thermal🌡️ $time_date
