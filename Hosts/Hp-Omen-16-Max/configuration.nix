{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../Modules/Porter.nix
    ];

  #activate toggles

  #pkgs
  myConfig.gaming.enable = true;
  myConfig.Record.enable = true;

  #services
  myConfig.local.enable = true;
  myConfig.audio.enable = true;
  myConfig.KDE.enable = true;
  myConfig.Kernel.enable = false;
  myConfig.GpuDrivers = {
    enable = false;
    optimus = {
      enable = false;
      nvidiaBusId = "PCI:1@0:0:0";
      amdgpuBusId = "PCI:115@0:0:0";
    };
  };

  nixpkgs.config.allowUnfree = true;
  #features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "colbyslim"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."colbys" = {
    isNormalUser = true;
    description = "Colby Stults";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    ];
  };


  #Enable Services
  services.flatpak.enable = true;
  services.openssh.enable = true;

  #Enable programs
  programs.firefox.enable = true;

  #Install system packages
  environment.systemPackages = with pkgs; [
    kdePackages.kate
    git
    pkgs.mission-center
    s-tui
  ];

  system.stateVersion = "26.05";

}
