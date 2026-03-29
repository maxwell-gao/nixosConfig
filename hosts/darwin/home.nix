{ ... }:

{
  imports = [
    ../../home/base.nix
    ../../home/darwin.nix
  ];

  home.username = "max";
  home.homeDirectory = "/Users/max";
  home.stateVersion = "25.05";

  programs.zsh.shellAliases.update = "darwin-rebuild switch --flake ~/nixosConfig#darwin";
}