{ ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nixos/desktop.nix
  ];

  nix.settings.substituters = [
    "https://mirrors.tuna.tsinghua.edu.cn/nix-channels/store"
    "https://cache.nixos.org"
  ];

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

  services.libinput.enable = true;

  services.openssh.enable = true;

  system.stateVersion = "25.05";
}
