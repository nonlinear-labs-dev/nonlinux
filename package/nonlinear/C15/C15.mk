################################################################################
#
# C15
#
################################################################################

C15_VERSION = master
C15_SITE = https://github.com/nonlinear-labs-dev/C15.git
C15_SITE_METHOD = git
C15_LICENSE = GPLv3+
C15_LICENSE_FILES = COPYING
C15_DEPENDENCIES = util-linux glibmm libsoup avahi dbus host-gwt
C15_SOURCE_DIR = $(C15_DIR)
C15_INSTALL_TARGET = YES
C15_CONF_OPTS += -DBUILD_AUDIOENGINE=Off -DBUILD_PLAYGROUND=Off -DCMAKE_BUILD_TYPE=Release -DJARSDIR=$(GWT_COMPILER_DIR)
C15_SUPPORTS_IN_SOURCE_BUILD = No

$(eval $(cmake-package))
