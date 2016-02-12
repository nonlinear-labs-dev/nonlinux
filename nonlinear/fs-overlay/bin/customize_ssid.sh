#!/bin/bash

STRING=$(cat $1 | grep ssid | cut -d '=' -f 2)
SUFFIX=$(echo $STRING | cut -d '_' -f 2)
MACHINE_ID=$(cat /etc/machine-id)
MACHINE_ID_SHORT=${MACHINE_ID:0:4}

if [ "${STRING}" = "${SUFFIX}" ]; then
	echo -e "SSID Customizing..."
	sed -i -- "s/ssid=NonLinearInstrument/ssid=NonLinearInstrument_$MACHINE_ID_SHORT/g" $1
	echo "Done"
else
	echo "SSID Already Customized!"
fi
