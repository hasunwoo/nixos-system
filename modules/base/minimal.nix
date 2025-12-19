{ config, pkgs, ... }:
{
    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

    programs.zsh.enable = true;

    environment.systemPackages = with pkgs; [
        git
        vim
        curl
        wget
        home-manager
    ];
}
