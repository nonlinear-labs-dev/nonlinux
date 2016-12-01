#!/bin/sh

systemctl stop playground
umount /internalstorage
mkfs.ext3 -F /dev/mmcblk1p2
mkdir -p /tmp/rootfs
mount /dev/mmcblk1p2 /tmp/rootfs
tar -C /tmp/rootfs -xf /rootfs.tar
rm /tmp/rootfs/etc/systemd/system/internalstorage.mount
cp /tmp/rootfs/boot/nonlinear-labs-2D.dtb /tmp/rootfs/boot/am335x-boneblack.dtb

sync
