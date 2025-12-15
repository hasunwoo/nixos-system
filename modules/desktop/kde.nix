{ config, pkgs, ... }:
{
    # XDG / DBus
    services.dbus.enable = true;

    # Display Manager
    services.displayManager.sddm.enable = true;
    services.displayManager.sddm.wayland.enable = false;

    # X11은 SDDM용으로만 사용
    services.xserver.enable = true;

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
}

