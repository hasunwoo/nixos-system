{ config, pkgs, lib, ... }:
{
    config = {
        # XDG / DBus
        services.dbus.enable = true;

        # Display Manager
        services.displayManager.sddm.enable = true;
        services.displayManager.sddm.wayland.enable = true;

        # KDE Plasma (Wayland)
        services.desktopManager.plasma6.enable = true;

        # Wayland 권장 옵션
        programs.xwayland.enable = true;

        # 폰트 (선택)
        fonts.packages = with pkgs; [
            noto-fonts
            noto-fonts-cjk-sans
            noto-fonts-emoji
        ];

    } // lib.mkIf config.my.services.flatpak.enable {
        # xdg
        xdg.portal.enable = true;
        xdg.portal.extraPortals = [
            pkgs.xdg-desktop-portal-kde
        ];
        xdg.portal.config.common.default = "kde";

        # discover app
        environment.systemPackages = with pkgs; [
            kdePackages.discover
        ];
    };
}

