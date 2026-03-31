{
  inputs,
  config,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;

    settings.vim = {
      lsp.enable = true;
      lsp.lspconfig.enable = true;
      vimAlias = true;
      viAlias = true;
      withNodeJs = true;
      lineNumberMode = "relNumber";
      enableLuaLoader = true;
      preventJunkFiles = true;
      options = {
        tabstop = 4;
        shiftwidth = 2;
        wrap = false;
      };

      theme = {
        transparent = true;
        name = "tokyonight";
      };

      statusline = {
        lualine = {
          enable = true;
          icons.enable = true;
          theme = "Tomorrow";
        };
      };

      autocomplete.blink-cmp = {
        #setupOpts.signature.enable = true;
        enable = true;
      };

      diagnostics = {
        enable = true;
        config = {
          virtual_lines.enable = true;
          underline = true;
        };
      };

      telescope.enable = true;

      spellcheck = {
        enable = true;
        languages = ["en"];
        programmingWordlist.enable = true;
      };

      lsp = {
        formatOnSave = true;
        lspkind.enable = false;
        lightbulb.enable = false;
        lspsaga.enable = false;
        trouble.enable = true;
        otter-nvim.enable = false;
        nvim-docs-view.enable = false;
      };

      languages = {
        enableFormat = true;
        enableTreesitter = true;
        nix.enable = true;
        clang.enable = true;
        python.enable = true;
        go.enable = true;
        markdown.enable = true;
        yaml.enable = true;
        sql = {
          enable = true;
          lsp.enable = true;
          format.type = [
            "sqlfluff"
          ];
        };
        ts = {
          enable = true;
          lsp.enable = true;
          format.type = [
            "prettierd"
          ];
        };
        html = {
          enable = true;
          format.type = [
            "prettierd"
          ];
        };
        css = {
          enable = true;
          format.type = [
            "prettierd"
          ];
        };
        lua.enable = true;
      };

      presence.neocord = {
        enable = true;

        setupOpts = {
          logo_tooltip = "crying";
          main_image = "language";
          enable_line_number = true;
          log_level = "debug";
        };
      };
    };
  };
}
