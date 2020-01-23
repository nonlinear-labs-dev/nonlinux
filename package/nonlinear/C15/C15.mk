################################################################################
#
# C15
#
################################################################################

C15_VERSION = master
C15_SITE = /sources/projects
C15_SITE_METHOD = local
C15_LICENSE = GPLv3+
C15_LICENSE_FILES = COPYING
C15_DEPENDENCIES = util-linux glibmm libsoup boost systemd
C15_SOURCE_DIR = $(C15_DIR)
C15_INSTALL_TARGET = YES
C15_CONF_OPTS += -DBUILD_AUDIOENGINE=Off -DBUILD_PLAYGROUND=Off -DBUILD_ONLINEHELP=Off -DBUILD_BBBB=On -DBUILD_TEXT2SOLED=On -DBUILD_TESTING=Off -DCMAKE_BUILD_TYPE=Release
C15_SUPPORTS_IN_SOURCE_BUILD = No

$(eval $(cmake-package))
