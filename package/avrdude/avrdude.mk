################################################################################
#
# avrdude
#
################################################################################

AVRDUDE_VERSION = eabe067c4527bc2eedc5db9288ef5cf1818ec720
AVRDUDE_SITE = $(call github,kcuzner,avrdude,$(AVRDUDE_VERSION))
AVRDUDE_LICENSE = GPLv2+
AVRDUDR_LICENSE_FILES = avrdude/COPYING
AVRDUDE_SUBDIR = avrdude
# Sources coming from git, without generated configure and Makefile.in
# files.
AVRDUDE_AUTORECONF = YES
AVRDUDE_DEPENDENCIES = elfutils libusb libusb-compat ncurses \
	host-flex host-bison
AVRDUDE_LICENSE = GPLv2+
AVRDUDE_LICENSE_FILES = avrdude/COPYING

ifeq ($(BR2_PACKAGE_LIBFTDI1),y)
AVRDUDE_DEPENDENCIES += libftdi1
else ifeq ($(BR2_PACKAGE_LIBFTDI),y)
AVRDUDE_DEPENDENCIES += libftdi
endif

# if /etc/avrdude.conf exists, the installation process creates a
# backup file, which we do not want in the context of Buildroot.
define AVRDUDE_REMOVE_BACKUP_FILE
	$(RM) -f $(TARGET_DIR)/etc/avrdude.conf.bak
endef

AVRDUDE_POST_INSTALL_TARGET_HOOKS += AVRDUDE_REMOVE_BACKUP_FILE
AVRDUDE_CONF_OPTS=--enable-linuxgpio

$(eval $(autotools-package))
