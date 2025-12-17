{ config, lib, pkgs, ... }:
let
    cfg = config.my.services.flatpak;
in
{
    options.my.services.flatpak.enable =
        lib.mkEnableOption "Flatpak Service";

    config = lib.mkIf cfg.enable {
        services.flatpak.enable = true;
    };
}

