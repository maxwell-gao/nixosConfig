{ ... }:

{
  imports = [
    ../../home/base/default.nix
  ];

  home.username = "nixos";
  home.homeDirectory = "/home/nixos";
  home.stateVersion = "25.05";

  my.rebuild = {
    enable = true;
    kind = "nixos";
    flake = "~/nixosConfig";
    target = "nixos-wsl";
  };
}
