{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.myConfig.Kernel;
in

{
  options.myConfig.Kernel = {
    enable = mkEnableOption "...";
  };

  config = mkIf cfg.enable {

    nix.settings = {
      substituters = [ "https://attic.xuyh0120.win/lantian" ];
      trusted-public-keys = [ "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc=" ];
    };

    boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v3;
  };
}
