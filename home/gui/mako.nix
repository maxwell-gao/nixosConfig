{ ... }:

{
  services.mako = {
    enable = true;

    settings = {
      anchor = "top-right";
      layer = "overlay";

      background-color = "#282828";
      text-color = "#ebdbb2";
      border-color = "#d79921";
      progress-color = "#504945";

      border-size = 2;
      border-radius = 8;
      padding = 10;
      margin = 10;

      default-timeout = 5000;
      icons = 1;
      max-icon-size = 32;
      max-visible = 5;
      sort = "-time";
      font = "JetBrainsMono Nerd Font 11";
    };
  };
}
