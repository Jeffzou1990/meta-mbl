DEPENDS += " u-boot-mkimage-native "
DEPENDS_append_raspberrypi3-mbl = " linaro-aarch64-toolchain-native "

SRCREV="0ab9388c0d553a6bb5ae04e41b38ba40cf0474bf"
SRCREV_raspberrypi3-mbl="62b4cdb5e8895a6b0c477ea9f1cecdb5514e2f87"
SRC_URI="git://github.com/OP-TEE/optee_os.git;protocol=https;nobranch=1 \
file://0001-allow-setting-sysroot-for-libgcc-lookup.patch \
"

OPTEE_ARCH = "arm32"

# imx7s-warp-mbl Symbol Definitions For Common EXTRA_OEMAKE Options
#
# OPTEE_OS_CROSS_COMPILE_CORE_imx7s-warp-mbl
#  Cross-compiler symbol for OPTEE core. Warp7 is ARM32 so the
#  32-bit host toolchain is used.
#
OPTEEMACHINE_imx7s-warp-mbl="imx-mx7swarp7"
OPTEEOUTPUTMACHINE_imx7s-warp-mbl="imx"
OPTEE_OS_CROSS_COMPILE_CORE_imx7s-warp-mbl="${HOST_PREFIX}"

# Raspberrypi3-mbl Symbol Definitions For Common EXTRA_OEMAKE Options
#
# OPTEE_OS_CROSS_COMPILE_CORE_raspberrypi3-mbl
#  Cross-compiler symbol for OPTEE core. On RPi3 it should be 64-bit because
#  rpi3 boots with 64-bit and the Linaro toolchain is used.
#
OPTEEMACHINE_raspberrypi3-mbl="rpi3"
OPTEEOUTPUTMACHINE_raspberrypi3-mbl="rpi3"
OPTEE_OS_CROSS_COMPILE_CORE_raspberrypi3-mbl="aarch64-linux-gnu-"


# EXTRA_OEMAKE Symbols For Option Common to All Targets
# -----------------------------------------------------
#
# CFG_DT
#   Configure the use of kernel device trees.
#
# CFG_TEE_CORE_LOG_LEVEL
#   Configure Trusted Execution Environment core log level.
#     1 => only show ERROR logging.
#     4 => most verbose including xtest output.
#
# CROSS_COMPILE_core
#   Configure the CROSS_COMPILE symbol for the core Sub-Module (sm).
#   The optee-os project makefiles uses symbols of the form
#   CROSS_COMPILE_$(sm) to specify the CROSS_COMPILE prefix for the
#   sm submodule. See the project makefiles for more information.
#   Note this is not an example of the bitbake conditional syntax
#   (see bitbake manaul for more information).
#
# CROSS_COMPILE_ta_arm32
#   Configure the CROSS_COMPILE symbol for the AArch32 trusted applications.
#   This is the same for all targets.
#
# LDFLAGS
#   The linker flags are cleared.
#
# LIBGCC_LOCATE_CFLAGS
#   This symbol is used to specify the logical root directory for headers and
#   libraries for the GNU linker. The directory is set to be the
#   STAGING_DIR_HOST i.e. ${WORKDIR}/recipe-sysroot. Support for this is added
#   by optee_os_git.bb patching the optee-os project gcc.mk makefile with
#   0001-allow-setting-sysroot-for-libgcc-lookup.patch.
#   See https://gcc.gnu.org/onlinedocs/gcc/Directory-Options.html for details
#   about --sysroot.
#
# NOWERROR
#   Do not treat warnings as errors.
#
# PLATFORM
#   A platform is a family of closely related hardware configurations.
#   See optee_os/documentation/build_system.md in the optee_os repo
#   for more information.
#
EXTRA_OEMAKE = " \
    PLATFORM=${OPTEEMACHINE} \
    CROSS_COMPILE_core=${OPTEE_OS_CROSS_COMPILE_CORE} \
    CROSS_COMPILE_ta_arm32=${HOST_PREFIX} \
    NOWERROR=1 \
    LDFLAGS= \
    LIBGCC_LOCATE_CFLAGS=--sysroot=${STAGING_DIR_HOST} \
    CFG_DT=y \
    CFG_TEE_CORE_LOG_LEVEL=1 \
"


# EXTRA_OEMAKE Warp7 Target Specific Symbols
# ------------------------------------------
#
# CFG_DDR_SIZE
#   Configure the size of DDR
#   TODO: this doesnt need to be set because its set by
#   config.mk under the ifneq (,$(filter $(PLATFORM_FLAVOR),mx7swarp7)) stanza
#
# CFG_DT_ADDR
#   Configure the start address of the Device Tree.
#   TODO: Why does this option have to be set for warp7 and not rpi3?
#   Can they be made the same?
#
# CFG_NS_ENTRY_ADDR
#   Option available for ARM32 core only. Forces the Non-Secure World
#   entry address to be the specified value. This is the address of where
#   the kernel is loaded into memory.
#
# CFG_PAGEABLE_ADDR
#   Set the pageable address. Note that the pageable is currently not
#   used on WaRP7; hence it's set to 0. Option available for ARM32 core only.
#
# ta-targets=ta_arm32
#   Set Trusted Application (TA) targets to be 32-bit.
#
EXTRA_OEMAKE_append_imx7s-warp-mbl = " \
    ta-targets=ta_arm32 \
    CFG_PAGEABLE_ADDR=0 \
    CFG_NS_ENTRY_ADDR=0x87800000 \
    CFG_DT_ADDR=0x83000000 \
    CFG_DDR_SIZE=0x20000000 \
"


# EXTRA_OEMAKE RaspberryPi3 Target Specific Symbols
# ------------------------------------------
# CFG_ARM64_core
#   Set OPTEE core to be in ARM64 rather than ARM32.
#
# CFG_DT_ADDR
#  The address of the device tree.
#
EXTRA_OEMAKE_append_raspberrypi3-mbl = " \
    CFG_DT_ADDR=0x03000000 \
    CFG_ARM64_core=y \
"


do_compile_prepend_raspberrypi3-mbl() {
   export PATH=${STAGING_DIR_NATIVE}/${bindir}/aarch64-linux-gnu/bin:$PATH
}

do_install_append() {
    uboot-mkimage -A arm -T kernel -O tee -C none -d ${B}/out/arm-plat-${OPTEEOUTPUTMACHINE}/core/tee.bin ${D}/lib/firmware/uTee.optee
}
