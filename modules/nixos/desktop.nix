{ inputs, pkgs, ... }:

let
  blackholeDur = pkgs.fetchurl {
    url = "https://codeberg.org/fairyglade/ly-community/raw/branch/main/animations/dur/blackhole-smooth-240x67.dur";
    hash = "sha256-wo3FzPtngCsg/bRSDTYHQqKnMp4vY+Btm14vakJERBU=";
  };
in

{
  imports = [
    ./common.nix
  ];

  i18n.inputMethod = {
    type = "fcitx5";
    enable = true;

    fcitx5.addons = with pkgs; [
      qt6Packages.fcitx5-chinese-addons
      fcitx5-nord
    ];
  };

  services.xserver.enable = true;
  services.displayManager = {
    defaultSession = "niri";

    ly = {
      enable = true;

      settings = {
        animation = "dur_file";
        dur_file_path = "${blackholeDur}";
        full_color = true;

        bigclock = "en";
        bigclock_seconds = false;
        clock = "%a %b %d %H:%M:%S %Y";

        bg = "0x00000000";
        fg = "0x00FFFFFF";
        border_fg = "0x00FFFFFF";
        error_bg = "0x00000000";
        error_fg = "0x01FF0000";

        blank_box = true;
        hide_borders = false;
        hide_key_hints = false;
        hide_version_string = false;
        hide_keyboard_locks = false;

        asterisk = "0x2022";
      };
    };
  };
  programs.niri = {
    enable = true;
    package = inputs.niri.packages.${pkgs.stdenv.hostPlatform.system}.niri-unstable;
  };

  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
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

  programs.zsh.enable = true;
  programs.firefox.enable = true;

  users.users.max = {
    isNormalUser = true;
    description = "Max";
    extraGroups = [
      "networkmanager"
      "wheel"
    ];
    shell = pkgs.zsh;
  };

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
        monospace = [
          "UbuntuMono Nerd Font"
          "JetBrainsMono Nerd Font"
          "Noto Sans Mono CJK SC"
        ];
        sansSerif = [
          "Noto Sans CJK SC"
          "DejaVu Sans"
        ];
        serif = [
          "Noto Serif CJK SC"
          "DejaVu Serif"
        ];
      };
    };
  };
}
