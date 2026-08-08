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

    #steam setup
    programs.steam = {
      enable = true;
      extraPackages = with pkgs; [
        kdePackages.breeze-icons
      ];
      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    #system pkgs
    environment.systemPackages = with pkgs; [
      prismlauncher
      vesktop
      mangohud
    ];

    #declaritive flatpak
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

    #other settings
    programs.gamemode.enable = true;

  };
}
