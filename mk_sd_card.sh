#!/bin/bash

MOUNT_POINT_ROOT=/tmp/root
MOUNT_POINT_BOOT=/tmp/boot
IMAGE_VERSION_INFO_FILE=${MOUNT_POINT_ROOT}/etc/nonlinear_release
DEVICE="" # Set by $1
DEVICE_P1=""
DEVICE_P2=""


function usage {
	printf "Usage:\n\n"
	printf "$0 <PATH TO CARD>\n";
	printf "example: sudo $0 /dev/mmcblk0\n"
	exit -1
}

function is_mounted {
	if [ "$(cat /proc/mounts | grep $1)" = "" ]; then
		return 0
	else
		return 1
	fi
}

function write_release_file {
	printf "Nonlinear Labs Nonlinux Version:\n" > ${IMAGE_VERSION_INFO_FILE}
	printf "Nonlinux based on SHA1: $(git -C rev-parse HEAD)\n" >> ${IMAGE_VERSION_INFO_FILE}
	printf "Image Built: $(date)\n" >> ${IMAGE_VERSION_INFO_FILE}
	printf "Snapshot: $(git rev-parse --abbrev-ref HEAD)"
}

function check_if_mounted_and_unmount {
	PARTITIONS=$(ls "$DEVICE"?* 2>/dev/null)
	if [ -n "$PARTITIONS" ]; then
		printf "Checking mountpoints:\n"
	fi

	for partition in $PARTITIONS; do
		is_mounted $partition
		if [ $? -eq 1 ]; then
			printf "  $partition: is mounted. Unmounting...\n"
			umount "$partition" 2>/dev/null
		else
			printf "  $partition: is not mounted. Ok...\n"
		fi
	done
	printf "\n"
}


# usage:
#  get_partition "/dev/sdc" "1"
#  returns "/dev/sdc1"
#  get_partition "/dev/mmcblk0" "2"
#  returns "/dev/mmcblk0p2"
function get_partition {
[[ $1 == *"/dev/mmcblk"* ]] && echo "${1}p${2}"
[[ $1 == *"/dev/sd"* ]] && echo "${1}${2}"
}


###############################################################################

if [ "$(id -u)" != "0" ]; then
	echo "This script must be run as root" 1>&2
	exit -1
fi

if [ -z "$1" ]; then
	usage
fi

if [ -b "$1" ]; then
	DEVICE=$1
	DEVICE_P1=$(get_partition $DEVICE 1)
	DEVICE_P2=$(get_partition $DEVICE 2)
	printf "Working on:\n"
	printf "  $DEVICE\n"
	printf "    $DEVICE_P1  boot\n"
	printf "    $DEVICE_P2  rootfs\n\n"
else
	printf "Device $1 does not seem to be a block device!\n"
	exit -1
fi

check_if_mounted_and_unmount

printf "Flushing old partition table...\n"
dd if=/dev/zero of=$DEVICE bs=1024 count=1024 2>/dev/null 1>/dev/null && sync

printf "Creating new partition table...\n"
echo -e ',50M,c,*\n,\n' | sudo sfdisk $DEVICE 2>/dev/null 1>/dev/null && sync

printf "Creating Partitions...\n"
mkfs.vfat -n BOOT ${DEVICE_P1} 1>/dev/null 2>/dev/null
mkfs.ext3 ${DEVICE_P2} 1>/dev/null 2>/dev/null

printf "Rereading partition table...\n"
partprobe $DEVICE && sync

printf "Mounting at rootfs at $MOUNT_POINT_ROOT\n"
mkdir -p ${MOUNT_POINT_ROOT}
mount ${DEVICE_P2} ${MOUNT_POINT_ROOT}
printf "Copy rootfs to target...\n"
tar -C ${MOUNT_POINT_ROOT} -xf output/images/rootfs.tar && sync
printf "Updating build information in target fs...\n"
write_release_file
printf "Unmounting rootfs...\n"
umount ${MOUNT_POINT_ROOT}

printf "Mounting at boot at $MOUNT_POINT_BOOT\n"
mkdir -p ${MOUNT_POINT_BOOT}
mount ${DEVICE_P1} ${MOUNT_POINT_BOOT}
cp -v output/images/u-boot.img ${MOUNT_POINT_BOOT} && sync
cp -v output/images/MLO ${MOUNT_POINT_BOOT} && sync
printf "Creating uEnv.txt...\n"
echo "uenvcmd=load mmc 0:2 \${loadaddr} boot/uImage; load mmc 0:2 \${fdtaddr} boot/nonlinear-labs-2D.dtb; run mmcargs; bootm \${loadaddr} - \${fdtaddr}" > ${MOUNT_POINT_BOOT}/uEnv.txt
printf "Unmounting boot...\n"
umount ${MOUNT_POINT_BOOT}

printf "Cleaning up...\n"
printf "Done."

