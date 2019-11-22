# Copyright (c) 2018 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT

inherit mbl-uboot-sign

FILESEXTRAPATHS_prepend := "${THISDIR}/u-boot:"

#SRC_URI = "git://git.denx.de/u-boot.git;protocol=https;nobranch=1"

SRC_URI_append_stm32mp1-dk2-mbl = " \
     file://0001-stm32.patch \
     "

do_configure_prepend_stm32mp1-dk2-mbl() {
    # change default boot partition
    sed -i 's/setenv devplist 1/setenv devplist ${UBOOT_DEFAULT_BOOT_PARTITION}/' ${S}/include/config_distro_bootcmd.h
}

do_compile_append_stm32mp1-dk2-mbl() {
    # Copy device tree to default name for fit image signature verification usage.
    cp dts/dt.dtb ${UBOOT_DTB_BINARY}
}

DCD_FILE_PATH_stm32mp1-dk2-mbl = "${B}"

do_deploy_append() {
	install -D -p -m 0644 ${DCD_FILE_PATH}/u-boot-dtb.cfgout ${DEPLOYDIR}
}

#do_deploy_append() {
#    ln -sf ${UBOOT_NODTB_IMAGE}  ${DEPLOYDIR}/${UBOOT_NODTB_BINARY}
#}
