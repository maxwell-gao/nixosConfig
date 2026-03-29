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
  home.packages = with pkgs; [
    cmake
    delve
    direnv
    gcc
    gh
    git
    gnumake
    go
    gopls
    gotools
    gdk
    llvm
    llvmPackages.stdenv
    lazygit
    neovim
    pandoc
    nh
    texlive.combined.scheme-full
    unzip
    uv
    wget
    ripgrep
    zellij
  ];

  programs.home-manager.enable = true;
}
