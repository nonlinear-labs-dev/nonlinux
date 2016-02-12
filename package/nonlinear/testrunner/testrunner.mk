################################################################################
#
# testrunner
#
################################################################################

TESTRUNNER_MODULE = testrunner
TESTRUNNER_INSTALL_STAGING = YES
TESTRUNNER_VERSION = master
TESTRUNNER_SITE = git@nonlinear-labs.git.beanstalkapp.com:/nonlinear-labs/testrunner.git
TESTRUNNER_SITE_METHOD = git
TESTRUNNER_DEPENDENCIES = espi_driver boost
TESTRUNNER_LICENSE = GPLv3+
TESTRUNNER_LICENSE_FILES = COPYING
TESTRUNNER_TARGET_DIR= $(TARGET_DIR)/nonlinear
CROSS=YES

$(eval $(generic-package))

define TESTRUNNER_INSTALL_TARGET_CMDS
  $(MAKE) -C $(TESTRUNNER_DIR) CROSS=$(CROSS) install
endef

define TESTRUNNER_BUILD_CMDS
  $(MAKE) -C $(TESTRUNNER_DIR) CROSS=$(CROSS) $(EXTRA_MAKE_OPTS) DEST=$(TARGET_DIR)/nonlinear-labs CROSS_PREFIX=$(BASE_DIR)
endef

define TESTRUNNER_CLEAN_CMDS
  rm -rf $(TESTRUNNER_TARGET_DIR)
  $(MAKE) CROSS=$(CROSS) clean
  rm -f $(DL_DIR)/$(TESTRUNNER_SOURCE)
endef
