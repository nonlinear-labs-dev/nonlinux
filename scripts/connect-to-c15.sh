#!/bin/sh

ssid=$1
passphrase=$2

if [ -z "$passphrase" ]
then
    passphrase="88888888"
fi

sudo nmcli device wifi connect $ssid password $passphrase
iwconfig | grep $ssid > /dev/null 2>&1 || { echo "Could not connect to '$ssid'"; exit 2; }
