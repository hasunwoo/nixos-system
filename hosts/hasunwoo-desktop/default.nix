{ config, pkgs, lib, ... }:
{
    imports = [
        ./hardware.nix
        ../../modules/base
    ];

    networking.hostName = "hasunwoo-desktop";

    # DO NOT CHANGE AFTER INSTALLATION!
    system.stateVersion = "24.05";

    # 서비스 설정
    my.virtualisation.libvirt.enable = true;
    my.services.openssh.enable = true;

    # 기본 사용자 설정
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


    time.timeZone = "Asia/Seoul";

    # 시스템 기본 언어: 영어
    i18n.defaultLocale = "en_US.UTF-8";

    # 지역 설정만 한국으로
    i18n.extraLocaleSettings = {
        LC_TIME = "ko_KR.UTF-8";
        LC_MONETARY = "ko_KR.UTF-8";
        LC_NUMERIC = "ko_KR.UTF-8";
        LC_PAPER = "ko_KR.UTF-8";
        LC_MEASUREMENT = "ko_KR.UTF-8";
    };
}
