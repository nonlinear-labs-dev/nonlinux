################################################################################
#
# C15
#
################################################################################

C15_VERSION = master
C15_SITE = /sources
C15_SITE_METHOD = local

define DELETE_ARTIFACTS
    rsync --delete -avu --chmod=u=rwX,go=rX --exclude .svn --exclude .git --exclude .hg --exclude .bzr --exclude CVS -f 'P buildroot-build/' $(C15_SITE)/ $(@D)
    rm -rf $(@D)/projects/NonMaps/target
    rm -rf $(@D)/projects/parameter-db/src/.~*
endef

C15_POST_RSYNC_HOOKS += DELETE_ARTIFACTS

C15_LICENSE = GPLv3+
C15_LICENSE_FILES = COPYING
C15_DEPENDENCIES = util-linux glibmm libsoup boost systemd freetype
C15_SOURCE_DIR = $(C15_DIR)
C15_INSTALL_TARGET = YES
C15_CONF_OPTS += -DBUILD_BBB_SCRIPTS=On -DBUILD_BRIDGE=On -DBUILD_TEXT2SOLED=On -DBUILD_PLAYCONTROLLER_TOOLS=On -DCMAKE_BUILD_TYPE=Release
C15_SUPPORTS_IN_SOURCE_BUILD = No

$(eval $(cmake-package))
