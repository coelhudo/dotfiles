#!/bin/bash

today=$(date +"%h %d %a")

/usr/bin/notify-send "$today" -t 1000
