# Copyright (c) 2019 Arm Limited and Contributors. All rights reserved.
#
# SPDX-License-Identifier: MIT

# Disable systemd integration.
SYSTEMD_AUTO_ENABLE = "disable"
SYSTEMD_SERVICE_${PN} = ""

do_install_append() {

    if ${@bb.utils.contains('DISTRO_FEATURES','systemd','true','false',d)}; then
        rm -fR ${D}/${nonarch_base_libdir}/systemd
    fi
}
