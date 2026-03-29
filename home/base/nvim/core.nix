{ ... }:

{
  programs.nixvim = {
    enable = true;

    globals.mapleader = " ";
    globals.maplocalleader = " ";

    opts = {
      number = true;
      relativenumber = true;

      mouse = "a";
      clipboard = "unnamedplus";

      breakindent = true;
      undofile = true;

      ignorecase = true;
      smartcase = true;

      signcolumn = "yes";
      updatetime = 250;
      timeoutlen = 300;

      splitright = true;
      splitbelow = true;

      inccommand = "split";
      cursorline = true;
      scrolloff = 8;

      expandtab = true;
      shiftwidth = 2;
      tabstop = 2;
      softtabstop = 2;
      smartindent = true;

      termguicolors = true;
    };
  };
}
