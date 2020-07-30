################################################################################
#
# playcontroller_driver
#
################################################################################

PLAYCONTROLLER_DRIVER_MODULE = playcontroller_driver
PLAYCONTROLLER_DRIVER_INSTALL_STAGING = YES
PLAYCONTROLLER_DRIVER_VERSION = master
PLAYCONTROLLER_DRIVER_SITE = /sources/projects/bbb/playcontroller-driver
PLAYCONTROLLER_DRIVER_SITE_METHOD = local
PLAYCONTROLLER_DRIVER_DEPENDENCIES = linux

define PLAYCONTROLLER_DRIVER_DELETE_ARTIFACTS
    rsync --delete -avu --chmod=u=rwX,go=rX --exclude .svn --exclude .git --exclude .hg --exclude .bzr --exclude CVS -f 'P buildroot-build/' $(PLAYCONTROLLER_DRIVER_SITE)/ $(@D)
endef

PLAYCONTROLLER_DRIVER_POST_RSYNC_HOOKS += PLAYCONTROLLER_DRIVER_DELETE_ARTIFACTS

define PLAYCONTROLLER_DRIVER_BUILD_CMDS
  $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules
endef

define PLAYCONTROLLER_DRIVER_INSTALL_TARGET_CMDS
  $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules_install
endef

$(eval $(generic-package))
