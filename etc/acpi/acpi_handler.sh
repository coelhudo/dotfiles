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

ac_unplugged="$icon_package/battery-missing-symbolic.symbolic.png"
ac_plugged="$icon_package/battery-full-charged-symbolic.symbolic.png"


case "$1" in
  button)
    case "$2" in
      power) /sbin/init 0
	 ;;
      lid) logger "lid $4"
	   case "$4" in
	       close) /usr/sbin/pm-suspend-hybrid
		      ;;
	       *) logger "ACPI action $2 $4 is not defined"
		  ;;
	   esac
	 ;;
      *) logger "ACPI action button/$2 is not defined"
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
  video)
      case "$2" in
	  tabletmode)
	      case "$5" in
		  00000000) /etc/acpi/thinkpad-touchpad-twist-mode.sh 0
			    logger "tablet mode off"
		     ;;
		  00000001) /etc/acpi/thinkpad-touchpad-twist-mode.sh 1
			    logger "tablet mode on"
		     ;;
		  *) logger "tabletmode invalid state"
		  ;;
	      esac
	      ;;
	  *) logger "ACPI action for video/tabletmode is not defined"
	     ;;
      esac
      ;;

  *)
    logger "ACPI group $1 / action $2 is not defined"
    ;;
esac
