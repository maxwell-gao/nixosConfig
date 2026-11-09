{ ... }:

{
  programs.niri.settings.outputs = {
    "HDMI-A-1" = {
      enable = false;
    };

    "PNP(GVT) Kuycon G27-X 0x27554432" = {
      scale = 2;
      transform.rotation = 270;
      position = {
        x = 3840;
        y = 0;
      };
    };

    "PNP(GKT) Kuycon G32P Unknown" = {
      scale = 2;
      position = {
        x = 5280;
        y = 0;
      };
    };

    "LG Electronics LG SDQHD 310NTGYD1119" = {
      scale = 1.25;
      position = {
        x = 8352;
        y = 0;
      };
    };
  };
}
