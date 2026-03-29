{ ... }:

{
  programs.nixvim = {
    plugins.telescope = {
      enable = true;

      settings = {
        defaults = {
          prompt_prefix = "  ";
          selection_caret = "❯ ";
          path_display = [ "smart" ];
          sorting_strategy = "ascending";

          layout_config = {
            horizontal = {
              prompt_position = "top";
            };
          };
        };
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>Telescope find_files<CR>";
        options = {
          silent = true;
          desc = "Find files";
        };
      }
      {
        mode = "n";
        key = "<leader>fg";
        action = "<cmd>Telescope live_grep<CR>";
        options = {
          silent = true;
          desc = "Live grep";
        };
      }
      {
        mode = "n";
        key = "<leader>fb";
        action = "<cmd>Telescope buffers<CR>";
        options = {
          silent = true;
          desc = "Find buffers";
        };
      }
      {
        mode = "n";
        key = "<leader>fh";
        action = "<cmd>Telescope help_tags<CR>";
        options = {
          silent = true;
          desc = "Help tags";
        };
      }
    ];
  };
}
