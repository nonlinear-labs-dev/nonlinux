################################################################################
#
# scsx
#
################################################################################

SCSX_VERSION = HEAD
SCSX_SITE = https://nonlinear-labs.svn.beanstalkapp.com/emphase_2/beagle_bone/hw_tests/scsx
SCSX_SITE_METHOD = svn
SCSX_LICENSE = GPLv3+
SCSX_LICENSE_FILES = COPYING
SCSX_DEPENDENCIES = 
SCSX_TARGET_DIR = $(TARGET_DIR)/nonlinear/hw_tests/scsx
SCSX_SOURCE_DIR = $(SCSX_DIR)
SCSX_INSTALL_TARGET = YES
CROSS = YES

define SCSX_INSTALL_TARGET_CMDS
  $(MAKE) -C $(SCSX_DIR) CROSS=$(CROSS) install
endef

define SCSX_BUILD_CMDS
  $(MAKE) -C $(SCSX_SOURCE_DIR) CROSS=$(CROSS) $(EXTRA_MAKE_OPTS) DEST=$(TARGET_DIR)/raumfeld CROSS_PREFIX=$(BASE_DIR)
endef

define SCSX_CLEAN_CMDS
  rm -rf $(SCSX_TARGET_DIR)
  $(MAKE) -C $(SCSX_DIR) CROSS=$(CROSS) clean
  rm -f $(DL_DIR)/$(SCSX_SOURCE)
endef

define SCSX_EXTRACT_CMDS
  svn co $(SCSX_SITE) $(SCSX_SOURCE_DIR)
endef

$(eval $(generic-package))

