#!/bin/bash

# Bash script to take several pictures just before and after sunset.
# Check current time (offset by 15 min) against sunset text data.
# If a match is found, it triggers the photo sequence to initiate.

#
# Get current time, offset by 15 minutes to trigger 15 min before sunset.
#
OFFSET=15 # in minutes
YEAR=`date --date="+$OFFSET minutes" +%Y`
echo "YEAR: " $YEAR

MONTH=`date --date="+$OFFSET minutes" +%m`
echo "MONTH: " $MONTH

DAY=`date --date="+$OFFSET minutes" +%d`
echo "DAY: " $DAY

LOCALT=`date --date="+$OFFSET minutes" +%r`
HOUR=`echo $LOCALT | cut -f 1 -d":"`
echo "HOUR: " $HOUR
MINUTE=`echo $LOCALT | cut -f 2 -d":"`
echo "MINUTE: " $MINUTE

AMORPM=`date --date="+$OFFSET minutes" +%p`
echo "AM OR PM: " $AMORPM

TRIGGERTIME="$HOUR:$MINUTE $AMORPM"
echo "TRIGGERTIME: " $TRIGGERTIME

#
# Get start time for today's pictures:
#

#Sunset for today:
LINE=`cat sunsets-data/sunsets.txt | grep -P "$YEAR \t $MONTH \t $DAY\t"`
echo $LINE

STIME=`echo $LINE | cut -f 8 -d " "`
SAMORPM=`echo $LINE | cut -f 9 -d " "`
SUNSET="$STIME $SAMORPM"
echo "SUNSET: " $SUNSET

SLEEPFOR=299 # Just shy of 5 minutes since photos take 1 sec to take
if [ "$TRIGGERTIME" == "$SUNSET" ]; then
  #Trigger photo sequence
  python /home/pi/projects/timelapse/pi_camera_options.py
  sleep $SLEEPFOR
  python /home/pi/projects/timelapse/pi_camera_options.py
  sleep $SLEEPFOR
  python /home/pi/projects/timelapse/pi_camera_options.py
  sleep $SLEEPFOR
  python /home/pi/projects/timelapse/pi_camera_options.py
  sleep $SLEEPFOR
  python /home/pi/projects/timelapse/pi_camera_options.py
  sleep $SLEEPFOR
  python /home/pi/projects/timelapse/pi_camera_options.py
  sleep $SLEEPFOR
  python /home/pi/projects/timelapse/pi_camera_options.py
fi
