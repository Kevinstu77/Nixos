{
  description = "FrostedFlake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-flatpak, nix-cachyos-kernel, disko, ... }: {
    nixosConfigurations = {
      colbyslim = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./Hosts/Lenovo-Slim-Pro-7/configuration.nix
          nix-flatpak.nixosModules.nix-flatpak
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ nix-cachyos-kernel.overlays.pinned ];
          })
        ];
      };

      colbythick = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./Hosts/Hp-Omen-16-Max/configuration.nix
          ./Hosts/Hp-Omen-16-Max/disk-config.nix
          nix-flatpak.nixosModules.nix-flatpak
          disko.nixosModules.disko
          ({ pkgs, ... }: {
            nixpkgs.overlays = [ nix-cachyos-kernel.overlays.pinned ];
          })
        ];
      };
    };
  };
}
