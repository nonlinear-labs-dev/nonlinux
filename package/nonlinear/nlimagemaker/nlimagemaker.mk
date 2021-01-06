################################################################################
#
# nlimagemaker
#
################################################################################

NLIMAGEMAKER_VERSION = master
NLIMAGEMAKER_SITE = https://github.com/nonlinear-labs-dev/nlimagemaker.git
NLIMAGEMAKER_SITE_METHOD = git
NLIMAGEMAKER_LICENSE = GPLv3+
NLIMAGEMAKER_LICENSE_FILES = COPYING
NLIMAGEMAKER_DEPENDENCIES =
NLIMAGEMAKER_INSTALL_TARGET = YES
NLIMAGEMAKER_TARGET_DIR = $(TARGET_DIR)/usr/sbin
NLIMAGEMAKER_SOURCE_DIR = $(NLIMAGEMAKER_DIR)
NLIMAGEMAKER_CONF_OPTS += -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX=/usr

$(eval $(cmake-package))
$(eval $(host-cmake-package))
