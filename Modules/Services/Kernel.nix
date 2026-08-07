{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.myConfig.Kernel;
in

{
  options.myConfig.Kenrel = {
    enable = mkEnableOption "...";
  };

  config = mkIf cfg.enable {
    boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-bore-lto-x86_64-v3;
  };
}
