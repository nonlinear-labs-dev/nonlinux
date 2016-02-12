################################################################################
#
# lpc_bb_driver
#
################################################################################

LPC_BB_DRIVER_MODULE = lpc_bb_driver
LPC_BB_DRIVER_INSTALL_STAGING = YES
LPC_BB_DRIVER_VERSION = HEAD
LPC_BB_DRIVER_SITE = https://nonlinear-labs.svn.beanstalkapp.com/emphase_2/beagle_bone/drivers/lpc_bb_driver
LPC_BB_DRIVER_SITE_METHOD = svn
LPC_BB_DRIVER_DEPENDENCIES = linux
LPC_BB_DRIVER_LICENSE = GPLv3+
LPC_BB_DRIVER_LICENSE_FILES = COPYING

#$(eval $(call GENTARGETS,package,espi_driver))
$(eval $(generic-package))

define LPC_BB_DRIVER_BUILD_CMDS
  $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules
endef

define LPC_BB_DRIVER_EXTRACT_CMDS
  svn co $(LPC_BB_DRIVER_SITE) $(LPC_BB_DRIVER_DIR)
endef

define LPC_BB_DRIVER_INSTALL_TARGET_CMDS
  $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules_install
endef

