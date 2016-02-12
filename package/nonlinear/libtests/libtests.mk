################################################################################
#
# libtest
#
################################################################################

LIBTESTS_MODULE = libtests
LIBTESTS_INSTALL_STAGING = YES
LIBTESTS_VERSION = master
LIBTESTS_SITE = git@nonlinear-labs.git.beanstalkapp.com:/nonlinear-labs/libtests.git
LIBTESTS_SITE_METHOD = git
LIBTESTS_DEPENDENCIES = libnlemphase libnlaudiocontrol
LIBTESTS_LICENSE = GPLv3+
LIBTESTS_LICENSE_FILES = COPYING
LIBTESTS_TARGET_DIR= $(TARGET_DIR)/nonlinear/libtest
CROSS=YES

define LIBTESTS_INSTALL_TARGET_CMDS
  $(MAKE) -C $(LIBTESTS_DIR) CROSS=$(CROSS) DEST=$(LIBTESTS_TARGET_DIR) install
endef

define LIBTESTS_BUILD_CMDS
  $(MAKE) -C $(LIBTESTS_DIR) CROSS=$(CROSS) $(EXTRA_MAKE_OPTS) CROSS_PREFIX=$(BASE_DIR)
endef

define LIBTESTS_CLEAN_CMDS
  rm -Rf $(LIBTESTS_TARGET_DIR)/*
  $(MAKE) CROSS=$(CROSS) clean
  rm -f $(DL_DIR)/$(LIBTESTS_SOURCE)
endef

$(eval $(generic-package))
