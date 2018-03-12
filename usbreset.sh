#!/usr/bin/env sh

var1=$(lsusb | grep PlayStation | awk '{print $2}')

var2=$(lsusb | grep PlayStation | awk '{print $4}' | sed 's/\://')

sudo usbreset /dev/bus/usb/$var1/$var2
