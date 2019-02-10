#!/bin/sh
# Default acpi script that takes an entry for all actions

IFS=${IFS}/
set $@

volume_icon() {
    volume=$1
    if [ $volume -gt 60 ]
    then
	/usr/bin/notify-send "Volume $volume" -t 400 -i /usr/share/icons/Adwaita/64x64/status/audio-volume-high-symbolic.symbolic.png 
    elif [ $volume -le 60 ] && [ $volume -gt 30 ]
    then
	/usr/bin/notify-send "Volume $volume" -t 400 -i /usr/share/icons/Adwaita/64x64/status/audio-volume-medium-symbolic.symbolic.png 
    else
	/usr/bin/notify-send "Volume $volume" -t 400 -i /usr/share/icons/Adwaita/64x64/status/audio-volume-low-symbolic.symbolic.png
    fi
};

case "$1" in
  button)
    case "$2" in
      power) /sbin/init 0
         ;;
      volumedown) /usr/bin/amixer set Master 10%-
		  volume=$(amixer get Master | awk '/Left: Playback/ { print $5 }' | tr -d %\[\])
		  volume_icon $volume
		  ;;
      volumeup) /usr/bin/amixer set Master 10%+
		volume=$(amixer get Master | awk '/Left: Playback/ { print $5 }' | tr -d %\[\])
		volume_icon $volume
		;;
      mute) /usr/bin/amixer sset Master toggle
	    ;;
      f20) /usr/bin/amixer sset Capture toggle
	    ;;
      lid) logger "lid $4"
	   case "$4" in
	       close) /usr/sbin/pm-suspend-hybrid
		      ;;
	       *) logger "ACPI action $2 $4 is not defined"
		  ;;
	   esac
	 ;;
      *) logger "ACPI action $2 is not defined"
         ;;
    esac
    ;;
  video)
      case "$2" in
	  brightnessdown) /usr/bin/xbacklight -dec 20
			  ;;
	  brightnessup) /usr/bin/xbacklight -inc 20
			;;
	  *) logger "some video action: $2"
	     ;;
      esac
      ;;
  *)
    logger "ACPI group $1 / action $2 is not defined"
    ;;
esac
