################################################################################
#
# bbbrtc - https://github.com/bigjosh/bbbrtc
#
################################################################################

BBBRTC_VERSION = HEAD
BBBRTC_SITE = https://github.com/nonlinear-labs-dev/bbbrtc.git
BBBRTC_SITE_METHOD = git
BBBRTC_LICENSE = GPLv3+
BBBRTC_LICENSE_FILES = COPYING
BBBRTC_INSTALL_TARGET = YES

define BBBRTC_BUILD_CMDS
     DESTDIR=$(TARGET_DIR) $(MAKE) -C $(@D) all
     CXX=$(TARGET_CC)
endef

$(eval $(generic-package))
