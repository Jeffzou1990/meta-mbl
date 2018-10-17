SUMMARY = "U-boot boot scripts for mbed Linux"
HOMEPAGE = "https://github.com/ARMmbed/meta-mbl"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"
DEPENDS = "u-boot-mkimage-native dtc-native mbl-console-image-initramfs"
RCONFLICTS_${PN} = "rpi-u-boot-scr"

FILESEXTRAPATHS_append := "${THISDIR}/files:"

SRC_URI = "file://boot.cmd"

SRC_URI_append_imx7s-warp := " file://boot.its"

do_compile[depends] += "virtual/kernel:do_deploy"

do_compile() {
    mkimage -A arm -T script -C none -n "Boot script" -d "${WORKDIR}/boot.cmd" boot.scr
}

do_compile_append_imx7s-warp() {
    ln -sf ${DEPLOY_DIR_IMAGE}/zImage ${WORKDIR}/zImage
    ln -sf ${DEPLOY_DIR_IMAGE}/mbl-console-image-initramfs-imx7s-warp-mbl.cpio.gz ${WORKDIR}/mbl-console-image-initramfs-imx7s-warp-mbl.cpio.gz
    mkimage -f "${WORKDIR}/boot.its" boot.scr
}

inherit deploy

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 boot.scr ${DEPLOYDIR}
}


addtask do_deploy after do_compile before do_build
