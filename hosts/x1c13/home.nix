{ pkgs, ... }:

{
  imports = [
    ../../home
  ];

  home.username = "max";
  home.homeDirectory = "/home/max";
  home.stateVersion = "25.05";

  home.packages = with pkgs; [
    powertop
    powerstat
    intel-gpu-tools
  ];

  my.rebuild = {
    enable = true;
    kind = "nixos";
    target = "thinkpad-x1c13";
  };
}
