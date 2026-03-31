{ pkgs, inputs, ... }:

{
  imports = [
    ./ghostty.nix
    inputs.dms.homeModules.dank-material-shell
    inputs.dms.homeModules.niri
  ];

  programs.dank-material-shell = {
    enable = true;

    systemd.enable = false;

    niri = {
      enableSpawn = true;
      enableKeybinds = true;
      includes.enable = false;
    };
  };

  home.packages = with pkgs; [
    feishu
    ghostty
    gruvbox-gtk-theme
    gruvbox-plus-icons
    kdePackages.kate
    vscode
    zed-editor
    zotero
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}