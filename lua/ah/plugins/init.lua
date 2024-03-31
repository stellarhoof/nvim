return {
	{
		"https://github.com/vhyrro/luarocks.nvim",
		priority = 100,
		config = true,
	},

	{
		"https://github.com/nvim-lua/plenary.nvim",
		priority = 90,
	},

	{
		"https://github.com/konfekt/vim-alias",
		priority = 80,
		config = function()
			local alias = vim.cmd.Alias
			alias({ args = { "w", "up" }, bang = true })
			alias({ args = { "man", "Man" }, bang = true })
		end,
	},

	-- Colorschemes
	{
		"https://github.com/folke/tokyonight.nvim",
		priority = 70,
	},

	{
		"https://github.com/mcchrish/zenbones.nvim",
		priority = 70,
		dependencies = { "https://github.com/rktjmp/lush.nvim" },
		config = function()
			vim.g.zenwritten = {
				italic_comments = false,
				darken_noncurrent_window = true,
			}
		end,
	},

	-- Enable repeating supported plugin maps with "."
	{
		"https://github.com/tpope/vim-repeat",
	},

	-- Pairs of handy bracket mappings
	{
		"https://github.com/tpope/vim-unimpaired",
		config = function()
			nmap("co", "<plug>(unimpaired-toggle)")
		end,
	},

	-- Auto insert pairs of delimiters.
	{
		"https://github.com/windwp/nvim-autopairs",
		opts = {},
	},

	-- Improved Yank and Put functionalities for Neovim
	-- Lua version of https://github.com/svermeulen/vim-yoink
	{
		"https://github.com/gbprod/yanky.nvim",
		opts = {
			highlight = { on_put = false, on_yank = false },
		},
		keys = {
			{ "y", "<plug>(YankyYank)", mode = { "n", "x" }, desc = "Yank text" },
			{ "p", "<plug>(YankyPutAfter)", mode = { "n", "x" }, desc = "Put yanked text after cursor" },
			{ "P", "<plug>(YankyPutBefore)", mode = { "n", "x" }, desc = "Put yanked text before cursor" },
			{ "<c-n>", "<plug>(YankyCycleForward)", desc = "Select previous yank history entry" },
			{ "<c-p>", "<plug>(YankyCycleBackward)", desc = "Select next yank history entry" },
			-- There are also ]p, [p that conflict with unimpaired
		},
	},

	-- Operators to substitute and exchange text.
	-- Lua version of
	--  https://github.com/svermeulen/vim-subversive
	--  https://github.com/tommcdo/vim-exchange
	{
		"https://github.com/gbprod/substitute.nvim",
		config = function()
			require("substitute").setup({
				highlight_substituted_text = {
					enabled = false,
				},
			})
			-- Substitute
			nmap("gs", require("substitute").operator, {
				noremap = true,
				desc = "Substitute text object with contents of default register",
			})
			nmap("gss", require("substitute").line, {
				noremap = true,
				desc = "Substitute line with contents of default register",
			})
			nmap("gS", require("substitute").eol, {
				noremap = true,
				desc = "Substitute up to EOL with contents of default register",
			})
			xmap("gs", require("substitute").visual, {
				noremap = true,
				desc = "Substitute visual selection with contents of default register",
			})

			-- Exchange
			nmap("ge", require("substitute.exchange").operator, {
				noremap = true,
				desc = "Exchange with text object",
			})
			nmap("gee", require("substitute.exchange").line, {
				noremap = true,
				desc = "Exchange with line",
			})
			nmap("gE", require("substitute.exchange").cancel, {
				noremap = true,
				desc = "Exchange up to EOL",
			})
			xmap("ge", require("substitute.exchange").visual, {
				noremap = true,
				desc = "Exchange with visual selection",
			})
		end,
	},

	-- Move 'up' or 'down' without changing the cursor column.
	{
		"https://github.com/vim-utils/vim-vertical-move",
	},

	-- Improved paragraph motion.
	{
		"https://github.com/justinmk/vim-ipmotion",
		config = function()
			vim.g.ip_skipfold = 1
		end,
	},

	-- A simple alignment operator
	{
		"https://github.com/tommcdo/vim-lion",
	},

	-- A Git wrapper so awesome, it should be illegal.
	{
		"https://github.com/tpope/vim-fugitive",
		dependencies = { "https://github.com/tpope/vim-rhubarb" },
		config = function()
			local alias = vim.cmd.Alias
			alias({ args = { "g", "G" } })
			alias({ args = { "gbl", "Git blame -w -M" } })
			alias({ args = { "gd", "Gdiffsplit" } })
			alias({ args = { "ge", "Gedit" } })
			alias({ args = { "gr", "Gread" } })
			alias({ args = { "gs", "Git" } })
			alias({ args = { "gw", "Gwrite" } })
			alias({ args = { "gco", "Git checkout" } })
			alias({ args = { "gcm", "Git commit" } })
			alias({ args = { "gcma", "Git commit --amend" } })
			alias({ args = { "gcman", "Git commit --amend --reuse-message HEAD" } })
			-- Rhubarb
			vim.cmd("Alias -range gx GBrowse")
			-- alias({ args = { "go", "GBrowse" }, range = {} }) -- This doesn't work
		end,
	},

	-- Convenience file operations for neovim, written in lua.
	{
		"https://github.com/chrisgrieser/nvim-genghis",
		after = { "vim-alias" },
		config = function()
			local alias = vim.cmd.Alias
			alias({ args = { "mv", "Move" } })
			alias({ args = { "rm", "Trash" } })
			alias({ args = { "dup", "Duplicate" } })
			alias({ args = { "ren", "Rename" } })
			alias({ args = { "cpf", "CopyFilePath" } })
		end,
	},

	{
		"https://github.com/stevearc/oil.nvim",
		config = function()
			require("oil").setup({
				view_options = {
					show_hidden = true,
				},
				-- :h |oil-config|
				keymaps = {
					["<C-v>"] = "actions.select_vsplit",
					["<C-s>"] = "actions.select_split",
					["<C-h>"] = false,
					["<C-l>"] = false,
					["<C-c>"] = false,
					["q"] = "actions.close",
					["gs"] = false,
					["g\\"] = false,
				},
			})
			nmap("-", vim.cmd.Oil, { desc = "Open buffer directory" })
		end,
	},

	-- A vim plugin to perform diffs on blocks of code
	{
		"https://github.com/AndrewRadev/linediff.vim",
		cmd = "Linediff",
	},

	-- File type icons
	{
		"https://github.com/nvim-tree/nvim-web-devicons",
		lazy = true,
		opts = {},
	},

	-- Capture and show any messages in a customisable (floating) buffer.
	{
		"https://github.com/AckslD/messages.nvim",
		config = function()
			require("messages").setup()
			local alias = vim.cmd.Alias
			alias({ args = { "ms", "Messages" } })
			alias({ args = { "mess", "Messages" } })
		end,
	},

	-- A high-performance color highlighter with no external dependencies.
	{
		"https://github.com/NvChad/nvim-colorizer.lua",
		opts = {
			filetypes = {},
			user_default_options = { names = false, hsl_fn = true, rgb_fn = true },
		},
	},

	-- The undo history visualizer for VIM
	{
		"https://github.com/mbbill/undotree",
		keys = {
			{ "<leader>u", vim.cmd.UndotreeToggle, silent = true, desc = "Toggle UndoTree" },
		},
		config = function()
			vim.g.undotree_DiffAutoOpen = 0
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.g.undotree_SplitWidth = 40
		end,
	},

	-- Lightweight yet powerful formatter plugin for Neovim
	{
		"https://github.com/stevearc/conform.nvim",
		opts = {
			formatters_by_ft = {
				sh = { "shfmt" },
				nix = { "nixfmt" },
				lua = { "stylua" },
				python = { "isort", "black" },
				javascript = { "prettierd" },
				javascriptreact = { "prettierd" },
				typescript = { "prettierd" },
				typescriptreact = { "prettierd" },
			},
			format_on_save = {
				timeout_ms = 500,
				lsp_fallback = true,
			},
		},
	},

	{
		"https://github.com/echasnovski/mini.nvim",
		config = function()
			require("mini.comment").setup()
		end,
	},

	{
		"https://github.com/folke/which-key.nvim",
		event = "VeryLazy",
		opts = {},
	},

	-- Reorder delimited items.
	{
		"https://github.com/machakann/vim-swap",
		event = "VeryLazy",
		init = function()
			vim.g.swap_no_default_key_mappings = 1
			nmap("g<", "<plug>(swap-prev)")
			nmap("g>", "<plug>(swap-next)")
			omap("i,", "<plug>(swap-textobject-i)")
			xmap("i,", "<plug>(swap-textobject-i)")
			omap("a,", "<plug>(swap-textobject-a)")
			xmap("a,", "<plug>(swap-textobject-a)")
		end,
	},

	-- Add/change/delete surrounding delimiter pairs with ease.
	{
		"https://github.com/kylechui/nvim-surround",
		opts = {
			-- https://github.com/ggandor/leap.nvim/discussions/59#discussioncomment-3943323
			-- If the key ends in "_line", the delimiter pair is added on new lines.
			-- If the key ends in "_cur", the surround is performed around the current line.
			keymaps = {
				insert = "<C-g>s",
				insert_line = "<C-g>S",
				normal = "s",
				normal_cur = "ss",
				normal_line = "S",
				normal_cur_line = "SS",
				visual = "s",
				visual_line = "S",
				delete = "ds",
				change = "cs",
			},
			aliases = {
				["0"] = ")",
				["9"] = "(",
			},
		},
	},

	-- Bundle of two dozen new text objects for Neovim.
	{
		"https://github.com/chrisgrieser/nvim-various-textobjs",
		config = function()
			local textobj = require("various-textobjs")

			-- Surrounding lines with same or higher indentation
			map({ "o", "x" }, "ii", function()
				textobj.indentation("inner", "inner")
			end, { desc = "inner indented block" })
			map({ "o", "x" }, "ai", function()
				textobj.indentation("outer", "outer")
			end, { desc = "outer indented block" })

			-- Like iw, but treating -, _, and . as word delimiters and only part of camelCase
			map({ "o", "x" }, "iv", function()
				textobj.subword("inner")
			end, { desc = "inner subword" })
			map({ "o", "x" }, "av", function()
				textobj.subword("outer")
			end, { desc = "outer subword" })

			-- Between any unescaped ", ', or ` in a line
			map({ "o", "x" }, "iq", function()
				textobj.anyQuote("inner")
			end, { desc = "inner quote in a line" })
			map({ "o", "x" }, "aq", function()
				textobj.anyQuote("outer")
			end, { desc = "outer quote in a line" })
		end,
	},

	-- A fast Neovim http client written in Lua.
	{
		"https://github.com/rest-nvim/rest.nvim",
		tag = "v1.2.1",
		ft = { "http" },
		config = function()
			require("rest-nvim").setup({
				-- Skip SSL verification, useful for unknown certificates
				skip_ssl_verification = true,
				-- File to store environmental variables
				env_file = ".http-env",
			})
			au("FileType", {
				pattern = "http",
				callback = function()
					nmap("<leader>r", "<plug>RestNvim", { buffer = true, desc = "Run request under the cursor" })
				end,
			})
		end,
	},

	-- Readline motions and deletions in Neovim.
	{
		"https://github.com/sysedwinistrator/readline.nvim",
		config = function()
			local readline = require("readline")

			-- Move word
			map({ "i", "c" }, "<m-f>", readline.forward_word, { desc = "Forward word" })
			map({ "i", "c" }, "<m-b>", readline.backward_word, { desc = "Backward word" })

			-- Move line
			map({ "i", "c" }, "<c-a>", readline.beginning_of_line, { desc = "Beginning of line" })
			map({ "i", "c" }, "<c-e>", readline.end_of_line, { desc = "End of line" })

			-- Edit char
			map({ "i", "c" }, "<c-d>", "<delete>", { desc = "Forward Delete char" })
			map({ "i", "c" }, "<c-h>", "<bs>", { desc = "Backward delete char" })

			-- Edit word
			map({ "i", "c" }, "<m-d>", readline.kill_word, { desc = "Forward kill word" })
			map({ "i", "c" }, "<m-bs>", readline.backward_kill_word, { desc = "Backward kill word" })

			-- Edit line
			map({ "i", "c" }, "<c-k>", readline.kill_line, { desc = "Forward kill line" })
			map({ "i", "c" }, "<c-u>", readline.backward_kill_line, { desc = "Backward kill line" })
		end,
	},

	{
		"https://github.com/nvim-pack/nvim-spectre",
	},

	-- Helps you win at grep.
	{
		"https://github.com/mhinz/vim-grepper",
		keys = {
			{
				"<space>s",
				function()
					vim.cmd.Grepper({ args = vim.o.ft == "dirvish" and { "-dir", "file" } or {} })
				end,
				silent = true,
				noremap = true,
				desc = "Search with Grepper",
			},
		},
		config = function()
			vim.g.grepper = {
				switch = 0,
				jump = 1,
				dir = "repo,file,pwd",
				side_cmd = "tabnew",
				tools = { "rg", "tg", "rgall" },
				operator = { prompt = 1 },
				rg = { grepprg = vim.o.grepprg },
				rgall = { grepprg = vim.o.grepprg .. " --no-ignore-vcs" },
				prompt_text = "(<c-o>=change-dir) (<c-s>=side) (<tab>=change-tool) $t> ",
				prompt_mapping_dir = "<c-o>",
				prompt_quote = 0,
			}
		end,
	},

	{
		"https://github.com/stevearc/dressing.nvim",
		opts = {
			select = { backend = { "telescope" } },
		},
	},

	{
		"https://github.com/ziontee113/icon-picker.nvim",
		config = function()
			require("icon-picker").setup({})
			-- nmap("<space>c", "<cmd>IconPickerNormal nerd_font_v3<cr>", { noremap = true, silent = true })
		end,
	},

	{
		"https://github.com/iamcco/markdown-preview.nvim",
		cmd = { "MarkdownPreviewToggle", "MarkdownPreview", "MarkdownPreviewStop" },
		build = "cd app && yarn install",
		init = function()
			vim.g.mkdp_filetypes = { "markdown" }
		end,
		ft = { "markdown" },
	},

	{
		"https://github.com/vuki656/package-info.nvim",
		-- Commands start with PackageInfo*
		opts = {},
	},
}
