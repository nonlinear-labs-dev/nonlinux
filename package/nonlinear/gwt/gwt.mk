################################################################################
#
# GWT
#
################################################################################

HOST_GWT_VERSION = 2.8.2
HOST_GWT_SITE = https://storage.googleapis.com/gwt-releases
HOST_GWT_SOURCE = gwt-$(HOST_GWT_VERSION).zip
HOST_GWT_SOURCE_DIR = $(HOST_GWT_DIR)
GWT_COMPILER_DIR = $(HOST_DIR)/gwt-$(HOST_GWT_VERSION)

define HOST_GWT_EXTRACT_CMDS
	unzip -u $(BR2_DL_DIR)/$(HOST_GWT_SOURCE) gwt-2.8.2/gwt-\*.jar -d $(HOST_DIR)
endef

$(eval $(host-generic-package))
