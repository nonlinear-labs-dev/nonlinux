#!/bin/bash

if [ $# -eq 0 ]; then
    printf "Assuming nonlinear-labs-2D.dtb for device tree. \n"
    DTB_FILE="nonlinear-labs-2D.dtb"
else
    printf "Setting device tree to ${1} \n"
    DTB_FILE="${1}"
fi

# THIS MUST POINT TO BUILT BUILDROOT
SOURCES=$(readlink -f ../nonlinux)
BASEDIR=$(dirname "${0}")

make -C "${BASEDIR}" host-nlimagemaker

NLIMAGEMAKER=`readlink -f "${BASEDIR}/output/host/usr/bin/nlimagemaker"`

echo ${NLIMAGEMAKER}
echo ${SOURCES}

gzip -c ${SOURCES}/output/images/rootfs.tar > ${SOURCES}/output/images/rootfs.tar.gz 
${NLIMAGEMAKER} -k ${BASEDIR}/output/images/uImage -r ${SOURCES}/output/images/rootfs.tar.gz -d ${BASEDIR}/output/images/${DTB_FILE} -o /tmp/nonlinear.img

echo "Image created: /tmp/nonlinear.img"
