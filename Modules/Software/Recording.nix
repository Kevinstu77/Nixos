{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.myConfig.Record;
in

{
  options.myConfig.Record = {
    enable = mkEnableOption "setup system recording softwares";
  };

  config = mkIf cfg.enable {




    environment.systemPackages = with pkgs; [
      mpv
    ];

    programs.obs-studio = {
      enable = true;

      # optional Nvidia hardware acceleration
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );

      plugins = with pkgs.obs-studio-plugins; [
        wlrobs
        obs-backgroundremoval
        obs-pipewire-audio-capture
        obs-gstreamer
        obs-vkcapture
      ];
    };
  };
}
