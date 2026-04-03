{ ... }:

{
  networking.hostName = "darwin";

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  system.primaryUser = "max";

  users.users.max.home = "/Users/max";

  # Bump this only after reading the nix-darwin release notes.
  system.stateVersion = 6;
}
