{ pkgs, ... }:

let
  ini = pkgs.formats.ini { };

  fcitx5Profile = ini.generate "fcitx5-profile" {
    GroupOrder."0" = "Default";

    "Groups/0" = {
      Name = "Default";
      "Default Layout" = "us";
      DefaultIM = "pinyin";
    };

    "Groups/0/Items/0" = {
      Name = "keyboard-us";
      Layout = "";
    };

    "Groups/0/Items/1" = {
      Name = "pinyin";
      Layout = "";
    };
  };
in

{
  xdg.configFile."fcitx5/profile".source = fcitx5Profile;
}
