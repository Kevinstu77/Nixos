{ config, lib, pkgs, ... }:

with lib;

let
  KDE = config.myConfig.KDE;
in

{
  options.myConfig.KDE = {
    enable = mkEnableOption "kde desktop enviroment";
  };

  config = mkIf KDE.enable {
    services.xserver.enable = true;
    services.displayManager.sddm.enable = true;
    services.desktopManager.plasma6.enable = true;
    environment.systemPackages = with pkgs; [
      kdePackages.ksshaskpass
    ];

  };
}
