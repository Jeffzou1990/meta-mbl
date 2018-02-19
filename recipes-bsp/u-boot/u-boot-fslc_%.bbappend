SRCREV = "224318f95f9e41f916579a20f3275ff3773f9c94"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI = "git://git.linaro.org/landing-teams/working/mbl/u-boot.git;protocol=https;nobranch=1 \
file://files/0001-warp7-use-UART6-in-secure-defconfig.patch "

UBOOT_CONFIG[sd] = "warp7_secure_defconfig,sdcard"

do_deploy_append_imx7s-warp-mbl() {

	install -d ${DEPLOYDIR}
	install -m 0644 ${B}/warp7_secure_defconfig/u-boot.cfg ${DEPLOYDIR}
	install -m 0644 ${B}/warp7_secure_defconfig/board/warp7/imximage.cfg.cfgtmp ${DEPLOYDIR}
	install -m 0644 ${B}/warp7_secure_defconfig/u-boot.bin ${DEPLOYDIR}
}
