#!/bin/sh
# ToDos:
# - How do we sync the LPC and the ePC?? Focus on BBB rootfs for now ...
# - mutliple partition check? assume mmcblk0p2 for now

set -x

LOG_FILE="/media/error.log"
TIMEOUT=5
BBB_DEVICE="/dev/mmcblk0p2"
BBB_ROOTFS_MOUNTPOINT="/tmp/bbb_rootfs"
BBB_ROOTFS_UPDATE_DIR="${BBB_ROOTFS_MOUNTPOINT}/update"

freeze() {
    while true; do
        sleep 1
    done
}

t2s() {
    /media/utilities/text2soled multitext "$1" "$2" "$3" "$4" "$5" "$6"
}

pretty() {
    echo "$*"
    HEADLINE="$1"
    BOLED_LINE_1="$2"
    BOLED_LINE_2="$3"
    SOLED_LINE_2="$4"
    SOLED_LINE_3="$5"

    t2s "${HEADLINE}@b1c" "${BOLED_LINE_1}@b3c" "${BOLED_LINE_2}@b4c" "${SOLED_LINE_2}@s1c" "${SOLED_LINE_3}@s2c"
}

report() {
    pretty "$1" "$2" "$3" "$2" "$3"
    printf "$2" >> LOG_FILE
}

mount_stick () {
    USB_DEVICE=""
    for d in "/dev/sda" "/dev/sda1"; do
        [ -e ${d} ] && USB_DEVICE=${d}
    done

    if ( ! mount | grep ${USB_DEVICE} ); then
        mount ${USB_DEVICE} /media
        sleep 2
        report "" "Hello from rescue USB!" "Will start restoring OS shortly ..."
        sleep 5
        rm $LOG_FILE
        touch $LOG_FILE
    fi

    return 0
}

check_preconditions (){
    report "" "Checking presocondtions ..."
    sleep 2
    [ -e /media/nonlinear-c15-update.tar ] || { report "" "Update missing!"; return 1; }
    [ -d /media/utilities ] || { report "" "Utilities directory missing!"; return 1; }

    report "" "Checking presocondtions done!"
    sleep 2
    return 0
}

mount_rootfs (){
    report "" "Mounting local partitions ..."
    sleep 2
    if ( ! mount | grep ${BBB_DEVICE} ); then
        mkdir ${BBB_ROOTFS_MOUNTPOINT} \
        && mount ${BBB_DEVICE} ${BBB_ROOTFS_MOUNTPOINT} \
        || { report "" "Could not mount local rootfs"; return 1; }
    fi
    report "" "Mounting local partitions done!"
    sleep 2
    return 0
}

unpack_update (){
    report "" "Unpacking restore files ..."
    sleep 2
    rm -r ${BBB_ROOTFS_UPDATE_DIR}/*

    cp /media/nonlinear-c15-update.tar ${BBB_ROOTFS_UPDATE_DIR} \
    && cd ${BBB_ROOTFS_UPDATE_DIR} \
    && tar xf nonlinear-c15-update.tar \
    || { report "" "Could not unpack update"; return 1; }

    mkdir ${BBB_ROOTFS_UPDATE_DIR}/BBB/rootfs \
    && gzip -dc ${BBB_ROOTFS_UPDATE_DIR}/BBB/rootfs.tar.gz | tar -C ${BBB_ROOTFS_UPDATE_DIR}/BBB/rootfs -xf - \
    || { report "" "Could not unpack rootfs"; return 1; }

    report "" "Unpacking restore files done!"
    sleep 2
    return 0
}

sync_rootfs (){
    report "" "Restoring OS ..."
    sleep 2

    LD_LIBRARY_PATH=/media/utilities /media/utilities/rsync -cax --exclude '${BBB_ROOTFS_MOUNTPOINT}/etc/hostapd.conf' --exclude '${BBB_ROOTFS_MOUNTPOINT}/update' ${BBB_ROOTFS_UPDATE_DIR}/BBB/rootfs ${BBB_ROOTFS_MOUNTPOINT} \
    || { report "" "Faled to sync new rootfs"; return 1; }

    report "" "Restoring OS done!"
    sleep 2

    return 0
}

main (){
    mount_stick
    check_preconditions || return 1
    mount_rootfs || return 1
    unpack_update || return 1
#    sync_rootfs || return 1
    report "" "Please, run a full update from USB" "with a valid nonlinear-c15-update.tar" && freeze
    return 0
}

main

