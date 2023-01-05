#!/bin/sh

# pretty ls
alias ls='ls --color=auto'

# safe rm
alias rm='rm -i'

# short complete ls
alias ll='ls -al'

# list all packages marked as not needed dependencies and remove them
alias cleanup_packages='(while pacman -Qdtq; do set -x; sudo pacman -Rs $(pacman -Qdtq); done)'

# fast emacs command for client-server
alias em="emacsclient -c -a 'emacs'"

# run code under wayland
alias code='code --enable-features=UseOzonePlatform,WaylandWindowDecorations --ozone-platform=wayland'

# run gnome under X11
alias gnome="XDG_SESSION_TYPE=x11 GDK_BACKEND=x11 exec gnome-session"
