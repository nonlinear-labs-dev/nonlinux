#!/bin/sh

ssid=$1
nmcli device wifi list | grep " $ssid " > /dev/null 2>&1 || { echo "Network '$ssid' could not be found."; exit 1; }
