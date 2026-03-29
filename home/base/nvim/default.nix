{ pkgs, inputs, ... }:

{
  imports = [
    inputs.nixvim.homeModules.nixvim
  ];

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    colorschemes.gruvbox.enable = true;

    plugins = {
      lualine.enable = true;
      web-devicons.enable = true;
      neo-tree.enable = true;
      which-key.enable = true;
      nvim-autopairs.enable = true;
      comment.enable = true;
      gitsigns.enable = true;
      treesitter.enable = true;
    };
  };
}
