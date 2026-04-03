{ pkgs, ... }:

{
  imports = [
    ./bind.nix
  ];

  programs.niri.settings = {
    prefer-no-csd = true;

    layout = {
      gaps = 16;

      focus-ring = {
        enable = true;
        width = 4;
        active = { color = "#5d2509"; };
      };

      border = {
        enable = false;
      };

      shadow = {
        enable = true;
        softness = 20;
        spread = 5;
        color = "#00000070";
      };
    };

    window-rules = [
      {
        draw-border-with-background = false;
        geometry-corner-radius = {
          top-left = 9.0;
          top-right = 9.0;
          bottom-right = 9.0;
          bottom-left = 9.0;
        };
        clip-to-geometry = true;
      }
    ];
  };
}
