# Copyright (c) 2019 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT

HOMEPAGE = "https://github.com/ARM-software/psa-arch-tests"

DESCRIPTION = "\
The Arm Platform Security Architecture Test Suite provides tests \
for implementations of PSA specifications. \
"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE.md;md5=2a944942e1496af1886903d274dedb13"

SRC_URI = " \
    https://github.com/ARM-software/psa-arch-tests/archive/v19.06_API0.9.tar.gz \
    file://0001-WIP.patch \
"

SRC_URI[md5sum] = "4bcb1d70615f433b4a949a58354bb896"
SRC_URI[sha256sum] = "e69a05e77462ccf78ff91e012df378e4673eb06b94969209adf415a0d2b8238d"

S = "${WORKDIR}/psa-arch-tests-19.06_API0.9"
B = "${WORKDIR}/build"

DEPENDS += "dos2unix-native mbed-crypto"

EXTRA_OEMAKE += "SOURCE=${S}/api-tests"
EXTRA_OEMAKE += "BUILD=${B}"
EXTRA_OEMAKE += "TARGET=linux"
EXTRA_OEMAKE += "SUITE=crypto"
EXTRA_OEMAKE += "TOOLCHAIN=GCC"
EXTRA_OEMAKE += "CPU_ARCH=${MACHINE_ARCH}"
EXTRA_OEMAKE += "VERBOSE=1"
EXTRA_OEMAKE += "TEST_COMBINE_LINUX=1"
EXTRA_OEMAKE += "INCLUDE_PANIC_TESTS=0"
EXTRA_OEMAKE += "WATCHDOG_AVAILABLE=0"
EXTRA_OEMAKE += "SP_HEAP_MEM_SUPP=1"
EXTRA_OEMAKE += "PSA_IPC_IMPLEMENTED=0"
EXTRA_OEMAKE += "PSA_CRYPTO_IMPLEMENTED=1"
EXTRA_OEMAKE += "PSA_PROTECTED_STORAGE_IMPLEMENTED=0"
EXTRA_OEMAKE += "PSA_INTERNAL_TRUSTED_STORAGE_IMPLEMENTED=0"
EXTRA_OEMAKE += "PSA_INITIAL_ATTESTATION_IMPLEMENTED=0"
EXTRA_OEMAKE += "USER_INCLUDE="

PARALLEL_MAKE = ""

do_compile() {
    oe_runmake -f ${S}/api-tests/tools/makefiles/Makefile
}

do_install() {
    install -d ${D}${bindir}
    install -m 755 ${B}/dev_apis/crypto/psa-arch-crypto-tests ${D}${bindir}/
}
