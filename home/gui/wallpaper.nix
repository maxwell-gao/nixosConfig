{ osConfig, pkgs, lib, ... }:

let
  isLaptop = osConfig.networking.hostName == "thinkpad-x1c13";

  outputs = if isLaptop then [ "eDP-1" ] else [ "DP-1" "DP-2" "DP-3" ];

  screens = {
    "DP-1" = {
      size = "480x540";
      scale = "1920x2160";
      seed = 31415;
    };
    "DP-2" = {
      size = "480x270";
      scale = "1920x1080";
      seed = 27182;
    };
    "DP-3" = {
      size = "270x480";
      scale = "1080x1920";
      seed = 16180;
    };
    "eDP-1" = {
      size = "480x300";
      scale = "1920x1200";
      seed = 14142;
    };
  };

  source = output:
    let
      screen = screens.${output};
    in
    "av://lavfi:life=size=${screen.size}:rate=10:seed=${toString screen.seed}:random_fill_ratio=0.30:stitch=1:life_color=white:death_color=black:mold_color=0x3c3836:mold=8,format=rgb24,split=2[trail][forbin];[forbin]format=gray,lut=y='if(gt(val,200),255,0)',split=3[base][chg][nei];[chg]format=rgb24,tblend=all_mode=difference[change];[base]format=rgb24,split=2[b1][b2];[b1][change]blend=c0_expr='if(gt(A,0),if(gt(B,0),189,187),if(gt(B,0),73,0))':c1_expr='if(gt(A,0),if(gt(B,0),47,38),if(gt(B,0),52,0))':c2_expr='if(gt(A,0),if(gt(B,0),250,184),if(gt(B,0),251,0))'[state];[state]tmix=frames=3[stateT];[nei]format=rgb24,geq=r='(r(X,Y-1)+r(X,Y+1))*0.12':g='(r(X-1,Y)+r(X+1,Y))*0.08':b='(r(X-1,Y)+r(X+1,Y)+r(X,Y-1)+r(X,Y+1))*0.10'[neigh];[neigh][b2]blend=all_mode=multiply[neighM];[stateT][neighM]blend=all_mode=screen[glow];[trail]format=rgb24,geq=r='if(lt(r(X,Y),200),r(X,Y)*0.8,0)':g='if(lt(g(X,Y),200),g(X,Y)*0.8,0)':b='if(lt(b(X,Y),200),b(X,Y)*0.8,0)'[trailg];[trailg][glow]blend=all_mode=screen,scale=${screen.scale}:flags=neighbor,drawgrid=w=iw:h=4:t=1:c=black@0.35,rgbashift=rh=1:bh=-1,vignette=PI/5";

  mkService = output: {
    Unit = {
      Description = "Game of Life CRT wallpaper (${output})";
      After = [
        "graphical-session.target"
        "niri.service"
      ];
      PartOf = [ "graphical-session.target" ];
    };

    Service = {
      ExecStart = "${pkgs.mpvpaper}/bin/mpvpaper -o \"no-audio no-osc no-border no-input-default-bindings\" ${output} \"${source output}\"";
      Restart = "always";
      RestartSec = 2;
    };

    Install.WantedBy = [ "graphical-session.target" ];
  };
in

{
  home.packages = [ pkgs.mpvpaper ];

  systemd.user.services = lib.listToAttrs (
    map (output: {
      name = "life-wallpaper-${output}";
      value = mkService output;
    }) outputs
  );
}
