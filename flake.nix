{
    description = "System NixOS configuration";

    inputs = {
        nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    };

    outputs = { self, nixpkgs, ... }:
    let
        system = "x86_64-linux";
    in {
        nixosConfigurations = {
            "hasunwoo-desktop" = nixpkgs.lib.nixosSystem {
                inherit system;

                modules = [
                    ./hosts/hasunwoo-desktop
                ];
            };
        };
    };
}
