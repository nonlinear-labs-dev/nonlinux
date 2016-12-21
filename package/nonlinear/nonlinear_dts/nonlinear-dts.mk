############################################################
#
# raumfeld-dts
#
#############################################################

NONLINEAR_DTS_VERSION = $(call qstrip,$(BR2_PACKAGE_NONLINEAR_DTS_VERSION))
NONLINEAR_DTS_SITE = $(call qstrip,$(BR2_PACKAGE_NONLINEAR_DTS_REPOSITORY))
NONLINEAR_DTS_SITE_METHOD = git

NONLINEAR_DTS_DEPENDENCIES = linux

define NONLINEAR_DTS_INSTALL_TARGET_CMDS
	  make LINUX_DIR=${LINUX_DIR} HOSTDIR=${HOST_DIR} DESTDIR=${TARGET_DIR}/boot/ -C ${NONLINEAR_DTS_DIR}
	@echo "Nonlinear-Labs device-tree blobs created in ${TARGET_DIR}/boot"
endef

$(eval $(generic-package))
