{
  description = "FrostedFlake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    greyline.url = "github:cothinking-dev/greyline";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
  };

  outputs = { self, nixpkgs, nix-flatpak, ... }: {
    nixosConfigurations = {
      colbyslim = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./Hosts/Lenovo-Slim-Pro-7/configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
        ];
      };
    };
  };
}
