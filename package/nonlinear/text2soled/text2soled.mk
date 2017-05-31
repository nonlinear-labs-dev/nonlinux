################################################################################
#
# text2soled
#
################################################################################

TEXT2SOLED_VERSION = HEAD
TEXT2SOLED_SITE = git@nonlinear-labs.git.beanstalkapp.com:/nonlinear-labs/text2soled.git
TEXT2SOLED_SITE_METHOD = git
TEXT2SOLED_LICENSE = GPLv3+
TEXT2SOLED_LICENSE_FILES = COPYING
TEXT2SOLED_DEPENDENCIES = util-linux glibmm
TEXT2SOLED_TARGET_DIR = $(TARGET_DIR)/nonlinear/text2soled
TEXT2SOLED_SOURCE_DIR = $(TEXT2SOLED_DIR)
TEXT2SOLED_INSTALL_TARGET = YES
TEXT2SOLED_CONF_OPTS += -DCMAKE_BUILD_TYPE=Debug -DCMAKE_INSTALL_PREFIX=/nonlinear/text2soled

$(eval $(cmake-package))
