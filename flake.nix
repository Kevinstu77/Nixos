{
  description = "FrostedFlake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=latest";
    nix-cachyos-kernel.url = "github:xddxdd/nix-cachyos-kernel/release";
    agenix.url = "github:ryantm/agenix";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    auto-cpufreq = {
      url = "github:AdnanHodzic/auto-cpufreq";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    disko = {
      url = "github:nix-community/disko";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nix-flatpak, nix-cachyos-kernel, disko, agenix, auto-cpufreq, ... }:
  let
    system = "x86_64-linux";

    # 1. Automatically scan the ./Hosts directory
    hostsDir = ./Hosts;

    # 2. Extract only the folder names (ignoring loose files)
    hostNames = builtins.attrNames (
      nixpkgs.lib.filterAttrs (name: type: type == "directory") (builtins.readDir hostsDir)
    );

    # 3. Automatically generate a nixosConfiguration for every folder found
    mkHost = hostname: nixpkgs.lib.nixosSystem {
      inherit system;
      modules = [
        # Automatically points to /Hosts/<your-computer-name>/configuration.nix
        (hostsDir + "/${hostname}/configuration.nix")

        disko.nixosModules.disko
        nix-flatpak.nixosModules.nix-flatpak
        agenix.nixosModules.default
        ({ pkgs, ... }: {
          nixpkgs.overlays = [ nix-cachyos-kernel.overlays.pinned ];
        })
      ];
    };
  in {
    # 4. Map the generator function across all discovered host folders
    nixosConfigurations = nixpkgs.lib.genAttrs hostNames mkHost;
  };
}
