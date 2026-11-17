{ pkgs, ... }:

{
  home.packages = [
    pkgs.opencode
  ];

  xdg.configFile."opencode/opencode.json".source = ./opencode.json;
}
