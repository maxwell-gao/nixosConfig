{ config, lib, ... }:

let
  inherit (lib) mkEnableOption mkIf mkOption types;

  cfg = config.my.rebuild;

  subcommand =
    if cfg.kind == "darwin" then
      "darwin"
    else if cfg.kind == "home" then
      "home"
    else
      "os";

  hostFlag = "-H";

  mkNhCommand = action:
    "nh ${subcommand} ${action} ${cfg.flake} ${hostFlag} ${cfg.target}";
in
{
  options.my.rebuild = {
    enable = mkEnableOption "host-aware rebuild aliases powered by nh";

    kind = mkOption {
      type = types.enum [ "nixos" "darwin" "home" ];
      example = "nixos";
      description = ''
        The platform kind for rebuild commands.

        - `"nixos"` generates `nh os ...`
        - `"darwin"` generates `nh darwin ...`
        - `"home"` generates `nh home ...`
      '';
    };

    flake = mkOption {
      type = types.str;
      default = "~/nixosConfig";
      example = "~/nixosConfig";
      description = ''
        Flake path passed to `nh`.
      '';
    };

    target = mkOption {
      type = types.str;
      example = "nixos-wsl";
      description = ''
        Target host name used by `nh` via `-H`.
      '';
    };
  };

  config = mkIf cfg.enable {
    programs.zsh.shellAliases = {
      nb = mkNhCommand "build";
      ns = mkNhCommand "switch";
      nt = mkNhCommand "test";
      update = mkNhCommand "switch";
    };
  };
}
