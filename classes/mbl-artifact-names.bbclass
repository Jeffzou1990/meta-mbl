# Copyright (c) 2018 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT

# Symbol Defintions
#
# MBL_FIT_BIN_FILENAME
#   The FIP file name.
#
# MBL_UBOOT_CMD_FILENAME
#   The name of the u-boot boot command file name.
#
# MBL_KEYSTORE_DIR
#   The directory containing the rot_key.pem file, for example.
#
# MBL_FIT_ROT_KEY_FILENAME
#   The FIT Root of Trust signing key file name.

MBL_UBOOT_CMD_FILENAME ?= "boot.cmd"
MBL_FIT_BIN_FILENAME ?= "boot.scr"
MBL_KEYSTORE_DIR ?= "${DEPLOY_DIR_IMAGE}"
MBL_FIT_ROT_KEY_FILENAME ?= "mblkey"


# Symbols for TBBR key and certificate file names.
# These default values are aligned with the TF-A fiptool and cert_create tool defaults.
MBL_ATF_BL2_TRUSTED_BOOT_FW_FILENAME ??= "tb-fw.bin"
MBL_ATF_BL2_TRUSTED_BOOT_FW_CONTENT_CERT_FILENAME ??= "tb-fw-cert.bin"
MBL_ATF_BL31_SOC_AP_FW_FILENAME ??= "soc-fw.bin"
MBL_ATF_BL31_SOC_AP_FW_CONTENT_CERT_FILENAME ??= "soc-fw-cert.bin"
MBL_ATF_BL31_SOC_AP_FW_KEY_CERT_FILENAME ??= "soc-fw-key-cert.bin"
MBL_ATF_BL32_TRUSTED_OS_FW_FILENAME ??= "tos-fw.bin"
MBL_ATF_BL32_TRUSTED_OS_FW_CONTENT_CERT_FILENAME ??= "tos-fw-cert.bin"
MBL_ATF_BL32_TRUSTED_OS_EXTRA1_FW_FILENAME ??= "tos-fw-extra1.bin"
MBL_ATF_BL32_TRUSTED_OS_EXTRA2_FW_FILENAME ??= "tos-fw-extra2.bin"
MBL_ATF_BL32_TRUSTED_OS_FW_KEY_CERT_FILENAME ??= "tos-fw-key-cert.bin"
MBL_ATF_BL33_NON_TRUSTED_FW_FILENAME ??= "nt-fw.bin"
MBL_ATF_BL33_NON_TRUSTED_FW_CONTENT_CERT_FILENAME ??= "nt-fw-cert.bin"
MBL_ATF_BL33_NON_TRUSTED_FW_KEY_CERT_FILENAME ??= "nt-fw-key-cert.bin"
MBL_ATF_TRUSTED_KEY_CERT_FILENAME ??= "trusted-key-cert.bin"

# Symbols for binary file names.
MBL_BOOTCODE_BIN_FILENAME ??= "mbl-bootcode.bin"
MBL_BL1_BIN_FILENAME ??= "mbl-bl1.bin"
MBL_BL2_BIN_FILENAME ??= "mbl-bl2.bin"
MBL_FIP_BIN_FILENAME ??= "mbl-fip.bin"
# todo: adopt this name: MBL_FIT_BIN_FILENAME ??= "mbl-fit.bin"
MBL_UBOOT_BIN_FILENAME ??= "mbl-uboot.bin"
# todo: adopt this name: MBL_UBOOT_CMD_FILENAME ??= "mbl-uboot.cmd"
MBL_TBBR_ROT_KEY_FILENAME ??= "mbl-tbbr-rot-key.pem"
# todo: adopt this name MBL_FIT_ROT_KEY_FILENAME ??= "mbl-fit-rot-key.pem"
MBL_FIT_ROT_KEY_CERT_FILENAME ??= "mbl-fit-rot-key-cert.pem"
