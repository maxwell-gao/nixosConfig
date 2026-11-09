{ pkgs, ... }:

{
  imports = [
    ../../modules/nixos/common.nix
  ];

  wsl.enable = true;
  wsl.defaultUser = "nixos";

  networking.hostName = "nixos-wsl";

  programs.zsh.enable = true;
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
  programs.nix-ld.enable = true;

  users.users.nixos = {
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  system.stateVersion = "25.05";
}
