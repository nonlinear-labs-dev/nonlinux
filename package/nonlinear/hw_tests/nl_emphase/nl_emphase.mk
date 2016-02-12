################################################################################
#
# nl_emphase
#
################################################################################

NL_EMPHASE_VERSION = HEAD
NL_EMPHASE_SITE = https://nonlinear-labs.svn.beanstalkapp.com/emphase_2/beagle_bone/hw_tests/obsolete/nlemphase
NL_EMPHASE_SITE_METHOD = svn
NL_EMPHASE_LICENSE = GPLv3+
NL_EMPHASE_LICENSE_FILES = COPYING
NL_EMPHASE_DEPENDENCIES = 
NL_EMPHASE_TARGET_DIR = $(TARGET_DIR)/nonlinear/hw_tests/nl_emphase
NL_EMPHASE_SOURCE_DIR = $(NL_EMPHASE_DIR)
NL_EMPHASE_INSTALL_TARGET = YES
CROSS = YES

define NL_EMPHASE_INSTALL_TARGET_CMDS
  $(MAKE) -C $(NL_EMPHASE_DIR) CROSS=$(CROSS) install
endef

define NL_EMPHASE_BUILD_CMDS
  $(MAKE) -C $(NL_EMPHASE_SOURCE_DIR) CROSS=$(CROSS) $(EXTRA_MAKE_OPTS) DEST=$(TARGET_DIR)/raumfeld CROSS_PREFIX=$(BASE_DIR)
endef

define NL_EMPHASE_CLEAN_CMDS
  rm -rf $(NL_EMPHASE_TARGET_DIR)
  $(MAKE) -C $(NL_EMPHASE_DIR) CROSS=$(CROSS) clean
  rm -f $(DL_DIR)/$(NL_EMPHASE_SOURCE)
endef

define NL_EMPHASE_EXTRACT_CMDS
  svn co $(NL_EMPHASE_SITE) $(NL_EMPHASE_SOURCE_DIR)
endef

$(eval $(generic-package))

