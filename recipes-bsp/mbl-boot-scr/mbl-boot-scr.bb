# Copyright (c) 2018 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT

SUMMARY = "U-boot boot scripts for mbed Linux"
HOMEPAGE = "https://github.com/ARMmbed/meta-mbl"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"
DEPENDS = "u-boot-mkimage-native dtc-native mbl-console-image-initramfs openssl-native"
RCONFLICTS_${PN} = "rpi-u-boot-scr"

FILESEXTRAPATHS_append := "${THISDIR}/files:"

SRC_URI = "file://boot.cmd"

SRC_URI_append_imx7s-warp := " file://boot.its"

inherit mbl-artifact-names

do_compile() {
}

do_compile_append_imx7s-warp() {
    openssl genrsa -out ${DEPLOY_DIR_IMAGE}/mblkey.key 2048
    openssl req -batch -new -x509 -key ${DEPLOY_DIR_IMAGE}/mblkey.key -out ${DEPLOY_DIR_IMAGE}/mblkey.crt
    ln -sf ${DEPLOY_DIR_IMAGE}/mblkey.key mblkey.key
    ln -sf ${DEPLOY_DIR_IMAGE}/mblkey.crt mblkey.crt
    ln -sf ${DEPLOY_DIR_IMAGE}/zImage ${WORKDIR}/zImage
    ln -sf ${DEPLOY_DIR_IMAGE}/mbl-console-image-initramfs-imx7s-warp-mbl.cpio.gz ${WORKDIR}/mbl-console-image-initramfs-imx7s-warp-mbl.cpio.gz
    uboot-mkimage -f "${WORKDIR}/boot.its" -k ${B} boot.scr
}

do_compile_append_raspberrypi3-mbl() {
    if [ ! -e "${MBL_KEYSTORE_DIR}/${MBL_FIT_ROT_KEY_FILENAME}.key" ]; then
        openssl genrsa -out ${MBL_KEYSTORE_DIR}/${MBL_FIT_ROT_KEY_FILENAME}.key 2048
        openssl req -batch -new -x509 -key ${MBL_KEYSTORE_DIR}/${MBL_FIT_ROT_KEY_FILENAME}.key -out ${MBL_KEYSTORE_DIR}/${MBL_FIT_ROT_KEY_FILENAME}.crt
    fi
}

inherit deploy

do_deploy() {
    install -d ${DEPLOYDIR}
    install -m 0644 ${WORKDIR}/${MBL_UBOOT_CMD_FILENAME} ${DEPLOYDIR}
}

addtask do_deploy after do_compile before do_build
