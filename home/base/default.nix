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
    ./ai.nix
    ./nvim
    ./rebuild.nix
    ./shell
  ];

  xdg.enable = true;

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
    rust-analyzer
    rustc
    cargo
    clippy
    rustfmt
    texlive.combined.scheme-full
    unzip
    uv
    wget
    ripgrep
    zellij
  ];

  programs.home-manager.enable = true;
}
