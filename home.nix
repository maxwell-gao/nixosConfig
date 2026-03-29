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
    feishu
    gcc
    gh
    ghostty
    git
    gnumake
    go
    gopls
    gotools
    gdk
    gruvbox-gtk-theme
    gruvbox-plus-icons
    kdePackages.kate
    llvm
    llvmPackages.stdenv
    neovim
    pandoc
    starship
    texlive.combined.scheme-full
    unzip
    uv
    vscode
    wget
    ripgrep
    zed-editor
  ];

  home.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };

  programs.home-manager.enable = true;

  programs.starship = {
    enable = true;
    enableZshIntegration = true;
  };

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    initContent = ''
      eval "$(starship init zsh)"
    '';

    shellAliases = {
      ll = "ls -l";
      g = "git";
    };
  };
}