{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/desktop.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.kernelModules = [
    "tun"
    "acpi_call"
  ];
  boot.extraModulePackages = with config.boot.kernelPackages; [
    acpi_call
  ];

  networking.hostName = "thinkpad-x1c13";
  networking.networkmanager.enable = true;
  networking.firewall.checkReversePath = false;

  time.timeZone = "Asia/Hong_Kong";
  i18n.defaultLocale = "en_HK.UTF-8";

  services.xserver.xkb = {
    layout = "us";
    variant = "";
    options = "ctrl:nocaps";
  };

  services.displayManager.ly.settings.battery_id = "BAT0";

  security.polkit.enable = true;
  services.gnome.gnome-keyring.enable = true;
  services.gvfs.enable = true;
  services.udisks2.enable = true;
  services.upower.enable = true;
  services.thermald.enable = true;

  powerManagement.powertop.enable = true;
  programs.seahorse.enable = true;

  environment.systemPackages = with pkgs; [
    mihomo
  ];

  programs.clash-verge = {
    enable = true;
    package = pkgs.clash-verge-rev;
    autoStart = true;
    tunMode = true;
  };

  system.stateVersion = "25.05";
}
