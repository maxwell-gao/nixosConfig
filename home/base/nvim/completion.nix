{ ... }:

{
  programs.nixvim = {
    plugins = {
      cmp = {
        enable = true;

        settings = {
          completion = {
            completeopt = "menu,menuone,noinsert";
          };

          snippet = {
            expand = ''
              function(args)
                require("luasnip").lsp_expand(args.body)
              end
            '';
          };

          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<C-e>" = "cmp.mapping.abort()";
          };

          sources = [
            { name = "nvim_lsp"; }
            { name = "luasnip"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
        };
      };

      luasnip.enable = true;
      cmp-buffer.enable = true;
      cmp-path.enable = true;
      cmp-nvim-lsp.enable = true;
      cmp_luasnip.enable = true;
    };
  };
}
