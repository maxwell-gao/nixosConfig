{ pkgs, ... }:

let
  gdk = pkgs.google-cloud-sdk.withExtraComponents (
    with pkgs.google-cloud-sdk.components;
    [
      gke-gcloud-auth-plugin
    ]
  );
in

{
  imports = [
    ./feishu.nix
    ./fuzzel.nix
    ./ghostty.nix
    ./ime.nix
    ./mako.nix
    ./niri.nix
    ./waybar.nix
  ];

  home.packages = with pkgs; [
    brightnessctl
    cliphist
    foot
    gdk
    ghostty
    gruvbox-gtk-theme
    gruvbox-plus-icons
    kdePackages.kate
    libnotify
    playerctl
    wl-clipboard
    wtype
    vscode
    zathura
    zed-editor
    zotero
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
