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
    starship
    texlive.combined.scheme-full
    unzip
    uv
    wget
    ripgrep
    zellij
  ];

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
      if ! command -v zed >/dev/null 2>&1; then
        for zed_candidate in zeditor zedit zed-editor; do
          if command -v "$zed_candidate" >/dev/null 2>&1; then
            alias zed="$zed_candidate"
            break
          fi
        done
      fi

      eval "$(starship init zsh)"
    '';

    shellAliases = {
      ll = "ls -l";
      g = "git";
    };
  };
}