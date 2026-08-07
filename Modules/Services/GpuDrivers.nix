{ config, lib, pkgs, ... }:

with lib;

let
  cfg = config.myConfig.GpuDrivers;
in

{
  options.myConfig.GpuDrivers = {
    enable = mkEnableOption "Enable Nvidia Drivers";

    optimus ={
      enable = mkEnableOption "Enable Nvidia optimus/prime offload";
      nvidiaBusId = mkOption {
        type = types.str;
        default = "PCI:1@0:0:0";
        description = "PCI bus ID for NVIDIA GPU";
      };
      amdgpuBusId = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "PCI ID for AMD GPU";
      };
      intelBusId = mkOption {
        type = types.nullOr types.str;
        default = null;
        description = "PCI ID for INTEL GPU";
      };
    };
  };

  config = mkMerge [
    (mkIf cfg.enable {
      hardware.graphics.enable = true;
      hardware.nvidia.open = true;
      services.xserver.videoDrivers = [ "nvidia" ]
        ++ optionals (cfg.optimus.amdgpuBusId != null) [ "amdgpu" ]
        ++ optionals (cfg.optimus.intelBusId != null) [ "modesetting" ];
    })

    (mkIf cfg.optimus.enable {
      hardware.nvidia.prime = {
        offload.enable = true;
        offload.enableOffloadCmd = true;
        nvidiaBusId = cfg.optimus.nvidiaBusId;
      } // optionalAttrs (cfg.optimus.amdgpuBusId != null) {
        amdgpuBusId = cfg.optimus.amdgpuBusId;
      } // optionalAttrs (cfg.optimus.intelBusId != null) {
        intelBusId = cfg.optimus.intelBusId;
      };
    })
  ];
}
