################################################################################
#
# libnlemphase
#
################################################################################

LIBNLEMPHASE_VERSION = HEAD
LIBNLEMPHASE_SITE = git@nonlinear-labs.git.beanstalkapp.com:/nonlinear-labs/libnlemphase.git
LIBNLEMPHASE_SITE_METHOD = git
LIBNLEMPHASE_LICENSE = GPLv3+
LIBNLEMPHASE_LICENSE_FILES = COPYING
LIBNLEMPHASE_INSTALL_TARGET=YES
LIBNLEMPHASE_INSTALL_STAGING=YES
LIBNLEMPHASE_AUTORECONF = YES

$(eval $(autotools-package))
