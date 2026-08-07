{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.myConfig.gaming;
in

{
  options.myConfig.gaming = {
    enable = mkEnableOption "gaming packages";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      extraPackages = with pkgs; [
        kdePackages.breeze-icons
      ];
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    environment.systemPackages = with pkgs; [
      prismlauncher
    ];

    services.flatpak = {
      enable = true;
      remotes = [
        {
          name = "flathub";
          location = "https://flathub.org/repo/flathub.flatpakrepo";
        }
      ];
      packages = [
        "org.vinegarhq.Sober"
      ];
  };


    programs.gamemode.enable = true;

  };
}
