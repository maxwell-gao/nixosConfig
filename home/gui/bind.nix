{ config, pkgs, ... }:

{
  programs.niri.settings.binds = with config.lib.niri.actions; {
    # Basics
    "Mod+T".action.spawn = "ghostty";
    "Mod+Q".action = close-window;
    "Mod+F".action = maximize-column;
    "Mod+Shift+F".action = fullscreen-window;
    "Mod+Shift+E".action = quit;
    "Mod+Shift+Slash".action = show-hotkey-overlay;

    # Window navigation
    "Mod+Left".action = focus-column-left;
    "Mod+Right".action = focus-column-right;
    "Mod+Up".action = focus-window-up;
    "Mod+Down".action = focus-window-down;

    "Mod+H".action = focus-column-left;
    "Mod+L".action = focus-column-right;
    "Mod+K".action = focus-window-up;
    "Mod+J".action = focus-window-down;

    # Monitor focus
    "Mod+Shift+Left".action = focus-monitor-left;
    "Mod+Shift+Right".action = focus-monitor-right;
    "Mod+Shift+Up".action = focus-monitor-up;
    "Mod+Shift+Down".action = focus-monitor-down;

    "Mod+Shift+H".action = focus-monitor-left;
    "Mod+Shift+L".action = focus-monitor-right;
    "Mod+Shift+K".action = focus-monitor-up;
    "Mod+Shift+J".action = focus-monitor-down;

    # Window movement within the layout
    "Mod+Ctrl+Left".action = move-column-left;
    "Mod+Ctrl+Right".action = move-column-right;
    "Mod+Ctrl+Up".action = move-window-up;
    "Mod+Ctrl+Down".action = move-window-down;

    "Mod+Ctrl+H".action = move-column-left;
    "Mod+Ctrl+L".action = move-column-right;
    "Mod+Ctrl+K".action = move-window-up;
    "Mod+Ctrl+J".action = move-window-down;

    # Move the focused window to another monitor
    "Mod+Ctrl+Shift+Left".action = move-window-to-monitor-left;
    "Mod+Ctrl+Shift+Right".action = move-window-to-monitor-right;
    "Mod+Ctrl+Shift+Up".action = move-window-to-monitor-up;
    "Mod+Ctrl+Shift+Down".action = move-window-to-monitor-down;

    "Mod+Ctrl+Shift+H".action = move-window-to-monitor-left;
    "Mod+Ctrl+Shift+L".action = move-window-to-monitor-right;
    "Mod+Ctrl+Shift+K".action = move-window-to-monitor-up;
    "Mod+Ctrl+Shift+J".action = move-window-to-monitor-down;

    # Floating windows
    "Mod+V".action = toggle-window-floating;
    "Mod+Shift+V".action = switch-focus-between-floating-and-tiling;

    # Consume/Expel
    "Mod+Semicolon".action = consume-window-into-column;
    "Mod+Period".action = expel-window-from-column;

    # Noctalia Core
    "Mod+Space".action.spawn = [ "noctalia-shell" "ipc" "call" "launcher" "toggle" ];
    "Mod+S".action.spawn = [ "noctalia-shell" "ipc" "call" "controlCenter" "toggle" ];
    "Mod+Comma".action.spawn = [ "noctalia-shell" "ipc" "call" "settings" "toggle" ];

    # Media keys
    "XF86AudioRaiseVolume".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "increase" ];
    "XF86AudioLowerVolume".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "decrease" ];
    "XF86AudioMute".action.spawn = [ "noctalia-shell" "ipc" "call" "volume" "muteOutput" ];
    "XF86MonBrightnessUp".action.spawn = [ "noctalia-shell" "ipc" "call" "brightness" "increase" ];
    "XF86MonBrightnessDown".action.spawn = [ "noctalia-shell" "ipc" "call" "brightness" "decrease" ];

    # Column width
    "Mod+R".action = switch-preset-column-width;
    "Mod+Shift+R".action = switch-preset-window-height;
    "Mod+Minus".action.set-column-width = "-10%";
    "Mod+Equal".action.set-column-width = "+10%";
    "Mod+Shift+Minus".action.set-window-height = "-10%";
    "Mod+Shift+Equal".action.set-window-height = "+10%";

    # Workspaces
    "Mod+1".action.focus-workspace = 1;
    "Mod+2".action.focus-workspace = 2;
    "Mod+3".action.focus-workspace = 3;
    "Mod+4".action.focus-workspace = 4;
    "Mod+5".action.focus-workspace = 5;
    "Mod+6".action.focus-workspace = 6;
    "Mod+7".action.focus-workspace = 7;
    "Mod+8".action.focus-workspace = 8;
    "Mod+9".action.focus-workspace = 9;

    "Mod+Shift+1".action.move-column-to-workspace = 1;
    "Mod+Shift+2".action.move-column-to-workspace = 2;
    "Mod+Shift+3".action.move-column-to-workspace = 3;
    "Mod+Shift+4".action.move-column-to-workspace = 4;
    "Mod+Shift+5".action.move-column-to-workspace = 5;
    "Mod+Shift+6".action.move-column-to-workspace = 6;
    "Mod+Shift+7".action.move-column-to-workspace = 7;
    "Mod+Shift+8".action.move-column-to-workspace = 8;
    "Mod+Shift+9".action.move-column-to-workspace = 9;

    # Overview
    "Mod+W".action = toggle-overview;

    # Screenshot
    "Mod+Shift+S".action.screenshot = { show-pointer = true; };
  };
}
