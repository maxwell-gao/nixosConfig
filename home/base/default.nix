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
    bottom
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
    jq
    llvm
    llvmPackages.stdenv
    lazygit
    pandoc
    nh
    fastfetch
    rust-analyzer
    rustc
    cargo
    clippy
    rustfmt
    texlive.combined.scheme-full
    tmux
    unzip
    opencode
    uv
    wget
    ripgrep
    yazi
    zellij
  ];

  programs.home-manager.enable = true;
}
