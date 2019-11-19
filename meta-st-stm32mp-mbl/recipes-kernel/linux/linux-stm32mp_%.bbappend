# Based on: recipes-kernel/linux/linux-warp7_4.1.bb
# In open-source project: https://github.com/Freescale/meta-freescale-3rdparty
#
# Original file: Copyright (C) 2016 NXP Semiconductors
# Modifications: Copyright (c) 2018 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT

PV = "${LINUX_VERSION}+git${SRCPV}"
LINUX_VERSION = "4.14.112"
SRCREV = "46d7ce67b4e5bab34e42b4e857a7e0cbe9580998"

KBUILD_DEFCONFIG_stm32mp1-dk2-mbl ?= "stm32mp15_trusted_defconfig"

FILESEXTRAPATHS_prepend:="${THISDIR}/files:"

SRC_URI = "git://git@github.com/ARMmbed/linux-mbl.git;protocol=ssh;nobranch=1 \
           file://0001-menuconfig-check-lxdiaglog.sh-Allow-specification-of.patch \
           file://mqueue-mbl.cfg \
           file://cgroups-mbl.cfg \
           file://namespaces-mbl.cfg \
           file://ecryptfs-mbl.cfg \
           "


LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"


# LOADADDR is 0x00080000 by default. But we need to put FIP between
# 0x00020000 ~ 0x00200000. Thus we move kernel to another address.
KERNEL_EXTRA_ARGS += " LOADADDR=0x04000000 "

do_configure_prepend() {
    ${S}/scripts/kconfig/merge_config.sh -m -O ${B} ${B}/.config ${WORKDIR}/*-mbl.cfg
}
do_preconfigure() {
	mkdir -p ${B}
	echo "" > ${B}/.config
	CONF_SED_SCRIPT=""

	kernel_conf_variable LOCALVERSION "\"${LOCALVERSION}\""
	kernel_conf_variable LOCALVERSION_AUTO y

	sed -e "${CONF_SED_SCRIPT}" < '${S}/arch/arm/configs/${KBUILD_DEFCONFIG}' >> '${B}/.config'

	cfgs=`find ${WORKDIR}/ -maxdepth 1 -name '*-mbl.cfg' | wc -l`;
	if [ ${cfgs} -gt 0 ]; then
		${S}/scripts/kconfig/merge_config.sh -m -O ${B} ${B}/.config ${WORKDIR}/*-mbl.cfg
	fi

	if [ "${SCMVERSION}" = "y" ]; then
		# Add GIT revision to the local version
		head=`git --git-dir=${S}/.git rev-parse --verify --short HEAD 2> /dev/null`
		printf "%s%s" +g $head > ${S}/.scmversion
	fi
}

# TO-BE-REMOVED: workaround until the following upstream patch
# gets merged and adapted to warrior-dev branch
# https://patchwork.openembedded.org/patch/161618/
do_clean[depends] += "make-mod-scripts:do_clean"
