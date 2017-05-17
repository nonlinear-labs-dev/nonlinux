#!/bin/sh

mkdir /update

if [ -e /mnt/usb-stick/nonlinear-c15-update.tar ]
then
	cp /mnt/usb-stick/nonlinear-c15-update.tar /update		
	mv /mnt/usb-stick/nonlinear-c15-update.tar /mnt/usb-stick/nonlinear-c15-update.tar-copied
	/bin/sh /nonlinear/scripts/unpack-and-install-update.sh
fi

