############################################################
#
# nonlinear-usb-dts
#
#############################################################

NONLINEAR_USB_DTS_VERSION = $(call qstrip,$(BR2_PACKAGE_NONLINEAR_USB_DTS_VERSION))
NONLINEAR_USB_DTS_SITE = $(call qstrip,$(BR2_PACKAGE_NONLINEAR_USB_DTS_REPOSITORY))
NONLINEAR_USB_DTS_SITE_METHOD = git

NONLINEAR_USB_DTS_DEPENDENCIES = linux

define NONLINEAR_USB_DTS_INSTALL_TARGET_CMDS
          make LINUX_DIR=${LINUX_DIR} HOSTDIR=${HOST_DIR} DESTDIR=${BINARIES_DIR} -C ${NONLINEAR_USB_DTS_DIR}
        @echo "Nonlinear-Labs device-tree blobs created in ${BINARIES_DIR}"
endef

$(eval $(generic-package))
