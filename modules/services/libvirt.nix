{ config, lib, pkgs, ... }:
let
    cfg = config.my.virtualisation.libvirt;
in
{
    options.my.virtualisation.libvirt.enable =
        lib.mkEnableOption "libvirt virtualisation";

    config = lib.mkIf cfg.enable {
        virtualisation.libvirtd.enable = true;
    };
}

