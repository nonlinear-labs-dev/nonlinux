#!/bin/sh

mount_stick() {
	if ( ! ls -l /dev/ | grep sda ); then
                echo "Missing USB device!"
                exit
        fi

        mounted=false

        while [ "$mounted" = false ]; do

                if (lsblk | grep sda); then
                        echo "Found /dev/sda1. Mounting to /media"
                        mount /dev/sda1 /media || mount /dev/sda /media
                        mounted=true;
                else
                        echo "Waiting for /dev/sda to appear..."
                        sleep 1
                fi
        done
}

connect_with_network() {
	[ ! -e /media/access.txt ] && { echo "Access file missing!"; return 1; }
	SSID=$(cat /media/access.txt | grep SSID | sed 's/.*://')
	PWD=$(cat /media/access.txt | grep PASSWORD | sed 's/.*://')

	if ( ! systemctl status NetworkManager ); then
		echo "Network Manager dead!"
		return 1 
	fi

	if ( ! nmcli device wifi list | grep $SSID ); then
		echo "Sepcified network missing!"
		return 1
	fi

	nmcli device wifi connect "$SSID" password "$PWD" || { echo "Cannot conect to network!"; return 1; }
	return 0
}

connect_to_server() {
	sshpass -p 'cBe18530-' ssh -o StrictHostKeyChecking=no -R 12345:localhost:22 nonlinear@urverken.de || { echo "Cannot conect to NLL server!"; return 1; }
	return 0
}

main() {
	mount_stick || return 1
	connect_with_network || return 1
	connect_to_server || return 1
	return 0
}

main
