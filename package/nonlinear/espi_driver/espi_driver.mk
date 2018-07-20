################################################################################
#
# espi_driver
#
################################################################################

ESPI_DRIVER_MODULE = espi_driver
ESPI_DRIVER_INSTALL_STAGING = YES
ESPI_DRIVER_VERSION = master
ESPI_DRIVER_SITE = git@github.com:nonlinear-labs-dev/espi.git
ESPI_DRIVER_SITE_METHOD = git
ESPI_DRIVER_DEPENDENCIES = linux
ESPI_DRIVER_LICENSE = GPLv3+
ESPI_DRIVER_LICENSE_FILES = COPYING

define ESPI_DRIVER_BUILD_CMDS
  $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules
endef

define ESPI_DRIVER_INSTALL_TARGET_CMDS
  $(MAKE) $(LINUX_MAKE_FLAGS) -C $(LINUX_DIR) M=$(@D) modules_install
endef

$(eval $(generic-package))
