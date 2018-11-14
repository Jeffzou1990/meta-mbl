# Copyright (c) 2018 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT

# make sure the local appending config file will be chosen by prepending and extra local path
FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

FILES_${PN} += " \
    ${MBL_NON_FACTORY_CONFIG_DIR} \
    ${MBL_NON_FACTORY_CONFIG_DIR}/main.conf \
"

SRC_URI +=  " file://0005-replace-libreadline-with-libedit.patch \
              file://main.conf \                
            "
            
#replace readline (GPLV3) with libedit (GPLV2)
DEPENDS_remove = "readline"
DEPENDS += " libedit"

# disable wispr support (Wireless Internet Service Provider roaming) to remove some GPLV3 dependencies
EXTRA_OECONF += "\
    --disable-wispr \
"
PACKAGECONFIG_remove = "wispr"
PACKAGECONFIG[wispr] = ""
FILES_${PN}-tools = ""

#pass MBL_NON_FACTORY_CONFIG_DIR to autotools make to minimize maintainance. Some connman paths will be redirected the non factory config path
EXTRA_OEMAKE += "\
    MBL_NON_FACTORY_CONFIG_DIR=${MBL_NON_FACTORY_CONFIG_DIR} \
"

do_install_append() {
    install -d ${D}${MBL_NON_FACTORY_CONFIG_DIR}/connman    
    install -m 0644 ${WORKDIR}/main.conf ${D}${MBL_NON_FACTORY_CONFIG_DIR}/connman/main.conf
}
