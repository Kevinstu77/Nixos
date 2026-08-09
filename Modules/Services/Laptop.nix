{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.myConfig.laptop;
in

{
  options.myConfig.laptop = {
    enable = mkEnableOption "Enable laptop max performance";
  };

config = mkIf cfg.enable {
  services.power-profiles-daemon.enable = false;
  services.auto-cpufreq.enable = true;
  services.auto-cpufreq.settings = {
    battery = {
      governor = "performance";
      turbo = "never";
    };
  charger = {
    governor = "performance";
    turbo = "auto";
   };
  };
 };
}
