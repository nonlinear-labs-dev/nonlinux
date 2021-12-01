#!/bin/sh
# ToDos:
# - OLED massages
# - How do we sync the LPC and the ePC?? Focus on BBB rootfs for now ...
# - mutliple partition check? assume mmcblk0p2

set -x

LOG_FILE="/media/error.log"
TIMEOUT=5

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



check_preconditions (){
    [ -e /media/nonlinear-c15-update.tar ] || { report "" "Update missing!"; return 1; }
    [ -d /media/utilities ] || { report "" "Utilities directory missing!"; return 1; }

    return 0
}

unpack_update (){
    mkdir /tmp/update \
    && cp /media/nonlinear-c15-update.tar /tmp/update \
    && cd /tmp/update \
    && tar xf nonlinear-c15-update.tar \
    || { report "" "Could not unpack update"; return 1; }

    mkdir /tmp/update/BBB/rootfs \
    && gzip -dc /tmp/update/BBB/rootfs.tar.gz | tar -C /tmp/update/BBB/rootfs -xf - \
    || { report "" "Could not unpack rootfs"; return 1; }

    return 0
}

mount_rootfs (){
    mkdir /tmp/bbb_rootfs && mount /dev/mmcblk0p2 /tmp/bbb_rootfs \
    || { report "" "Could not mount local rootfs"; return 1; }

    return 0
}


sync_rootfs (){
    LD_LIBRARY_PATH=/media/utilities /media/utilities/rsync -cax --exclude '/tmp/bbb_rootfs/etc/hostapd.conf' /tmp/update/BBB/rootfs /tmp/bbb_rootfs \
    || { report "" "Faled to sync new rootfs"; return 1; }
    return 0
}

main (){
    check_update_presence || return 1
    unpack_update || return 1
    mount_rootfs || return 1
#    sync_rootfs || return 1
    return 0
}

main

