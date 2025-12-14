{ config, pkgs, ... }:
{
    imports = [
        ./hardware.nix
        ../../modules/base
    ];

    networking.hostName = "hasunwoo-desktop";

    # DO NOT CHANGE AFTER INSTALLATION!
    system.stateVersion = "24.05";

    my.virtualisation.libvirt.enable = true;
}
