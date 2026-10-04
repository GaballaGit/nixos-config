{
  inputs,
  pkgs,
  config,
  lib,
  ...
}: {
  imports = [inputs.nvf.homeManagerModules.default];

  programs.nvf = {
    enable = true;

    settings.vim = {
      globals = {
        mapleader = " ";
      };

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
      startPlugins = with pkgs.vimPlugins; [
	plenary-nvim
	nui-nvim
	leetcode-nvim
      ];

      lazy.plugins."leetcode.nvim" = {
	package = pkgs.vimPlugins.leetcode-nvim;

	setupModule = "leetcode";
	setupOpts = {
	  lang = "golang";
	};

	cmd = ["Leet"];
      };

      theme = {
	enable = true;
	transparent = true;
	#  name = "tokyonight";
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

      luaConfigRC.gitDiffQuickfix = ''
        local function open_git_diff_quickfix()
          local root = vim.fn.systemlist({"git", "rev-parse", "--show-toplevel"})[1]
          if vim.v.shell_error ~= 0 or root == nil or root == "" then
            vim.notify("Not inside a git repository", vim.log.levels.WARN)
            return
          end

          local files = vim.fn.systemlist({"git", "-C", root, "diff", "--name-only", "--diff-filter=ACMR", "HEAD", "--"})
          if vim.v.shell_error ~= 0 then
            vim.notify("Failed to read git diff", vim.log.levels.ERROR)
            return
          end

          local seen = {}
          local qf = {}
          for _, file in ipairs(files) do
            if file ~= "" and not seen[file] then
              seen[file] = true
              table.insert(qf, {
                filename = root .. "/" .. file,
                lnum = 1,
                col = 1,
                text = "Changed in git diff",
              })
            end
          end


          if #qf == 0 then
            vim.notify("No files changed in git diff", vim.log.levels.INFO)
          else
            vim.fn.setqflist({}, "r", {
              title = "Git diff files",
              items = qf,
            })
            vim.cmd("copen")
          end
        end

        local function delete_quickfix_item()
          local line = vim.fn.line(".")
          local qf = vim.fn.getqflist({items = 1, idx = 0})
          local idx = qf.idx

          if idx == 0 or qf.items[idx] == nil then
            return
          end

          table.remove(qf.items, idx)
          if #qf.items == 0 then
            vim.fn.setqflist({}, "r", {items = {}})
            vim.cmd("cclose")
            return
          end

          local new_idx = math.min(idx, #qf.items)
          vim.fn.setqflist({}, "r", {items = qf.items, idx = new_idx})
          vim.api.nvim_win_set_cursor(0, {math.min(line, #qf.items), 0})
        end

        vim.api.nvim_create_autocmd("FileType", {
          pattern = "qf",
          callback = function(args)
            vim.keymap.set("n", "dd", delete_quickfix_item, {
              buffer = args.buf,
              silent = true,
              desc = "Delete quickfix item",
            })
          end,
        })

        vim.api.nvim_create_user_command("GitDiffQuickfix", open_git_diff_quickfix, {})
      '';

      keymaps = [
        {
          key = "<leader>gq";
          mode = "n";
          silent = true;
          desc = "Open git diff files in quickfix";
          action = "<cmd>GitDiffQuickfix<CR>";
        }
      ];

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
	rust.enable = true;
	csharp.enable = true;
	markdown.enable = true;
	yaml.enable = true;
	sql = {
	  enable = true;
	  lsp.enable = true;
	  format.type = [
	    "sqlfluff"
	  ];
	};
	typescript = {
	  enable = true;
	  lsp.enable = true;
	  format.type = [
	    "prettier"
	  ];
	};
	html = {
	  enable = true;
	  format.type = [
	    "prettier"
	  ];
	};
	css = {
	  enable = true;
	  format.type = [
	    "prettier"
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
