# Copyright (c) 2018 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT
#
# The purpose of this recipe is to copy the MACHINE specific boot.cmd so 
# it can be consumed my mbl-fitimage.bbclass as part of FIT image 
# generation. It would be better to be located under recipe-kernel
# rather than recipe-bsp, and called mbl-fit.bb

SUMMARY = "U-boot boot scripts for mbed Linux"
HOMEPAGE = "https://github.com/ARMmbed/meta-mbl"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"
# todo: remove 
#DEPENDS = " openssl-native"
RCONFLICTS_${PN} = "rpi-u-boot-scr"

FILESEXTRAPATHS_append := "${THISDIR}/files:"

SRC_URI = "file://boot.cmd"

inherit mbl-artifact-names

do_compile() {
}

# todo: remove 
#do_deploy_append() {
#    if [ ! -e "${MBL_KEYSTORE_DIR}/${MBL_FIT_ROT_KEY_FILENAME}.key" ]; then
#        mkdir -p ${MBL_KEYSTORE_DIR}
#        openssl genrsa -out ${MBL_KEYSTORE_DIR}/${MBL_FIT_ROT_KEY_FILENAME}.key 2048
#    fi
#    openssl req -batch -new -x509 -key ${MBL_KEYSTORE_DIR}/${MBL_FIT_ROT_KEY_FILENAME}.key -out ${MBL_KEYSTORE_DIR}/${MBL_FIT_ROT_KEY_FILENAME}.crt
#}

inherit deploy

do_deploy() {
    install -m 0644 ${WORKDIR}/${MBL_UBOOT_CMD_FILENAME} ${DEPLOYDIR}
}

addtask do_deploy after do_compile before do_build
