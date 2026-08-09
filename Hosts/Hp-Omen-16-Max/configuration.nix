{ config, pkgs, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../../Modules/Porter.nix
      ./disk-config.nix
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
  myConfig.laptop.enable = true;
  myConfig.GpuDrivers = {
    enable = true;
    optimus = {
      enable = true;
      nvidiaBusId = "PCI:2@0:0:0";
      intelBusId = "PCI:0@0:2:0";
    };
  };

  nixpkgs.config.allowUnfree = true;
  #features
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "Hp-Omen-16-Max"; # Define your hostname.

  # Enable networking
  networking.networkmanager.enable = true;

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.mutableUsers = false;
  users.users."colbys" = {
    isNormalUser = true;
    description = "Colby Stults";
    hashedPasswordFile = config.age.secrets.colbys-password.path;
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
    fastfetch
  ];

  #secret
  age.secrets.colbys-password.file = ../../secrets/colbys-password.age;

  system.stateVersion = "26.05";

}
