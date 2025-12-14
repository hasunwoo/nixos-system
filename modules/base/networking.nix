{ config, pkgs, ... }:
{
    networking.networkmanager.enable = true;
    networking.usePredictableInterfaceNames = true;
    networking.useNetworkd = false;
    networking.firewall.enable = true;
}
