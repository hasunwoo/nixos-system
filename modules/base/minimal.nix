{ config, pkgs, ... }:
{
    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

    time.timeZone = "Asia/Seoul";
    i18n.defaultLocale = "ko_KR.UTF-8";

    services.openssh.enable = true;

    security.sudo.enable = true;

    users.users.root = { };

    environment.systemPackages = with pkgs; [
        git
        vim
        curl
        wget
    ];
}
