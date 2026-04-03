{ pkgs, inputs, ... }:

{
  imports = [
    ./ghostty.nix
    ./niri.nix
    inputs.noctalia.homeModules.default
  ];

  programs.noctalia-shell = {
    enable = true;
    systemd.enable = true;

    settings = {
      general = {
        animationSpeed = 1.2;
        radiusRatio = 1.1;
        telemetryEnabled = false;
      };

      bar = {
        position = "top";
        floating = true;
        backgroundOpacity = 0.92;
      };

      dock = {
        enabled = true;
        position = "bottom";
      };

      desktopWidgets = {
        enabled = false;
      };

      colorSchemes = {
        darkMode = true;
        useWallpaperColors = false;
        predefinedScheme = "Gruvbox";
        syncGsettings = true;
      };
    };
  };

  home.packages = with pkgs; [
    feishu
    foot
    fuzzel
    ghostty
    gruvbox-gtk-theme
    gruvbox-plus-icons
    kdePackages.kate
    libnotify
    playerctl
    wl-clipboard
    wtype
    vscode
    zed-editor
    zotero
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
