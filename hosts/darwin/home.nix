{ ... }:

{
  imports = [
    ../../home/base/default.nix
    ../../home/darwin.nix
  ];

  home.username = "max";
  home.homeDirectory = "/Users/max";
  home.stateVersion = "25.05";

  my.rebuild = {
    enable = true;
    kind = "darwin";
    target = "darwin";
  };
}
