################################################################################
#
# lpc_bb_driver
#
################################################################################

LPC_BB_DRIVER_MODULE = lpc_bb_driver
LPC_BB_DRIVER_INSTALL_STAGING = YES
LPC_BB_DRIVER_VERSION = master
LPC_BB_DRIVER_SITE = https://github.com/nonlinear-labs-dev/lpc_bb.git
LPC_BB_DRIVER_SITE_METHOD = git
LPC_BB_DRIVER_DEPENDENCIES = linux
LPC_BB_DRIVER_LICENSE = GPLv3+
LPC_BB_DRIVER_LICENSE_FILES = COPYING


define LPC_BB_DRIVER_BUILD_CMDS
  $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules
endef

define LPC_BB_DRIVER_INSTALL_TARGET_CMDS
  $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules_install
endef

$(eval $(generic-package))
