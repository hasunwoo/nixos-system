{ config, pkgs, lib, ... }:
{
    security.sudo = {
        enable = true;
        wheelNeedsPassword = true;
    };

    users.users.root = {
        hashedPassword = "!";
        shell = "${pkgs.shadow}/bin/nologin";
    };
}
