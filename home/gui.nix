{ pkgs, ... }:

{
  home.packages = with pkgs; [
    feishu
    ghostty
    gruvbox-gtk-theme
    gruvbox-plus-icons
    kdePackages.kate
    vscode
    zed-editor
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}