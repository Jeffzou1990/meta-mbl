# Copyright (c) 2018 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT

FILESEXTRAPATHS_append := "${THISDIR}/files:"

SRC_URI_append = " file://fstab "

# override hostname in build time. hostname will be set by hostname.sh init script
hostname_pn-base-files = ""

# Create a list of mount points that need to be created
python() {
    for part in d.getVar("MBL_PARTITIONS").split():
        mountpoint = d.getVar("MBL_{}_DIR".format(part))
        if mountpoint and mountpoint != "/":
            d.appendVar("MOUNT_POINTS", " {}".format(mountpoint))
}

do_install_append() {
    # Ensure that mountpoints specified in fstab exist on the root filesystem
    for mountpoint in ${MOUNT_POINTS}; do
        install -d "${D}${mountpoint}"
    done
}

# Replace placeholder strings in fstab with values of BitBake variables
MBL_VAR_PLACEHOLDER_FILES = "${D}${sysconfdir}/fstab"
inherit mbl-var-placeholders
