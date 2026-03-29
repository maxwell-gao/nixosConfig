{ inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
    ./core.nix
    ./keymaps.nix
    ./ui.nix
    ./telescope.nix
    ./treesitter.nix
    ./lsp.nix
    ./completion.nix
    ./editing.nix
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
  };
}
