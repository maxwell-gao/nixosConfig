{ ... }:

{
  imports = [
    ../../home/base.nix
  ];

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "25.05";

  programs.zsh.shellAliases.update = "sudo nixos-rebuild switch --flake ~/nixosConfig#nixos-wsl";
}