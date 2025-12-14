{ config, pkgs, lib, ... }:
{
    users.users.hasunwoo = {
        isNormalUser = true;
        description = "Main user";
        home = "/home/hasunwoo";
        extraGroups = [
            "wheel"
            "networkmanager"
        ] ++ lib.optional config.my.virtualisation.libvirt.enable "libvirtd";

        initialPassword = "init";
    };

    security.sudo = {
        enable = true;
        wheelNeedsPassword = true;
    };

    users.users.root = {
        hashedPassword = "!";
        shell = "${pkgs.shadow}/bin/nologin";
    };
}
