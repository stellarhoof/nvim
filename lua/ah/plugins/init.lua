return {
	-- Stdlib. Many plugins depends on this.
	{
		"https://github.com/nvim-lua/plenary.nvim",
	},

	-- Vim sugar for the UNIX shell commands that need it the most
	{
		"https://github.com/tpope/vim-eunuch",
	},

	-- Colorschemes
	{
		"https://github.com/folke/tokyonight.nvim",
	},

	{
		"https://github.com/mcchrish/zenbones.nvim",
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

	-- A Git wrapper so awesome, it should be illegal.
	{
		"https://github.com/tpope/vim-fugitive",
		dependencies = { "https://github.com/tpope/vim-rhubarb" },
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
		config = function()
			require("yanky").setup({
				highlight = {
					on_put = false,
					on_yank = false,
				},
			})
			map({ "n", "x" }, "y", "<plug>(YankyYank)")
			map({ "n", "x" }, "p", "<plug>(YankyPutAfter)")
			map({ "n", "x" }, "P", "<plug>(YankyPutBefore)")
			nmap("<c-n>", "<plug>(YankyCycleForward)")
			nmap("<c-p>", "<plug>(YankyCycleBackward)")
		end,
	},

	-- -- Operators to substitute and exchange text.
	-- -- Lua version of https://github.com/svermeulen/vim-subversive and
	-- -- https://github.com/tommcdo/vim-exchange
	-- {
	--   "https://github.com/gbprod/substitute.nvim",
	--   config = function()
	--     require("substitute").setup({
	--       highlight_substituted_text = {
	--         enabled = false,
	--       },
	--     })
	--     -- Substitute
	--     nmap("gs", require("substitute").operator, { noremap = true })
	--     nmap("gss", require("substitute").line, { noremap = true })
	--     nmap("gS", require("substitute").eol, { noremap = true })
	--     xmap("gs", require("substitute").visual, { noremap = true })
	--     -- Exchange
	--     nmap("gx", require("substitute.exchange").operator, { noremap = true })
	--     nmap("gxx", require("substitute.exchange").line, { noremap = true })
	--     nmap("gxc", require("substitute.exchange").cancel, { noremap = true })
	--     xmap("X", require("substitute.exchange").visual, { noremap = true })
	--   end,
	-- },

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
		opts = {},
	},

	-- A high-performance color highlighter with no external dependencies.
	{
		"https://github.com/NvChad/nvim-colorizer.lua",
		keys = { { "<leader>c", vim.cmd.ColorizerToggle, desc = "Toggle Colorizer" } },
		opts = {
			filetypes = {},
			user_default_options = { names = false, hsl_fn = true, rgb_fn = true },
		},
	},

	-- Statusline.
	{
		"https://github.com/nvim-lualine/lualine.nvim",
		opts = function()
			local filetype = {
				"filetype",
				colored = false,
				icon_only = true,
				icon = { align = "" },
				color = "lualine_a_normal",
			}
			local filename = {
				"filename",
				path = 1,
				newfile_status = true,
				color = "lualine_a_normal",
			}
			local diagnostics = {
				"diagnostics",
				colored = false,
			}
			local location = {
				"location",
				color = "lualine_a_normal",
			}
			return {
				options = {
					section_separators = "",
					component_separators = "",
				},
				extensions = { "quickfix", "fugitive", "man", "trouble" },
				sections = {
					lualine_a = { filetype, filename },
					lualine_b = { diagnostics, "searchcount" },
					lualine_c = {},
					lualine_x = {},
					lualine_y = { "progress" },
					lualine_z = { location },
				},
				inactive_sections = {
					lualine_a = { filetype, filename },
					lualine_b = { diagnostics },
					lualine_c = {},
					lualine_x = {},
					lualine_y = { "progress" },
					lualine_z = { location },
				},
			}
		end,
	},

	-- General purpose motions.
	{
		"https://github.com/folke/flash.nvim",
		event = "VeryLazy",
		config = function()
			require("flash").setup({
				search = {
					-- Match beginning of words only
					mode = function(str)
						return "\\<" .. str
					end,
				},
				highlight = {
					backdrop = false,
				},
				modes = {
					search = {
						enabled = false,
					},
					char = {
						enabled = false,
					},
				},
			})

			map({ "n", "x", "o" }, "m", function()
				require("flash").jump()
			end, { desc = "Jump to words" })

			map({ "n", "x", "o" }, "gm", function()
				require("flash").treesitter()
			end, { desc = "Select treesitter nodes" })
		end,
	},

	-- Easily install and manage LSP servers, DAP servers, linters, and formatters.
	{
		"https://github.com/williamboman/mason.nvim",
		opts = {},
		dependencies = {
			{
				"https://github.com/williamboman/mason-lspconfig.nvim",
				opts = {},
			},
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

	-- Use Neovim as a language server to inject LSP diagnostics, code actions, and more via Lua.
	{
		"https://github.com/nvimtools/none-ls.nvim",
		config = function()
			local fmt = require("null-ls").builtins.formatting
			local lint = require("null-ls").builtins.diagnostics
			require("null-ls").setup({
				on_attach = require("ah.plugins.lsp").on_attach,
				sources = {
					lint.eslint,
					fmt.nixfmt,
					fmt.shfmt,
					fmt.fnlfmt,
					fmt.stylua,
					fmt.black,
					fmt.isort,
					fmt.prettierd,
				},
			})
		end,
	},

	-- Nvim Treesitter configurations and abstraction layer
	{
		"https://github.com/nvim-treesitter/nvim-treesitter",
		build = ":TSUpdate",
		config = function()
			require("nvim-treesitter.configs").setup({
				highlight = {
					enable = true,
					-- Disable slow treesitter highlight for large files
					disable = function(lang, buf)
						local max_filesize = 100 * 1024 -- 100 KB
						local ok, stats = pcall(vim.uv.fs_stat, vim.api.nvim_buf_get_name(buf))
						if ok and stats and stats.size > max_filesize then
							return true
						end
					end,
				},
			})
		end,
	},

	-- Smart and powerful comment plugin for neovim. Supports treesitter, dot
	-- repeat, left-right/up-down motions, hooks, and more.
	{
		{
			"https://github.com/numToStr/Comment.nvim",
			dependencies = {
				{ "https://github.com/JoosepAlviste/nvim-ts-context-commentstring" },
			},
			config = function()
				require("ts_context_commentstring").setup({ enable_autocmd = false })
				vim.g.skip_ts_context_commentstring_module = true
				require("Comment").setup({
					pre_hook = require("ts_context_commentstring.integrations.comment_nvim").create_pre_hook(),
				})
			end,
		},
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

	-- A fast Neovim http client written in Lua.
	{
		"https://github.com/rest-nvim/rest.nvim",
		ft = { "http" },
		init = function()
			au("FileType", {
				pattern = "http",
				callback = function()
					nmap("<leader>r", "<plug>RestNvim", { buffer = true })
					nmap("<leader>R", "<plug>RestNvimPreview", { buffer = true })
				end,
			})
		end,
		opts = {
			-- Skip SSL verification, useful for unknown certificates
			skip_ssl_verification = true,
			-- Jump to request line on run
			jump_to_request = false,
			-- File to store environmental variables
			env_file = ".http-env",
		},
	},

	-- The Refactoring library based off the Refactoring book by Martin Fowler.
	{
		"https://github.com/ThePrimeagen/refactoring.nvim",
		keys = {
			{
				"<leader>rr",
				function()
					require("refactoring").select_refactor()
				end,
				mode = "v",
				noremap = true,
				silent = true,
				desc = "Select refactor",
			},
		},
	},

	-- Readline motions and deletions in Neovim.
	-- Repo deleted?
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
			map(
				{ "i", "c" },
				"<m-bs>",
				readline.backward_kill_word,
				{ desc = "Backward kill word" }
			)

			-- Edit line
			map({ "i", "c" }, "<c-k>", readline.kill_line, { desc = "Forward kill line" })
			map({ "i", "c" }, "<c-u>", readline.backward_kill_line, { desc = "Backward kill line" })
		end,
	},

	-- Bundle of two dozen new text objects for Neovim.
	{
		"https://github.com/chrisgrieser/nvim-various-textobjs",
		config = function()
			-- The keymaps need to be called as Ex-command, otherwise they will not be
			-- dot-repeatable.
			local cmd = function(string)
				return "<cmd>lua require('various-textobjs')." .. string .. "<CR>"
			end

			-- Surrounding lines with same or higher indentation
			map({ "o", "x" }, "ii", cmd("indentation(true, true)"))
			map({ "o", "x" }, "ai", cmd("indentation(false, true)"))
			map({ "o", "x" }, "iI", cmd("indentation(true, true)"))
			map({ "o", "x" }, "aI", cmd("indentation(false, false)"))

			-- Like iw, but treating -, _, and . as word delimiters and only part of camelCase
			map({ "o", "x" }, "iv", cmd("subword(true)"))
			map({ "o", "x" }, "av", cmd("subword(false)"))

			-- From cursor to next ", ', or ```
			-- Maybe this can be accomplished with a motion
			map({ "o", "x" }, "q", cmd("toNextQuotationMark()"))

			-- Column down until indent or shorter line. Accepts {count} for multiple columns.
			map({ "o", "x" }, "|", cmd("column()"))
		end,
	},

	-- Directory viewer for Vim.
	{
		"https://github.com/justinmk/vim-dirvish",
		dependencies = { "https://github.com/roginfarrer/vim-dirvish-dovish" },
		config = function()
			vim.g.dirvish_mode = 2
			vim.g.dirvish_dovish_map_keys = 0
			au("FileType", {
				pattern = "dirvish",
				callback = function()
					vim.cmd.sort(",^.*[\\/],") -- Sort directories first
					nmap("F", "<plug>(dovish_create_file)", { silent = true, buffer = true })
					nmap("I", "<plug>(dovish_create_directory)", { silent = true, buffer = true })
					nmap("D", "<plug>(dovish_delete)", { silent = true, buffer = true })
					nmap("R", "<plug>(dovish_rename)", { silent = true, buffer = true })
					nmap("Y", "<plug>(dovish_yank)", { silent = true, buffer = true })
					xmap("Y", "<plug>(dovish_yank)", { silent = true, buffer = true })
					nmap("P", "<plug>(dovish_copy)", { silent = true, buffer = true })
					nmap("X", "<plug>(dovish_move)", { silent = true, buffer = true })
				end,
			})
		end,
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
