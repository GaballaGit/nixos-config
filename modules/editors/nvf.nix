{
	inputs,
	config,
	...
}:
{
	imports = [inputs.nvf.default ];

	programs.nvf = {
		enable = true;

		settings.vim = {
			lsp.enable = true;
			vimAlias = true;
			viAlias = true;
			withNodeJs = true;
			lineNumberMode =  "relNumber";
			enableLuaLoader = true;
			preventJunkFiles = true;
			options = {
				tabstop = 4;
				shiftwidth = 2;
				wrap = false;
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
				programmingWordList.enable = true;
			};

			lsp = {
				formatOnSave = true;
				lspkind.enable = false;
				lightbulb.enable = false;
				lspsaga.enable = false;
				trouble.enable = true;
				lspSignature.enable = true;
				otter-nvim.enable = false;
				nvim-docs-view.enable = false;
			};

			languages = {

				enableFormat = true;
				enableTreesitter = true;
				enableExtraDiagnositcs = true;
				nix.enable = true;
				clang.enable = true;
				python.enable = true;
				go.enable = true;
				markdown.enable = true;
				ts = {
					enable = true;
					lsp.enable = true;
					format.type = "prettired";
				};
				html = {
					enable = true;
					format.enable = true; # note sure if prettired exists for html? 
				};
				css = {
					enable = true;
					format.type = "prettired";
				};
				lua.enable = true;
			};
		};
	};
}
