{ config, pkgs, ... }:
{
    nix.settings.experimental-features = [
        "nix-command"
        "flakes"
    ];

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

    services.openssh.enable = true;

    security.sudo.enable = true;

    environment.systemPackages = with pkgs; [
        git
        vim
        curl
        wget
    ];
}
