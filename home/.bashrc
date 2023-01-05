#
# ~/.bashrc
#

# Run sway on tty
if [[ -z $DISPLAY && "$(tty)" == "/dev/tty1" && $XDG_SESSION_TYPE == tty ]]
then
	
	# Source variables
	source $HOME/.bash_variables

	# set previous brightness
	# brightnessctl set $(cat "$HOME/.config/sway/backlight") > /dev/null

    export PATH="$HOME/.local/bin:$PATH"

    DATE=$(date +"%Y-%m-%d_%H-%M-%S")
    echo "==$DATE" > "$HOME/.config/sway/sway.log"
    echo "==$DATE" > "$HOME/.config/sway/sway.err"

	_JAVA_AWT_WM_NONREPARENTING=1\
        QT_QPA_PLATFORM=wayland\
		MOZ_ENABLE_WAYLAND=1\
		XDG_SESSION_TYPE=wayland\
		exec sway > "$HOME/.config/sway/sway.log" 2> "$HOME/.config/sway/sway.err"
# __GLX_VENDOR_LIBRARY_NAME=nvidia\
	
fi

# Create aliases
source $HOME/.bash_aliases

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

PS1="┌[\e[1m\e[38;5;13m\D{%a %F %T} \e[38;5;12m\u\e[38;5;15m@\e[38;5;9m\H \e[38;5;10m\w\e[0m]$\n└─ᐅ "
