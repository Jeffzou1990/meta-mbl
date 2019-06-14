# Copyright (c) 2019 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT

SUMMARY = "todo: mbl-psa"
#SECTION = "libs"
DEPENDS = ""
HOMEPAGE = "https://github.com/ARMmbed/mbl-psa"
DESCRIPTION = ""

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = " \
    file://${WORKDIR}/git/LICENSE;md5=302d50a6369f5f22efdb674db908167a \
    file://${WORKDIR}/git/apache-2.0.txt;md5=3b83ef96387f14655fc854ddc3c6bd57 \
    "

SRC_URI = "git://git@github.com/simonqhughes/mbed-psa.git;protocol=ssh;nobranch=1"
# SRCREV without lib/Makefile changes 20190614
#SRCREV = "5103adc29dfe89e1362454df752e3a7743404c34"
# SRCREV with lib/Makefile changes 20190614
#SRCREV = "cc2278a5fc8ae3c760164b23ccf060b4b2f0fd35"
# SRCREV with app/Makefile changes for LOCAL_XFLAGS
SRCREV = "09b097f9157193a05eae75601d775cdd48948827"
# SRCREV with app/Makefile .c.0 rule inclding LOCAL_XFLAGS
SRCREV = "69b06e733079c106ce1bfac0c366b957b78535b7"



PV = "1.0.0+git${SRCPV}"

S = "${WORKDIR}/git"

#EXTRA_OEMAKE = "'CC=${CC}' 'RANLIB=${RANLIB}' 'AR=${AR}' 'CFLAGS=${CFLAGS} -I${S}/include -DWITHOUT_XATTR' 'BUILDDIR=${S}'"
#EXTRA_OEMAKE = ""
#EXTRA_OEMAKE = "'CC=${CC}' 'RANLIB=${RANLIB}' 'AR=${AR}' 'CFLAGS=${CFLAGS} -I${S}/inc 'BUILDDIR=${S}'"
#not working EXTRA_OEMAKE = "CC=${CC} RANLIB=${RANLIB} AR=${AR} CFLAGS=${CFLAGS} -I${S}/inc BUILDDIR=${S}"
#EXTRA_OEMAKE = "'CC=${CC}' 'RANLIB=${RANLIB}' 'AR=${AR}' 'CFLAGS=${CFLAGS}' -I${S}/inc -I${S}/inc/mbedtls -I${S}/inc/psa 'BUILDDIR=${S}'"
# removing -I and putting in CFLAGS

# "-I${S}/inc/mbedtls -I${S}/inc/psa 
#CFLAGS =+ " -I${S}/inc  -I${S}/inc/mbedtls -I${S}/inc/psa "
EXTRA_OEMAKE = "'CC=${CC}' 'RANLIB=${RANLIB}' 'AR=${AR}' 'CFLAGS=${CFLAGS}' 'BUILDDIR=${S}'"


FILES_${PN}-test = "${bindir}/ ${includedir}/ ${libdir}/"

do_install_append() {
#    oe_runmake install BINDIR=${D}/${bindir} LIBDIR=${D}/${libdir} INCLUDEDIR=${D}/${includedir}
    install -d ${D}${bindir}
    install -d ${D}${libdir}
    install -d ${D}${includedir}/psa
    install -m644 -t ${D}${includedir} ${B}/inc/*.h
    install -m644 -t ${D}${includedir}/psa ${B}/inc/psa/*.h
	# todo: fix me: lib name should be libmblpsa not libmbedpsa
    install -m644 -t ${D}${libdir} ${B}/lib/libmbedpsa*
    install -m644 -t ${D}${bindir} ${B}/app/app
}


#PACKAGES =+ "mtd-utils-jffs2 mtd-utils-ubifs mtd-utils-misc"
#PACKAGES="${PN}"
#PACKAGES = "${PN}-test"
PACKAGES =+ "mbl-psa-test"

#FILES_mtd-utils-jffs2 = "${sbindir}/mkfs.jffs2 ${sbindir}/jffs2dump ${sbindir}/jffs2reader ${sbindir}/sumtool"
#FILES_mtd-utils-ubifs = "${sbindir}/mkfs.ubifs ${sbindir}/ubi*"
#FILES_mtd-utils-misc = "${sbindir}/nftl* ${sbindir}/ftl* ${sbindir}/rfd* ${sbindir}/doc* ${sbindir}/serve_image ${sbindir}/recv_image"
# package all files that are installed
#FILES_${PN} = "${bindir}/* ${libdir}/* ${includedir}/*"
#FILES_${PN}-test = "${bindir}/* ${libdir}/* ${includedir}/*"
#FILES_${PN} = "${bindir}/* ${libdir}/* ${includedir}/*"
#FILES_mbl-psa-test = "${bindir}/* ${libdir}/* ${includedir}/*"
#FILES_mbl-psa-test = "${libdir}/libmblpsa.so"

PARALLEL_MAKE = ""

do_rm_work() {
	echo "do nothing"
}
