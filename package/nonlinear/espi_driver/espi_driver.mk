################################################################################
#
# espi_driver
#
################################################################################

ESPI_DRIVER_MODULE = espi_driver
ESPI_DRIVER_INSTALL_STAGING = YES
ESPI_DRIVER_VERSION = master
ESPI_DRIVER_SITE = /sources/projects/bbb/espi-driver
ESPI_DRIVER_SITE_METHOD = local
ESPI_DRIVER_DEPENDENCIES = linux
ESPI_DRIVER_LICENSE = GPLv3+
ESPI_DRIVER_LICENSE_FILES = COPYING

define ESPI_DRIVER_DELETE_ARTIFACTS
    rsync --delete -avu --chmod=u=rwX,go=rX --exclude .svn --exclude .git --exclude .hg --exclude .bzr --exclude CVS -f 'P buildroot-build/' $(ESPI_DRIVER_SITE)/ $(@D)
endef

ESPI_DRIVER_POST_RSYNC_HOOKS += ESPI_DRIVER_DELETE_ARTIFACTS

define ESPI_DRIVER_BUILD_CMDS
  $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules
endef

define ESPI_DRIVER_INSTALL_TARGET_CMDS
  $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules_install
endef

$(eval $(generic-package))

