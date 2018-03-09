SUMMARY = "mbed linux additional packages"
DESCRIPTION = "mbed linux additional packages to those of the minimal console default setup."
inherit packagegroup

###############################################################################
# Packages added irrespective of the MACHINE
#     - docker. Containerised environment for secure application execution.
#     - iptables. Required by docker for building iptables DOCKER-ISOLATION 
#       and DOCKER chains for the FORWARD table.
#     - kernel-modules. Required by iptables related modules (e.g. netfilter
#       connection tracking.
###############################################################################
PACKAGEGROUP_MBL_PKGS_append = " docker"
PACKAGEGROUP_MBL_PKGS_append = " iptables"
PACKAGEGROUP_MBL_PKGS_append = " kernel-modules"
PACKAGEGROUP_MBL_PKGS_append = " rng-tools"


###############################################################################
# Packages added for MACHINE=imx7s-warp
#     - optee-os. If the machine supports optee include the os.
#     - optee-client. If the machine supports optee include the client.
###############################################################################
PACKAGEGROUP_MBL_PKGS_append_imx7s-warp = " optee-os"
PACKAGEGROUP_MBL_PKGS_append_imx7s-warp = " optee-client"


RDEPENDS_packagegroup-mbl += "${PACKAGEGROUP_MBL_PKGS}"