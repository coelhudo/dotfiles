#!/bin/sh
LANG=C                                                                                                        # Ensure stable parsing
export DISPLAY="$(w | awk 'NF > 7 && $2 ~ /tty[0-9]+/ {print $3; exit}' 2>/dev/null)"                      # Get and export the current user's $DISPAY
export XAUTHORITY="/home/$(w | awk 'NF > 7 && $2 ~ /tty[0-9]+/ {print $1; exit}' 2>/dev/null)/.Xauthority" # Get and export the currentuser's $XAUTHORITY
ID="$(xinput | grep -ioP 'touchpad.*id=\K[0-9]*')"                                                           # Find the TouchPad device ID

if   [ "${1}" -eq 0 ]; then xinput enable "$ID"   # Laptop mode or Lid is open
elif [ "${1}" -eq 1 ]; then xinput disable "$ID"  # Tablet mode or Lid is closed
fi
