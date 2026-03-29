{ ... }:

{
  imports = [
    ../../home
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "25.05";

  programs.zsh.shellAliases.update = "sudo nixos-rebuild switch --flake ~/nixosConfig#thinkpad-x1c13";
}