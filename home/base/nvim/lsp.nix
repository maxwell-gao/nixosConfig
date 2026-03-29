{ ... }:

{
  programs.nixvim = {
    plugins.lsp = {
      enable = true;
    };

    lsp = {
      servers = {
        nixd.enable = true;
        lua_ls.enable = true;
        gopls.enable = true;
        rust_analyzer.enable = true;
      };
    };

    keymaps = [
      {
        mode = "n";
        key = "gd";
        action = "<cmd>lua vim.lsp.buf.definition()<CR>";
        options = {
          silent = true;
          desc = "Go to definition";
        };
      }
      {
        mode = "n";
        key = "gr";
        action = "<cmd>lua vim.lsp.buf.references()<CR>";
        options = {
          silent = true;
          desc = "Show references";
        };
      }
      {
        mode = "n";
        key = "K";
        action = "<cmd>lua vim.lsp.buf.hover()<CR>";
        options = {
          silent = true;
          desc = "Hover documentation";
        };
      }
      {
        mode = "n";
        key = "<leader>rn";
        action = "<cmd>lua vim.lsp.buf.rename()<CR>";
        options = {
          silent = true;
          desc = "Rename symbol";
        };
      }
      {
        mode = "n";
        key = "<leader>ca";
        action = "<cmd>lua vim.lsp.buf.code_action()<CR>";
        options = {
          silent = true;
          desc = "Code action";
        };
      }
      {
        mode = "n";
        key = "<leader>e";
        action = "<cmd>lua vim.diagnostic.open_float()<CR>";
        options = {
          silent = true;
          desc = "Line diagnostics";
        };
      }
      {
        mode = "n";
        key = "[d";
        action = "<cmd>lua vim.diagnostic.goto_prev()<CR>";
        options = {
          silent = true;
          desc = "Previous diagnostic";
        };
      }
      {
        mode = "n";
        key = "]d";
        action = "<cmd>lua vim.diagnostic.goto_next()<CR>";
        options = {
          silent = true;
          desc = "Next diagnostic";
        };
      }
    ];
  };
}
