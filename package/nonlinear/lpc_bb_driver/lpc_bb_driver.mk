################################################################################
#
# lpc_bb_driver
#
################################################################################

LPC_BB_DRIVER_MODULE = lpc_bb_driver
LPC_BB_DRIVER_INSTALL_STAGING = YES
LPC_BB_DRIVER_VERSION = master
LPC_BB_DRIVER_SITE = /sources/projects/bbb-lpc-driver
LPC_BB_DRIVER_SITE_METHOD = local
LPC_BB_DRIVER_DEPENDENCIES = linux

define LPC_BB_DRIVER_DELETE_ARTIFACTS
    rsync --delete -avu --chmod=u=rwX,go=rX --exclude .svn --exclude .git --exclude .hg --exclude .bzr --exclude CVS -f 'P buildroot-build/' $(LPC_BB_DRIVER_SITE)/ $(@D)
endef

LPC_BB_DRIVER_POST_RSYNC_HOOKS += LPC_BB_DRIVER_DELETE_ARTIFACTS

define LPC_BB_DRIVER_BUILD_CMDS
  $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules
endef

define LPC_BB_DRIVER_INSTALL_TARGET_CMDS
  $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules_install
endef

$(eval $(generic-package))
