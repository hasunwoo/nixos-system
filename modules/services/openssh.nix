{ config, lib, pkgs, ... }:
let
    cfg = config.my.services.openssh;
in
{
    options.my.services.openssh.enable =
        lib.mkEnableOption "OpenSSH Daemon";

    config = lib.mkIf cfg.enable {
        services.openssh.enable = true;
    };
}

