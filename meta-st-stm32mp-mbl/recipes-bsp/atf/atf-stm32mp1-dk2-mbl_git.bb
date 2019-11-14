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

FILESEXTRAPATHS_prepend := "${THISDIR}/atf-stm32mp1-dk2-mbl:"
SRC_URI_append_stm32mp1-dk2-mbl = " file://0001-rpi3-Use-mmc-driver-to-load-FIP-from-raw-sectors.patch \
				file://0002-rpi3-use-external-FIP-offset-definition.patch \
"

PLATFORM = "st-stm32mp"

ATF_COMPILE_FLAGS += " \
      CROSS_COMPILE=aarch64-linux-gnu- \
      RPI3_BL33_IN_AARCH32=1 \
      NEED_BL32=yes \
      SPD=opteed \
      RPI3_PRELOADED_DTB_BASE=0x03000000 \
      fip \
"
