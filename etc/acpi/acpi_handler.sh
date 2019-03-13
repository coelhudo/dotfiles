#!/bin/sh
# Default acpi script that takes an entry for all actions

IFS=${IFS}/
set $@

PID=`pgrep startx`
if [[ -n $PID ]];
then
	# found startx
	USER=`ps -o user --no-headers $PID `
	# USERHOME=`getent passwd $USER | cut -d: -f6`
	# export XAUTHORITY="$USERHOME/.Xauthority"
	# for x in /tmp/.X11-unix/*; do
	#     displaynum=`echo $x | sed s#/tmp/.X11-unix/X##`
	#     if [ x"$XAUTHORITY" != x"" ]; then
	#	export DISPLAY=":$displaynum"
	#     fi
	# done
else
	# TODO: detect correct console user
	USER=root
fi

icon_package=/usr/share/icons/Adwaita/64x64/status/
volume_low="$icon_package/audio-volume-low-symbolic.symbolic.png"
volume_medium="$icon_package/audio-volume-medium-symbolic.symbolic.png"
volume_high="$icon_package/audio-volume-high-symbolic.symbolic.png"

ac_unplugged="$icon_package/battery-missing-symbolic.symbolic.png"
ac_plugged="$icon_package/battery-full-charged-symbolic.symbolic.png"

notify_volume() {
    volume=$1
    if [ $volume -lt 30 ]
    then
	/usr/bin/notify-send "Volume $volume" -t 400 -i "$volume_low"
	logger "/usr/bin/notify-send \"Volume $volume\" -t 400 -i \"$volume_low\""
    elif [ $volume -lt 60 ]
    then
	/usr/bin/notify-send "Volume $volume" -t 400 -i "$volume_medium"
	logger "/usr/bin/notify-send \"Volume $volume\" -t 400 -i \"$volume_medium\""
    else
	/usr/bin/notify-send "Volume $volume" -t 400 -i "$volume_high"
	logger "/usr/bin/notify-send \"Volume $volume\" -t 400 -i \"$volume_high\""
    fi
};

current_volume_state() {
    return $(su $USER -c "amixer get Master" | awk '/Left: Playback/ { print $5 }' | tr -d %\[\])
}

case "$1" in
  button)
    case "$2" in
      power) /sbin/init 0
	 ;;
      volumedown) su $USER -c "/usr/bin/amixer set Master 5%-"
		  current_volume_state
		  notify_volume "$?"
		  ;;
      volumeup) su $USER -c "/usr/bin/amixer set Master 5%+"
		current_volume_state
		notify_volume "$?"
		;;
      mute) su $USER -c "/usr/bin/amixer sset Master toggle"
	    volume=$(su $USER -c "amixer get Master" | awk '/Left: Playback/ { print $6 }' | tr -d \[\])
	    if [ "$volume" = "on" ]
	    then
		/usr/bin/notify-send "Unmuted" -i "$icon_package/audio-volume-high-symbolic.symbolic.png" -t 1000
	    else
		/usr/bin/notify-send "Muted" -i "$icon_package/audio-volume-muted-symbolic.symbolic.png" -t 1000
	    fi
	    ;;
      f20) su $USER -c "/usr/bin/amixer sset Capture toggle"
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
  ac_adapter)
      case "$4" in
	  00000000) /usr/bin/notify-send "AC Unplugged" -i "$ac_unplugged" -t 1000
		    logger "AC Unplugged"
		    ;;
	  00000001) /usr/bin/notify-send "AC Plugged" -i "$ac_plugged" -t 1000
		    logger "AC Plugged"
		    ;;
      esac
      ;;
  *)
    logger "ACPI group $1 / action $2 is not defined"
    ;;
esac
