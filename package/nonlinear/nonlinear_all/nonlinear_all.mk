################################################################################
#
# nonlinear_all
#
################################################################################

NONLINEAR_ALL_VERSION = 1.0.0
NONLINEAR_ALL_SITE = /dev
NONLINEAR_ALL_SOURCE = null
NONLINEAR_ALL_SITE_METHOD = file
NONLINEAR_ALL_LICENSE = GPLv3+
NONLINEAR_ALL_LICENSE_FILES = COPYING

PACKAGES_TO_CARE_FOR = libnlemphase libnlfonts lpc_bb_driver espi_driver playground

define NONLINEAR_ALL_EXTRACT_CMDS
endef

define NONLINEAR_ALL_CONFIGURE_CMDS
endef

define NONLINEAR_ALL_BUILD_CMDS
	echo "deleting tar balls from dl directroy..."
	$(foreach lib, $(PACKAGES_TO_CARE_FOR), rm -f $(BR2_DL_DIR)/$(lib)-HEAD.tar.gz;)
	$(foreach lib, $(PACKAGES_TO_CARE_FOR), make $(lib)-dirclean;)
	$(foreach lib, $(PACKAGES_TO_CARE_FOR), make $(lib)-clean-for-rebuild;)	
	$(foreach lib, $(PACKAGES_TO_CARE_FOR), make $(lib)-rebuild;)	
	$(foreach lib, $(PACKAGES_TO_CARE_FOR), make $(lib);)
endef

define NONLINEAR_ALL_INSTALL_CMDS
endef

define NONLINEAR_ALL_INSTALL_TARGET_CMDS
endef

define NONLINEAR_ALL_CLEAN_CMDS
endef


$(eval $(generic-package))

