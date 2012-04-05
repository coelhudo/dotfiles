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
           000000[16][1a]) /usr/bin/xlock
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
