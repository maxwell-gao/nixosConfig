{ ... }:

{
  imports = [
    ../../home
    ./niri-outputs.nix
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "25.05";

  my.rebuild = {
    enable = true;
    kind = "nixos";
    target = "studio502";
  };
}
