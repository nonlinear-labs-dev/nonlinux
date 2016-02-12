################################################################################
#
# libnlaudiocontrol
#
################################################################################

LIBNLAUDIOCONTROL_MODULE = audiocontrol
LIBNLAUDIOCONTROL_INSTALL_STAGING = YES
LIBNLAUDIOCONTROL_VERSION = HEAD
LIBNLAUDIOCONTROL_SITE = https://nonlinear-labs.svn.beanstalkapp.com/emphase_2/beagle_bone/libnlaudiocontrol
LIBNLAUDIOCONTROL_SITE_METHOD = svn
LIBNLAUDIOCONTROL_LICENSE = GPLv3+
LIBNLAUDIOCONTROL_LICENSE_FILES = COPYING
LIBNLAUDIOCONTROL_AUTORECONF = YES

$(eval $(autotools-package))
