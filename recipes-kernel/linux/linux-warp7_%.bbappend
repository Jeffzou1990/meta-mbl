# Copyright (C) 2016 NXP Semiconductors
# Released under the MIT license (see COPYING.MIT for the terms)

SRCREV = "5db494e98fb768a8bb5a93ec3fa71b1a48bda7c5"

KBUILD_DEFCONFIG_imx7s-warp-mbl ?= "warp7_mbl_defconfig"

SRC_URI = "git://git@github.com/ARMmbed/mbl-linux.git;protocol=ssh;nobranch=1"

do_preconfigure() {
	mkdir -p ${B}
	echo "" > ${B}/.config
	CONF_SED_SCRIPT=""

	kernel_conf_variable LOCALVERSION "\"${LOCALVERSION}\""
	kernel_conf_variable LOCALVERSION_AUTO y

	sed -e "${CONF_SED_SCRIPT}" < '${S}/arch/arm/configs/${KBUILD_DEFCONFIG_imx7s-warp-mbl}' >> '${B}/.config'

	if [ "${SCMVERSION}" = "y" ]; then
		# Add GIT revision to the local version
		head=`git --git-dir=${S}/.git rev-parse --verify --short HEAD 2> /dev/null`
		printf "%s%s" +g $head > ${S}/.scmversion
	fi
}
