#!/bin/bash

# eval "$(/usr/bin/gnome-keyring-daemon --start --components=ssh)"
# echo "export SSH_AUTH_SOCK=$SSH_AUTH_SOCK" > "$XDG_RUNTIME_DIR/gnome-keyring-ssh.env"

/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,login
