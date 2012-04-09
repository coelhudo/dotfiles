#!/bin/sh
# Default acpi script that takes an entry for all actions

IFS=${IFS}/
set $@

case "$1" in
  button)
    case "$2" in
      power) /sbin/init 0
	 ;;
      sleep) logger "sleep action"
	 ;;
      *) logger "ACPI action $2 is not defined"
	 ;;
    esac
    ;;
  hotkey)
    logger "hotkey pressed"
    case "$2" in
      ATKD) logger "ATK received"
	 case "$3" in
	   0000001[6a]) /usr/bin/xlock &
	   ;;
	   00000013) logger Toggle Master
		 #/usr/bin/amixer -q set Master toggle #not working
		 let isOdd="0x$4 % 2"
		 if [ $isOdd -eq 0 ]
		 then
		     logger Unmute
		     /usr/bin/amixer set Master mute
		 else
		     logger Mute
		     /usr/bin/amixer set Master unmute
		 fi
	   ;;
	   00000014) logger "Decrease volume by 2%"
		 /usr/bin/amixer set Master unmute
		 /usr/bin/amixer set Master 2%-
	   ;;
	   00000015) logger "Increase volume by 2%"
		 /usr/bin/amixer set Master unmute
		 /usr/bin/amixer set Master 2%+
	   ;;
	   *) logger "ACPI hot key $3 not defined"
	   ;;
	 esac
	 ;;
      *) logger "ACPI action $2, $3  is not defined"
	 ;;
    esac
    ;;
  *)
    logger "ACPI group $1 / action $2 is not defined"
    ;;
esac
