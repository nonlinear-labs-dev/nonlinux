################################################################################
#
# playground
#
################################################################################

PLAYGROUND_VERSION = HEAD
PLAYGROUND_SITE = https://github.com/nonlinear-labs-dev/C15.git
PLAYGROUND_SITE_METHOD = git
PLAYGROUND_LICENSE = GPLv3+
PLAYGROUND_LICENSE_FILES = COPYING
PLAYGROUND_DEPENDENCIES = util-linux glibmm libsoup avahi dbus host-gwt
PLAYGROUND_SOURCE_DIR = $(PLAYGROUND_DIR)
PLAYGROUND_INSTALL_TARGET = YES
PLAYGROUND_CONF_OPTS += -DBUILD_AUDIOENGINE=Off -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/nonlinear -DJARSDIR=$(GWT_COMPILER_DIR)

$(eval $(cmake-package))
