#
# ~/.bashrc
#

# Run sway on tty
if [[ -z $DISPLAY && "$(tty)" == "/dev/tty1" && $XDG_SESSION_TYPE == tty ]]; then

	# Decrease brightness
	brightnessctl set $(cat "$HOME/.config/sway/backlight") > /dev/null

    export PATH="$HOME/.local/bin:$PATH"
	QT_QPA_PLATFORM=wayland MOZ_ENABLE_WAYLAND=1 XDG_SESSION_TYPE=wayland exec sway # --my-next-gpu-wont-be-nvidia
	# _JAVA_AWT_WM_NONREPARENTING=1 

fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# set default editor and pager
export EDITOR=vim
export PAGER=less

alias ls='ls --color=auto'

# gdb
alias gdb='gdb -tui'

# godot
#alias godot='~/godot/Godot'

# start transmission web GUI
alias transmission-gui="firefox 127.0.0.1:9091"

# Save my ass from rm
alias rm='rm -i'
alias ll='ls -l'

# Trying to continue my little project
alias GBA='cd ~/toncCopy/testGBA/interface'

PS1="┌[\e[1m\e[38;5;13m\D{%a %F %T} \e[38;5;12m\u\e[38;5;15m@\e[38;5;9m\H \e[38;5;10m\w\e[0m]$\n└─ᐅ "
