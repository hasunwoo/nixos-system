{ config, lib, pkgs, ... }:
let
    cfg = config.my.services.pipewire;
in
{
    options.my.services.pipewire.enable =
        lib.mkEnableOption "Pipewire service";

    config = lib.mkIf cfg.enable {
        sound.enable = true;
        hardware.pulseaudio.enable = false;

        services.pipewire = {
            enable = true;

            alsa = {
                enable = true;
                support32Bit = true;
            };

            pulse.enable = true;
            jack.enable = true;
        };

        security.rtkit.enable = true;
    };
}

