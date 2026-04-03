{ pkgs, ... }:

{
  imports = [
    ./ghostty.nix
  ];

  home.packages = with pkgs; [
    feishu
    fuzzel
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