{ ... }:

{
  programs.nixvim = {
    colorschemes.gruvbox.enable = true;

    plugins = {
      lualine.enable = true;
      web-devicons.enable = true;
      which-key.enable = true;
    };
  };
}
