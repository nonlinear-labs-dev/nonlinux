################################################################################
#
# mxli
#
################################################################################

MXLI_VERSION = 3.1
MXLI_SOURCE = c-linux-mxli-3.1.tar.bz2
MXLI_SITE = http://www.windscooting.com/softy
MXLI_TARGET_DIR = $(TARGET_DIR)/nonlinear/scripts/mxli
MXLI_INSTALL_TARGET = YES

define MXLI_BUILD_CMDS
	$(MAKE) $(TARGET_CONFIGURE_OPTS) LDFLAGS="-L$(@D)/lib/c-linux -L$(@D)/lib -L$(@D)/lib/c-any" CFLAGS="-I$(@D)/lib/c-linux -I$(@D)/lib -I$(@D)/lib/c-any" -C $(@D)
	$(MAKE) $(TARGET_CONFIGURE_OPTS) LDFLAGS="-L$(@D)/lib/c-linux -L$(@D)/lib -L$(@D)/lib/c-any" CFLAGS="-I$(@D)/lib/c-linux -I$(@D)/lib -I$(@D)/lib/c-any" -C $(@D)/programs/mxli3
endef

define MXLI_INSTALL_TARGET_CMDS
	$(INSTALL) -D -m 0755 $(@D)/programs/mxli3/mxli $(MXLI_TARGET_DIR)
endef

$(eval $(generic-package))

