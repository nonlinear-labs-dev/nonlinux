################################################################################
#
# phyreg - https://github.com/bigjosh/phyreg
#
################################################################################

PHYREG_VERSION = HEAD
PHYREG_SITE = https://github.com/nonlinear-labs-dev/phyreg.git
PHYREG_SITE_METHOD = git
PHYREG_LICENSE = GPLv3+
PHYREG_LICENSE_FILES = COPYING
PHYREG_INSTALL_TARGET = YES

define PHYREG_BUILD_CMDS
     DESTDIR=$(TARGET_DIR) $(MAKE) -C $(@D) install
endef

$(eval $(generic-package))
