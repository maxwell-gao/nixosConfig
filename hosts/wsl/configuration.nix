{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

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

  hardware.bluetooth.enable = false;

  system.stateVersion = "25.05";
}
