################################################################################
#
# playground
#
################################################################################

PLAYGROUND_VERSION = HEAD
PLAYGROUND_SITE = git@nonlinear-labs.git.beanstalkapp.com:/nonlinear-labs/playground.git
PLAYGROUND_SITE_METHOD = git
PLAYGROUND_LICENSE = GPLv3+
PLAYGROUND_LICENSE_FILES = COPYING
PLAYGROUND_DEPENDENCIES = util-linux glibmm libsoup libnlaudiocontrol libnlemphase libnlfonts avahi dbus
PLAYGROUND_TARGET_DIR = $(TARGET_DIR)/nonlinear/playground
PLAYGROUND_SOURCE_DIR = $(PLAYGROUND_DIR)
PLAYGROUND_INSTALL_TARGET = YES
PLAYGROUND_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/nonlinear/playground

$(eval $(cmake-package))
