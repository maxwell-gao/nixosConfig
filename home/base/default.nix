{ pkgs, ... }:

{
  imports = [
    ./ai.nix
    ./git.nix
    ./nvim
    ./rebuild.nix
    ./shell
  ];

  xdg.enable = true;

  home.packages = with pkgs; [
    bottom
    cargo
    clippy
    cmake
    delve
    direnv
    fastfetch
    gcc
    gh
    gnumake
    go
    gopls
    gotools
    jq
    lazygit
    llvm
    nh
    pandoc
    ripgrep
    rust-analyzer
    rustc
    rustfmt
    texlive.combined.scheme-full
    tmux
    unzip
    uv
    wget
    yazi
    zellij
  ];

  programs.home-manager.enable = true;
}
