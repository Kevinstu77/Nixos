{ config, lib, pkgs, ... }:

with lib;

let
  aud = config.myConfig.audio;
in

{
  options.myConfig.audio = {
    enable = mkEnableOption "audio setup";
  };

  config = mkIf aud.enable {

    # Enable sound with pipewire.
    services.pulseaudio.enable = false;
    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
  };
}
