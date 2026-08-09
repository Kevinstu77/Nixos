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

    programs.auto-cpufreq.enable = true;
    programs.auto-cpufreq.settings = {
    charger = {
      governor = "performance";
      turbo = "auto";
    };

    battery = {
      governor = "performance";
      turbo = "auto";
    };
  };
}
