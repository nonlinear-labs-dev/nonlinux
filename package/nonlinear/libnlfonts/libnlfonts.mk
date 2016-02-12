#############################################################
#
# libnlfonts
#
#############################################################

LIBNLFONTS_VERSION = HEAD
LIBNLFONTS_SOURCE = libnlfonts-$(LIBNLFONTS_VERSION).tar.gz
LIBNLFONTS_SITE = git@nonlinear-labs.git.beanstalkapp.com:/nonlinear-labs/libnlfonts.git 
LIBNLFONTS_LICENSE_FILES = COPYING
LIBNLFONTS_SITE_METHOD = git
LIBNLFONTS_LICENSE = GPLv3+
LIBNLFONTS_DEPENDENCIES = libnlemphase

define LIBNLFONTS_BUILD_CMDS
	$(MAKE) -C $(LIBNLFONTS_DIR) HOST_DIR=$(HOST_DIR) TARGET_DIR=$(TARGET_DIR) CROSS=YES
endef

define LIBNLFONTS_INSTALL_TARGET_CMDS
	$(MAKE) -C $(LIBNLFONTS_DIR) install HOST_DIR=$(HOST_DIR) TARGET_DIR=$(TARGET_DIR) CROSS=YES
endef

$(eval $(generic-package))
