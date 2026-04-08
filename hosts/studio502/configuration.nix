{ config, lib, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  nix.settings = {
    substituters = [
      "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
      "https://cache.nixos.org"
    ];
    experimental-features = [ "nix-command" "flakes" ];
  };

  boot.loader.grub.enable = true;
  boot.loader.grub.device = "/dev/nvme0n1";
  boot.loader.grub.useOSProber = true;

  networking.hostName = "studio502";
  networking.networkmanager.enable = true;
  networking.networkmanager.wifi.backend = "iwd";
  networking.wireless.iwd.enable = true;

  hardware.enableRedistributableFirmware = true;
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };
  services.blueman.enable = true;

  time.timeZone = "Asia/Singapore";

  i18n.defaultLocale = "en_SG.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_SG.UTF-8";
    LC_IDENTIFICATION = "en_SG.UTF-8";
    LC_MEASUREMENT = "en_SG.UTF-8";
    LC_MONETARY = "en_SG.UTF-8";
    LC_NAME = "en_SG.UTF-8";
    LC_NUMERIC = "en_SG.UTF-8";
    LC_PAPER = "en_SG.UTF-8";
    LC_TELEPHONE = "en_SG.UTF-8";
    LC_TIME = "en_SG.UTF-8";
  };

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;
    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      fcitx5-gtk
      fcitx5-nord
    ];
  };

  services.xserver.enable = true;

  services.displayManager.sddm.enable = true;
  programs.niri.enable = true;

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [ xdg-desktop-portal-gtk ];
  };

  services.printing.enable = true;

  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  services.xserver.libinput.enable = true;
  programs.zsh.enable = true;

  users.users.max = {
    isNormalUser = true;
    description = "max";
    extraGroups = [ "networkmanager" "wheel" ];
    shell = pkgs.zsh;
  };

  programs.firefox.enable = true;

  nixpkgs.config.allowUnfree = true;

  environment.systemPackages = with pkgs; [
    xwayland-satellite
  ];

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      wqy_zenhei
      wqy_microhei
      lxgw-wenkai
      noto-fonts-color-emoji
      nerd-fonts.jetbrains-mono
      nerd-fonts.fira-code
      nerd-fonts.ubuntu
    ];

    fontconfig = {
      enable = true;
      defaultFonts = {
        emoji = [ "Noto Color Emoji" ];
        monospace = [ "UbuntuMono Nerd Font" "JetBrainsMono Nerd Font" "Noto Sans Mono CJK SC" ];
        sansSerif = [ "Noto Sans CJK SC" "DejaVu Sans" ];
        serif = [ "Noto Serif CJK SC" "DejaVu Serif" ];
      };
    };
  };

  services.openssh.enable = true;

  system.stateVersion = "25.05";
}
