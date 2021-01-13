!/bin/bash

# THIS MUST POINT TO BUILT BUILDROOT
SOURCES=$(readlink -f ../nonlinux)


BASEDIR=$(dirname "${0}")

make -C "${BASEDIR}" host-nlimagemaker

NLIMAGEMAKER=`readlink -f "${BASEDIR}/output/host/usr/bin/nlimagemaker"`

echo ${NLIMAGEMAKER}
echo ${SOURCES}

${NLIMAGEMAKER} -k ${BASEDIR}/output/images/uImage -r ${SOURCES}/output/images/rootfs.tar -d ${BASEDIR}/output/images/am335x-boneblack.dtb -o /tmp/nonlinear.img

echo "Image created: /tmp/nonlinear.img"
