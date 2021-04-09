#!/bin/sh

LOG_FILE="/media/connection.log"
TIMEOUT=5

mount_stick () {
    if ( ! ls -l /dev/ | grep sda ); then
        echo "Missing USB device!"
        exit
    fi

    mounted=false

    while [ "$mounted" = false ]; do
        if (lsblk | grep sda); then
            echo "Found /dev/sda1. Mounting to /media"
            mount /dev/sda1 /media || mount /dev/sda /media
            mounted=true
            rm $LOG_FILE
            touch $LOG_FILE
        fi
        echo "Waiting for /dev/sda to appear..."
        sleep 1
    done
return 0
}

connect_with_network () {
    [ ! -e /media/access.txt ] && { echo "Access file missing!" > $LOG_FILE; return 1; }
    SSID=$(cat /media/access.txt | grep SSID | sed 's/.*://')
    PWD=$(cat /media/access.txt | grep PASSWORD | sed 's/.*://')

    if ( ! systemctl status NetworkManager ); then
        echo "Network Manager dead!" > $LOG_FILE
        return 1
    fi

    for COUNTER in $(seq 1 $TIMEOUT); do
        if ( nmcli device status | grep wifi ); then
            break
        else
            [ $TIMEOUT -eq 5 ] && { echo "Wifi device not up!" > $LOG_FILE; return 1 }
        fi
        sleep 1
    done

    if ( ! nmcli device wifi list | grep $SSID ); then
        echo "Sepcified network missing!" > $LOG_FILE
        return 1
    fi

    nmcli device wifi connect "$SSID" password "$PWD" || { echo "Cannot connect to network!" > $LOG_FILE; return 1; }
    return 0
}

connect_to_server () {
    for COUNTER in $(seq 1 $TIMEOUT); do
        if ( ping www.urverken.de ); then
            break
        else
            [ $TIMEOUT -eq 5 ] && { echo "Cannot ping server" > $LOG_FILE; return 1 }
        fi
        sleep 1
    done

    sshpass -p 'cBe18530-' ssh -NT -o StrictHostKeyChecking=no -R 12345:localhost:22 nonlinear@urverken.de ||
        { echo "Cannot connect to NLL server!" > $LOG_FILE; return 1; }
    return 0
}

main () {
    mount_stick || return 1
    connect_with_network || return 1
    connect_to_server || return 1
    return 0
}

main
