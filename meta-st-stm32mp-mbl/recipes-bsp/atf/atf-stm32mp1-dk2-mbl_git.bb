# Copyright (c) 2018 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT

inherit mbl-artifact-names

require recipes-bsp/atf/atf.inc

# This recipe builds the ARM Trusted Firmware for RaspberryPi3.
# - TF-A and OPTEE as 64-bit (aarch64) are built with the aarch64 toolchain
#   because the boot loader of VideoCore4 will boot to 64-bit ARM bootloaders.
#   The TF-A secure monitor changes to 32-bit mode before running U-Boot.
# - The recipe imports mbedtls into the ATF build directory to build libmbedtls.a
#   and incorporated into the firmware.
##DEPENDS += "arm-aarch64-toolchain-native"
                                  "

PLATFORM = "stm32mp1"

ATF_COMPILE_FLAGS += " \
      AARCH32_SP=optee \
      ARCH=aarch32 \
      ARM_ARCH_MAJOR=7 \
      ARM_CORTEX_A7=yes \
      CROSS_COMPILE=${TARGET_PREFIX} \
      NEED_BL2=yes \
      fip \
"
do_compile_append() {
	# Get the entry point
	ENTRY=`${HOST_PREFIX}readelf ${B}/${PLATFORM}/bl2/bl2.elf -h | grep "Entry" | awk '{print $4}'`

	# Generate the .imx binary
	uboot-mkimage -n ${DEPLOY_DIR_IMAGE}/u-boot-dtb.cfgout -T imximage -e ${ENTRY} -d ${B}/${PLATFORM}/${MBL_BL2_FILENAME} ${B}/${PLATFORM}/${MBL_UNIFIED_BIN}

	# Create signed FIP image.
	oe_runmake ${ATF_COMPILE_FLAGS} BL2=${B}/${PLATFORM}/${MBL_BL2_FILENAME} BL2_AT_EL3=0 fip
}

do_deploy_append() {
	install -D -p -m 0644 ${B}/${PLATFORM}/${FIP_BIN} ${DEPLOYDIR}
}
