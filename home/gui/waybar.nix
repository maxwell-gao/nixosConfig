{ osConfig, ... }:

let
  glyphs = builtins.fromJSON (builtins.readFile ./nerd-glyphs.json);

  isLaptop = osConfig.networking.hostName == "thinkpad-x1c13";

  outputs = if isLaptop then [ "eDP-1" ] else [ "DP-1" "DP-2" "DP-3" ];

  modules-right =
    [
      "mpris"
      "idle_inhibitor"
      "load"
      "wireplumber"
    ]
    ++ (if isLaptop then [ "backlight" "battery" ] else [ ])
    ++ [
      "clock"
      "tray"
    ];

  mkBar = output: {
    output = [ output ];
    layer = "top";
    position = "top";
    height = 34;
    spacing = 4;

    modules-left = [ "niri/workspaces" ];
    modules-center = [ "wlr/taskbar" ];
    modules-right = modules-right;

    "niri/workspaces" = {
      all-outputs = true;
      format = "{value}";
    };

    "wlr/taskbar" = {
      all-outputs = false;
      format = "{icon} {title}";
      icon-size = 16;
      tooltip = true;
      tooltip-format = "{title}";
      on-click = "activate";
      on-click-middle = "close";
      on-click-right = "minimize";
    };

    mpris = {
      format = "${glyphs.music} {status_icon} {dynamic}";
      interval = 1;
      dynamic-len = 40;
      status-icons = {
        playing = glyphs.play;
        paused = glyphs.pause;
        stopped = glyphs.stop;
      };
      dynamic-order = [ "title" "artist" ];
      ignored-players = [ "firefox" ];
    };

    idle_inhibitor = {
      format = "{icon}";
      format-icons = {
        activated = glyphs.eye;
        deactivated = glyphs.eye_off;
      };
    };

    load = {
      format = "${glyphs.chart_line} {}";
    };

    wireplumber = {
      scroll-step = 5;
      format = "{icon} {volume}%";
      format-bluetooth = "{icon} {volume}% ${glyphs.bluetooth}";
      format-bluetooth-muted = "${glyphs.volume_off} {icon}${glyphs.bluetooth}";
      format-muted = glyphs.volume_off;
      format-icons = {
        headphone = glyphs.headphones;
        hands-free = glyphs.headset;
        headset = glyphs.headset;
        phone = glyphs.phone;
        portable = glyphs.phone;
        car = glyphs.car;
        default = [
          glyphs.volume_low
          glyphs.volume_medium
          glyphs.volume_high
        ];
      };
      on-click = "wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
    };

    backlight = {
      format = "{icon} {percent}%";
      format-icons = [
        glyphs.brightness_1
        glyphs.brightness_2
        glyphs.brightness_3
        glyphs.brightness_4
        glyphs.brightness_5
        glyphs.brightness_6
        glyphs.brightness_7
      ];
    };

    battery = {
      states = {
        warning = 30;
        critical = 15;
      };
      format = "{icon} {capacity}%";
      format-full = "{icon} {capacity}%";
      format-charging = "${glyphs.battery_charging} {capacity}%";
      format-plugged = "${glyphs.power_plug} {capacity}%";
      format-alt = "{icon} {time}";
      format-icons = [
        glyphs.battery_outline
        glyphs.battery_20
        glyphs.battery_40
        glyphs.battery_60
        glyphs.battery_80
        glyphs.battery_full
      ];
    };

    clock = {
      tooltip-format = "<big>{:%Y %B}</big>\n<tt><small>{calendar}</small></tt>";
      format-alt = "{:%Y-%m-%d}";
    };

    tray = {
      icon-size = 14;
      spacing = 10;
    };
  };
in

{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings = map mkBar outputs;
    style = builtins.readFile ./waybar-style.css;
  };
}
