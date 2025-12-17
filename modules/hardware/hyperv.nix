{ config, pkgs, ... }:
{
    boot.kernelModules = [
        "hv_vmbus"
        "hv_sock"
        "hv_storvsc"
        "hv_netvsc"
        "hv_utils"
        "hv_balloon"
        "hyperv_drm"
    ];

    hardware.opengl = {
        enable = true;
        driSupport = true;
        driSupport32Bit = true;
    };
}
