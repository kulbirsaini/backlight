#!/bin/bash

function log_args(){
  echo "Devise directory: $1"
  echo "Brightness : $2"
}

function backlight(){
  if [[ $EUID -ne 0 ]]; then
    echo 'Error: Should be executed as root/super user'
    log_args $1 $2
    return 1
  fi

  if ! [[ "$2" =~ ^[0-9\-]+$ ]]; then
    echo 'Error: Brightness should be a non-negative integer'
    log_args $1 $2
    return 1
  fi
  brightness=$((10#$2))

  if [ ! -d $1 ]; then
    echo 'Error: Devise directory does not exist'
    log_args $1 $2
    return 1
  fi
  file=$1/brightness

  if [ -f $1/max_brightness ]; then
    max_brightness=`cat $1/max_brightness`
    if [[ $max_brightness -gt 1 && $brightness -gt $max_brightness ]]; then
      brightness=$max_brightness
    fi
  fi

  if [ -f $1/min_brightness ]; then
    min_brightness=`cat $1/min_brightness`
    if [[ $min_brightness -lt 0 ]]; then
      min_brightness=0
    fi
  else
    min_brightness=0
  fi

  if [[ $brightness -lt $min_brightness ]]; then
    brightness=$min_brightness
  fi

  echo $brightness > $file
}

backlight /sys/class/leds/asus::kbd_backlight/ $1

