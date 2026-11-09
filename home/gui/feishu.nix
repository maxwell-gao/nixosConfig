{ pkgs, ... }:

{
  home.packages = [
    (pkgs.feishu.override {
      commandLineArgs = "--ozone-platform=wayland --enable-features=WaylandWindowDecorations";
    })
  ];
}
