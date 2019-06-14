# Copyright (c) 2019 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT

SUMMARY = "ARM Platform Security Architecture (PSA) Protected Storage Library"
DEPENDS = ""
HOMEPAGE = "https://github.com/ARMmbed/psa-storage"
DESCRIPTION = "A Linux C library reference implementation of the PSA protected_storage.h API"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = " \
    file://${WORKDIR}/git/LICENSE;md5=302d50a6369f5f22efdb674db908167a \
    file://${WORKDIR}/git/apache-2.0.txt;md5=3b83ef96387f14655fc854ddc3c6bd57 \
    "

SRC_URI = "git://git@github.com/armmbed/psa-storage.git;protocol=ssh;nobranch=1"
SRCREV = "3572fc55c8cc494bfeb442220f8a91542ed7bb99"

PV = "1.0.0+git${SRCPV}"
S = "${WORKDIR}/git"

# Standard make options
EXTRA_OEMAKE = "'CC=${CC}' 'RANLIB=${RANLIB}' 'AR=${AR}' 'CFLAGS=${CFLAGS}' 'BUILDDIR=${S}'"

FILES_${PN} = "${bindir}/ ${includedir}/ ${libdir}/"
# Work around libpsastorage.so.3 symlink error by not including files in dev package.
FILES_${PN}-dev = ""

do_install_append() {
    install -d ${D}${bindir}
    install -d ${D}${libdir}
    install -d ${D}${includedir}/psa
    install -m644 -t ${D}${includedir}/psa ${B}/inc/psa/*.h
    install -m755 -t ${D}${libdir} ${B}/lib/libpsa*
    install -m755 -t ${D}${bindir} ${B}/app/psa-storage-example-app
}

PARALLEL_MAKE = ""
