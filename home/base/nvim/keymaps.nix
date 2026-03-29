{ ... }:

{
  programs.nixvim.keymaps = [
    {
      mode = "n";
      key = "<Esc>";
      action = "<cmd>nohlsearch<CR>";
      options = {
        silent = true;
        desc = "Clear search highlight";
      };
    }

    {
      mode = "n";
      key = "<leader>w";
      action = "<cmd>write<CR>";
      options = {
        silent = true;
        desc = "Write current buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>q";
      action = "<cmd>quit<CR>";
      options = {
        silent = true;
        desc = "Quit current window";
      };
    }

    {
      mode = "n";
      key = "<leader>Q";
      action = "<cmd>qa!<CR>";
      options = {
        silent = true;
        desc = "Quit all without saving";
      };
    }

    {
      mode = "n";
      key = "<leader>x";
      action = "<cmd>bdelete<CR>";
      options = {
        silent = true;
        desc = "Close current buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>h";
      action = "<C-w>h";
      options.desc = "Move to left window";
    }

    {
      mode = "n";
      key = "<leader>j";
      action = "<C-w>j";
      options.desc = "Move to lower window";
    }

    {
      mode = "n";
      key = "<leader>k";
      action = "<C-w>k";
      options.desc = "Move to upper window";
    }

    {
      mode = "n";
      key = "<leader>l";
      action = "<C-w>l";
      options.desc = "Move to right window";
    }

    {
      mode = "n";
      key = "<leader>sv";
      action = "<cmd>vsplit<CR>";
      options = {
        silent = true;
        desc = "Split window vertically";
      };
    }

    {
      mode = "n";
      key = "<leader>sh";
      action = "<cmd>split<CR>";
      options = {
        silent = true;
        desc = "Split window horizontally";
      };
    }

    {
      mode = "n";
      key = "<leader>bn";
      action = "<cmd>bnext<CR>";
      options = {
        silent = true;
        desc = "Next buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>bp";
      action = "<cmd>bprevious<CR>";
      options = {
        silent = true;
        desc = "Previous buffer";
      };
    }

    {
      mode = "n";
      key = "<leader>bd";
      action = "<cmd>bdelete<CR>";
      options = {
        silent = true;
        desc = "Delete buffer";
      };
    }
  ];
}
