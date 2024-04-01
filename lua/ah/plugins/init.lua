-- Colorscheme plugins
local colorschemes = {
	{
		"https://github.com/mcchrish/zenbones.nvim",
		priority = 1000,
		dependencies = { "https://github.com/rktjmp/lush.nvim" },
		config = function()
			vim.g.zenwritten = {
				italic_comments = false,
				darken_noncurrent_window = true,
			}
		end,
	},
}

-- Plugins that provide motions and/or movements
local motions = {
	-- Move 'up' or 'down' without changing the cursor column.
	{
		"https://github.com/vim-utils/vim-vertical-move",
	},

	-- Improved paragraph motion.
	{
		"https://github.com/justinmk/vim-ipmotion",
		init = function()
			vim.g.ip_skipfold = 1
		end,
	},

	-- Pairs of handy bracket mappings
	{
		"https://github.com/tpope/vim-unimpaired",
		event = "VeryLazy",
		config = function()
			nmap("co", "<plug>(unimpaired-toggle)")
		end,
	},

	-- Navigate your code with search labels, enhanced character motions and
	-- Treesitter integration
	{
		"https://github.com/folke/flash.nvim",
		event = "VeryLazy",
		opts = {
			search = {
				-- Match beginning of words only
				mode = function(str)
					return "\\<" .. str
				end,
			},
			modes = {
				search = { enabled = false },
				char = { enabled = false },
				treesitter = {
					label = { after = false },
					highlight = { backdrop = true },
				},
			},
			highlight = {
				groups = {
					-- FlashBackdrop	  | Comment	    | backdrop
					-- FlashMatch	      | Search	    | search matches
					-- FlashCurrent	    | IncSearch	  | current match
					-- FlashLabel	      | Substitute	| jump label
					-- FlashPrompt	    | MsgArea	    | prompt
					-- FlashPromptIcon	| Special	    | prompt icon
					-- FlashCursor	    | Cursor	    | cursor
					match = "Search",
					current = "Search",
					label = "IncSearch",
				},
			},
		},
		config = function(_, opts)
			require("flash").setup(opts)
			map({ "n", "x", "o" }, "m", require("flash").jump, { desc = "Jump to words" })
			map({ "n", "x", "o" }, "gm", require("flash").treesitter, { desc = "Select treesitter nodes" })
		end,
	},
}

-- Plugins that extend neovim's editing capabilities
local editing = {
	-- Enable repeating supported plugin maps with "."
	{
		"https://github.com/tpope/vim-repeat",
	},

	-- A simple alignment operator
	{
		"https://github.com/tommcdo/vim-lion",
	},

	-- Auto insert pairs of delimiters.
	{
		"https://github.com/windwp/nvim-autopairs",
		event = "VeryLazy",
		opts = {},
	},

	-- Comment lines
	{
		"https://github.com/echasnovski/mini.nvim",
		event = "VeryLazy",
		config = function()
			require("mini.comment").setup()
		end,
	},

	-- Select and insert Nerd icons
	{
		"https://github.com/2KAbhishek/nerdy.nvim",
		cmd = "Nerdy",
	},

	-- Add/change/delete surrounding delimiter pairs with ease.
	{
		"https://github.com/kylechui/nvim-surround",
		event = "VeryLazy",
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

	-- -- Reorder delimited items.
	-- {
	-- 	"https://github.com/machakann/vim-swap",
	-- 	config = function()
	-- 		vim.g.swap_no_default_key_mappings = 1
	-- 		nmap("g<", "<plug>(swap-prev)")
	-- 		nmap("g>", "<plug>(swap-next)")
	-- 		omap("i,", "<plug>(swap-textobject-i)")
	-- 		xmap("i,", "<plug>(swap-textobject-i)")
	-- 		omap("a,", "<plug>(swap-textobject-a)")
	-- 		xmap("a,", "<plug>(swap-textobject-a)")
	-- 	end,
	-- },

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

	-- Cycle through yank and put history.
	{
		"https://github.com/gbprod/yanky.nvim",
		event = "VeryLazy",
		opts = {
			highlight = { on_put = false, on_yank = false },
		},
		config = function(_, opts)
			require("yanky").setup(opts)
			map({ "n", "x" }, "y", "<plug>(YankyYank)", { desc = "Yank text" })
			map({ "n", "x" }, "p", "<plug>(YankyPutAfter)", { desc = "Put yanked text after cursor" })
			map({ "n", "x" }, "P", "<plug>(YankyPutBefore)", { desc = "Put yanked text before cursor" })
			map({ "n", "x" }, "<c-n>", "<plug>(YankyCycleForward)", { desc = "Select previous yank history entry" })
			map({ "n", "x" }, "<c-p>", "<plug>(YankyCycleBackward)", { desc = "Select next yank history entry" })
			-- There are also ]p, [p that conflict with unimpaired
		end,
	},

	-- Operators to substitute and exchange text.
	-- Lua version of
	--  https://github.com/svermeulen/vim-subversive
	--  https://github.com/tommcdo/vim-exchange
	{
		"https://github.com/gbprod/substitute.nvim",
		opts = {
			highlight_substituted_text = {
				enabled = false,
			},
		},
		config = function(_, opts)
			require("substitute").setup(opts)

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
}

-- Plugins that enhance neovim's ui or provide ui components
local ui = {
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

	-- Neovim plugin to improve the default vim.ui interfaces.
	{
		"https://github.com/stevearc/dressing.nvim",
		event = "VeryLazy",
		opts = { select = { backend = { "telescope" } } },
	},

	-- A high-performance color highlighter with no external dependencies.
	{
		"https://github.com/NvChad/nvim-colorizer.lua",
		cmd = { "ColorizerToggle" },
		opts = {
			filetypes = {},
			user_default_options = { names = false, hsl_fn = true, rgb_fn = true },
		},
	},

	-- Capture and show any messages in a customisable (floating) buffer.
	{
		"https://github.com/AckslD/messages.nvim",
		opts = {},
		config = function(_, opts)
			require("messages").setup(opts)
			local alias = vim.cmd.Alias
			alias({ args = { "ms", "Messages" } })
			alias({ args = { "mess", "Messages" } })
		end,
	},

	-- The undo history visualizer for VIM
	{
		"https://github.com/mbbill/undotree",
		keys = {
			{
				"<leader>u",
				vim.cmd.UndotreeToggle,
				silent = true,
				desc = "Toggle UndoTree",
			},
		},
		config = function()
			vim.g.undotree_DiffAutoOpen = 0
			vim.g.undotree_SetFocusWhenToggle = 1
			vim.g.undotree_SplitWidth = 40
		end,
	},

	-- Neovim file explorer: edit your filesystem like a buffer
	{
		"https://github.com/stevearc/oil.nvim",
		opts = {
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
		},
		config = function(_, opts)
			require("oil").setup(opts)
			nmap("-", vim.cmd.Oil, { desc = "Open buffer directory" })
		end,
	},
}

-- Plugins that interact with external tools
local external = {
	-- Convenience file operations for neovim, written in lua.
	{
		"https://github.com/chrisgrieser/nvim-genghis",
		event = "VeryLazy",
		config = function()
			local alias = vim.cmd.Alias
			alias({ args = { "mv", "Move" } })
			alias({ args = { "rm", "Trash" } })
			alias({ args = { "dup", "Duplicate" } })
			alias({ args = { "ren", "Rename" } })
			alias({ args = { "cpf", "CopyFilePath" } })
		end,
	},

	-- A Git wrapper so awesome, it should be illegal.
	{
		"https://github.com/tpope/vim-fugitive",
		event = "VeryLazy",
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

	-- Lightweight yet powerful formatter plugin for Neovim
	{
		"https://github.com/stevearc/conform.nvim",
		event = "VeryLazy",
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

	-- Easily install and manage LSP servers, DAP servers, linters, and formatters.
	{
		"https://github.com/williamboman/mason.nvim",
		opts = {},
	},

	-- Automatically install and upgrade third party tools.
	{
		"https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
		cmd = { "MasonToolsInstall", "MasonToolsInstallSync" },
		opts = {
			ensure_installed = {
				-- LSP
				"eslint-lsp",
				"lua-language-server",
				"emmet-language-server",
				"typescript-language-server",
				-- Formatters
				"prettierd",
				"stylua",
				"shfmt",
				"isort",
				"black",
				"jq",
				-- DAP
				"js-debug-adapter",
				"chrome-debug-adapter",
			},
		},
	},

	-- A fast Neovim http client written in Lua.
	{
		"https://github.com/rest-nvim/rest.nvim",
		tag = "v1.2.1",
		ft = { "http" },
		opts = {
			-- Skip SSL verification, useful for unknown certificates
			skip_ssl_verification = true,
			-- File to store environmental variables
			env_file = ".http-env",
		},
		config = function(_, opts)
			require("rest-nvim").setup(opts)
			au("FileType", {
				pattern = "http",
				callback = function()
					nmap("<leader>r", "<plug>RestNvim", { buffer = true, desc = "Run request under the cursor" })
				end,
			})
		end,
	},

	-- Project-wide search and replace
	{
		"https://github.com/nvim-pack/nvim-spectre",
		keys = {
			{ "<space>e", '<cmd>lua require("spectre").toggle()<cr>', desc = "Toggle spectre" },
		},
	},

	-- Utils for working with package.json files
	{
		"https://github.com/vuki656/package-info.nvim",
		config = function()
			nmap("<leader>nt", require("package-info").toggle, {
				silent = true,
				noremap = true,
				desc = "Toggle package.json versions display",
			})
			nmap("<leader>nu", require("package-info").update, {
				silent = true,
				noremap = true,
				desc = "Update dependency on current line",
			})
			nmap("<leader>nd", require("package-info").delete, {
				silent = true,
				noremap = true,
				desc = "Delete dependency on current line",
			})
			nmap("<leader>ni", require("package-info").install, {
				silent = true,
				noremap = true,
				desc = "Install new dependency",
			})
			nmap("<leader>np", require("package-info").change_version, {
				silent = true,
				noremap = true,
				desc = "Install different version of dependency on current line",
			})
		end,
	},
}

return {
	{
		"https://github.com/nvim-lua/plenary.nvim",
		priority = 1000,
	},

	{
		"https://github.com/konfekt/vim-alias",
		priority = 1000,
		config = function()
			local alias = vim.cmd.Alias
			alias({ args = { "w", "up" }, bang = true })
			alias({ args = { "man", "Man" }, bang = true })
		end,
	},

	colorschemes,
	motions,
	editing,
	ui,
	external,
}
