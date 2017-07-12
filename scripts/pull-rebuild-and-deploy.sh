#!/bin/sh

branch=$1
ssid=$2
passphrase=$3

./assert-network-exists.sh $ssid
./pull-and-rebuild.sh $branch
./connect-to-c15.sh $ssid $passphrase
./deploy-build.sh $branch
