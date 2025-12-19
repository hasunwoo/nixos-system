{ config, pkgs, ... }:
{
    i18n.inputMethod = {
        enabled = "fcitx5";

        fcitx5.addons = with pkgs; [
            fcitx5-hangul
            fcitx5-configtool
        ];
    };

    environment.sessionVariables = {
        GTK_IM_MODULE = "fcitx";
        QT_IM_MODULE = "fcitx";
        XMODIFIERS   = "@im=fcitx";
    };
}
