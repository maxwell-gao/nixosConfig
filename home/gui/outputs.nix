{ ... }:

{
  programs.niri.settings.outputs = {
    "HDMI-A-1" = {
      scale = 1;
      position = {
        x = 0;
        y = 0;
      };
    };

    "DP-3" = {
      scale = 2;
      transform.rotation = 270;
      position = {
        x = 3840;
        y = 0;
      };
    };

    "DP-1" = {
      scale = 2;
      position = {
        x = 5280;
        y = 0;
      };
    };

    "DP-2" = {
      scale = 1.25;
      position = {
        x = 8352;
        y = 0;
      };
    };
  };
}
