{ lib, pkgs, ... }:

let
  baseConfig = ''
    background = #000000
    background-opacity = 0.9
    background-blur-radius = 1
  '';

  darwinConfig = baseConfig + ''
    macos-option-as-alt = true
    macos-icon-frame = beige
    macos-icon = custom-style
    macos-icon-screen-color = #000000
    macos-icon-ghost-color = #000000
  '';
in
{
  xdg.configFile = lib.mkIf (!pkgs.stdenv.hostPlatform.isDarwin) {
    "ghostty/config".text = baseConfig;
  };

  home.file = lib.mkIf pkgs.stdenv.hostPlatform.isDarwin {
    "Library/Application Support/com.mitchellh.ghostty/config".text = darwinConfig;
  };
}
