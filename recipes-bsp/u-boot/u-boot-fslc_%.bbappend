# Copyright (c) 2018 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT

#<<<<<<< 1aa5f7c0ba47ab6c22ead77e32be642f91618ca9
SRCREV = "407a3560f72a3be781cd062b509a7726406a5c6f"
#DEPENDS_append += " mbl-boot-scr u-boot-tools-native"
#=======
#SRCREV = "bf0774452781b16759512f456d42a2a0f874c220"
#>>>>>>> Add mbl fitimage bbclass

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "git://git.linaro.org/landing-teams/working/mbl/u-boot.git;protocol=https;nobranch=1 "

LIC_FILES_CHKSUM = "file://Licenses/README;md5=30503fd321432fc713238f582193b78e"

DEPENDS += "flex-native bison-native"

do_compile_append_imx7s-warp-mbl() {
	ln -snf ${B}/dts/dt.dtb ${B}/${UBOOT_DTB_BINARY}
}
