# Copyright (c) 2018 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT

inherit mbl-uboot-sign

# Don't let meta-raspberrypi's boot script overwrite meta-mbl's
# RDEPENDS_${PN}_remove = "rpi-u-boot-scr"
# DEPENDS_remove = "rpi-u-boot-scr"

FILESEXTRAPATHS_prepend := "${THISDIR}/u-boot:"

SRC_URI = "git://git.denx.de/u-boot.git;protocol=https;nobranch=1"

SRC_URI_append_stm32mp1-dk2-mbl = " \
     file://0001-ARM-arm-smccc-Remove-dependency-on-PSCI.patch \
     file://0002-imx-mx7-avoid-some-initialization-if-low-level-is-sk.patch \
     file://0003-optee-adjust-dependencies-and-default-values-for-dra.patch \
     file://0004-warp7-include-configs-set-skip-low-level-init.patch \
     file://0005-warp7-configs-add-bl33-defconfig.patch \
     file://0006-warp7_bl33-configs-Enable-FIT-as-the-boot.scr-format.patch \
     file://0007-warp7-include-configs-Differentiate-bootscript-addre.patch \
     file://0008-warp7-include-configs-Specify-image-name-of-bootscri.patch \
     file://0009-warp7-Build-dtb-into-u-boot.patch \
     file://0010-warp7_bl33-configs-Enable-CONFIG_OF_LIBFDT_OVERLAY.patch \
     file://0011-warp7-include-configs-Specify-an-fdtovaddr.patch \
     file://0012-cmd-image_info-Add-checking-of-default-FIT-config.patch \
     file://0013-pico-Modify-defconfig-to-support-boot.scr.patch \
     file://0014-pico-Disable-SPL-and-add-DCD-file.patch \
     file://0015-pico-change-bits-in-DCD.patch \
     file://0016-pico-switch-to-bl33-in-defconfig.patch \
     file://0017-pico-enable-bootz-and-pre-console-buffer.patch \
     file://0018-serial-add-skipping-init-option.patch \
     file://0019-pico-skip-uart-initialization.patch \
     file://0020-picopi-Build-dtb-into-u-boot.patch \
     file://0021-pico-convert-uboot-to-support-fit-image.patch \
     file://0022-pico-fall-back-to-hab_failsafe-when-fitimage-fail.patch \
     file://0023-warp7-check-fitimage-before-running-boot-script.patch \
     file://0024-pico-shrink-DRAM-size-to-avoid-memory-override.patch \
     ${@bb.utils.contains_any('PACKAGECONFIG','noconsole silent',' file://0002-set-silent-envs.patch','',d)} \
     ${@bb.utils.contains('PACKAGECONFIG','minimal',' file://0002-enable-net-without-net-commands.patch','',d)} \
     "

do_configure_prepend_stm32mp1-dk2-mbl() {
    # change default boot partition
    sed -i 's/setenv devplist 1/setenv devplist ${UBOOT_DEFAULT_BOOT_PARTITION}/' ${S}/include/config_distro_bootcmd.h
}

do_compile_append_stm32mp1-dk2-mbl() {
    # Copy device tree to default name for fit image signature verification usage.
    cp dts/dt.dtb ${UBOOT_DTB_BINARY}
}

# DCD_FILE_PATH_stm32mp1-dk2-mbl = "${B}"

do_deploy_append() {
	install -D -p -m 0644 ${DCD_FILE_PATH}/u-boot-dtb.cfgout ${DEPLOYDIR}
}

#do_deploy_append() {
#    ln -sf ${UBOOT_NODTB_IMAGE}  ${DEPLOYDIR}/${UBOOT_NODTB_BINARY}
#}
