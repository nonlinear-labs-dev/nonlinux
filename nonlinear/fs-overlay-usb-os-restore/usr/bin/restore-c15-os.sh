#!/bin/sh

# This will only restore the rootfs of the BBB to the version of the deployed
# nonlinear-c15-update.tar on the stick. The user will have to run a full update
# after the resotring procedure is done.

# ToDos:
# - How do we sync the LPC and the ePC?? Focus on BBB rootfs for now ...
# - mutliple partition check? assume mmcblk0p2 for now

set -x

LOG_FILE="/media/restore-os.log"
TIMEOUT=5
BBB_DEVICE="/dev/mmcblk0p2"
BBB_ROOTFS_MOUNTPOINT="/tmp/bbb_rootfs"
BBB_ROOTFS_UPDATE_DIR="${BBB_ROOTFS_MOUNTPOINT}/update"

MSG_DONE="DONE!"
MSG_FAILED="FAILED!"

freeze() {
    while true; do
        sleep 1
    done
}

executeAsRoot() {
    echo "sscl" | sshpass -p 'sscl' ssh -o ServerAliveInterval=1 -o ConnectionAttempts=1 -o ConnectTimeout=1 -o StrictHostKeyChecking=no sscl@$192.168.10.10 "sudo -S /bin/bash -c '$1'"
    return $?
}

t2s() {
    /usr/C15/text2soled/text2soled multitext "$1" "$2" "$3" "$4" "$5" "$6"
}

pretty() {
    echo "$*"
    BOLED_LINE_1="$1"
    BOLED_LINE_2="$2"
    BOLED_LINE_3="$3"
    SOLED_LINE_1="$4"
    SOLED_LINE_2="$5"
    SOLED_LINE_3="$6"

    t2s "${BOLED_LINE_1}@b2c" "${BOLED_LINE_2}@b3c" "${BOLED_LINE_3}@b4c" "${SOLED_LINE_1}@s0c" "${SOLED_LINE_2}@s1c" "${SOLED_LINE_3}@s2c"
}

report() {
    pretty "$1" "$2" "$3" "$1" "$2" "$3"
    printf "$1 $2 $3\n" >> ${LOG_FILE}
}

stop_services() {
    systemctl stop playground > /dev/null || executeAsRoot "systemctl stop playground"
    systemctl stop bbbb > /dev/null
    return 0
}

mount_stick () {
    USB_DEVICE=
    for d in "/dev/sda" "/dev/sda1"; do
        [ -e ${d} ] && USB_DEVICE=${d}
    done

    if ( ! mount | grep ${USB_DEVICE} ); then
        mount ${USB_DEVICE} /media
        rm $LOG_FILE
        touch $LOG_FILE
    fi

    return 0
}

check_preconditions (){
    MSG_CHECK="Checking presocondtions ..."
    report "$MSG_CHECK"
    sleep 2
    [ -e /media/nonlinear-c15-update.tar ] || { report "$MSG_FAILED" "Update.tar missing!"; return 1; }

    report "$MSG_CHECK" "$MSG_DONE"
    sleep 2
    return 0
}

mount_rootfs (){
    MSG_MOUNT="Mounting partitions ..."
    report "$MSG_MOUNT"
    sleep 2
    if ( ! mount | grep ${BBB_DEVICE} ); then
        mkdir ${BBB_ROOTFS_MOUNTPOINT} \
        && mount ${BBB_DEVICE} ${BBB_ROOTFS_MOUNTPOINT} \
        || { report "$MSG_FAILED" "$MOUNTING_MSG"; return 1; }
    fi
    report "$MSG_MOUNT" "$MSG_DONE"
    sleep 2
    return 0
}

unpack_update (){
    MSG_UNPACK="Unpacking files ..."
    report "$MSG_UNPACK"
    sleep 2
    rm -r ${BBB_ROOTFS_UPDATE_DIR}/*

    cp /media/nonlinear-c15-update.tar ${BBB_ROOTFS_UPDATE_DIR} \
    && cd ${BBB_ROOTFS_UPDATE_DIR} \
    && tar xf nonlinear-c15-update.tar \
    || { report "$MSG_FAILED" "Unpacking update ..."; return 1; }

    mkdir ${BBB_ROOTFS_UPDATE_DIR}/BBB/rootfs \
    && gzip -dc ${BBB_ROOTFS_UPDATE_DIR}/BBB/rootfs.tar.gz | tar -C ${BBB_ROOTFS_UPDATE_DIR}/BBB/rootfs -xf - \
    || { report "$MSG_FAILED" "Unpacking rootfs ..."; return 1; }

    report "$MSG_UNPACK" "$MSG_DONE"
    sleep 2
    return 0
}

sync_rootfs (){
    MSG_RESTORE="Restoring OS ..."
    report "$MSG_RESTORE"
    sleep 2

    rsync -cax --exclude '${BBB_ROOTFS_MOUNTPOINT}/etc/hostapd.conf' --exclude '${BBB_ROOTFS_MOUNTPOINT}/update' ${BBB_ROOTFS_UPDATE_DIR}/BBB/rootfs ${BBB_ROOTFS_MOUNTPOINT} \
    || { report "$MSG_FAILED" "$MSG_RESTORE"; return 1; }

    report "$MSG_RESTORE" "$MSG_DONE"
    sleep 2

    return 0
}

main (){
    mount_stick
    stop_services
    report "Hello from rescue USB!" "Will start restoring OS shortly ..."
    sleep 3
    check_preconditions || return 1
    mount_rootfs || return 1
    unpack_update || return 1
    sync_rootfs || return 1
    report "Please run a full update" "from USB with a valid" "nonlinear-C15-update.tar" && freeze
    return 0
}

main

