#!/bin/bash
WD=$1

echo "  Remove unwanted files..."

# We don't want dhcpd to start by default. We start it by udev rule if needed
rm -f ${WD}/etc/systemd/system/multi-user.target.wants/dhcpd.service
# It does not always work te replace /avr/log (which is a symlink) by a folder
rm -Rf ${WD}/var/log
mkdir -p ${WD}/var/log

exit 0
