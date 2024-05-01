return {
	"https://github.com/nvim-telescope/telescope.nvim",
	dependencies = {
		{ "https://github.com/MunifTanjim/nui.nvim" },
		{
			"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
		{
			"https://github.com/smartpde/telescope-recent-files",
			init = function()
				nmap("<leader>h", function()
					require("telescope").extensions.recent_files.pick({
						layout_strategy = "window",
						hidden = true,
						no_ignore = true,
					})
				end, { noremap = true, desc = "File History" })
			end,
			config = function()
				require("telescope").load_extension("recent_files")
			end,
		},
		{
			"https://github.com/benfowler/telescope-luasnip.nvim",
			init = function()
				nmap("<leader>ts", function()
					require("telescope").extensions.luasnip.luasnip({
						layout_strategy = "vertical",
						sorting_strategy = "ascending",
					})
				end, { noremap = true, desc = "Luasnips snippets" })
			end,
			config = function()
				require("telescope").load_extension("luasnip")
			end,
		},
		-- Select and insert Nerd icons
		{
			"https://github.com/2KAbhishek/nerdy.nvim",
			init = function()
				nmap("<leader>ti", function()
					require("telescope").extensions.nerdy.nerdy({
						layout_strategy = "center",
					})
				end, { noremap = true, desc = "Nerd Icons" })
			end,
			config = function()
				require("telescope").load_extension("nerdy")
			end,
		},
		{
			"https://github.com/piersolenski/telescope-import.nvim",
			init = function()
				nmap("<leader>i", function()
					require("telescope").extensions.import.import({})
				end, { noremap = true, desc = "Insert imports" })
			end,
			config = function()
				require("telescope").load_extension("import")
			end,
		},
	},
	cmd = { "Telescope" },
	init = function()
		nmap("<leader>s", function()
			require("telescope.builtin").live_grep({
				cwd = buf_cwd(),
				layout_strategy = "vertical",
			})
		end, { noremap = true, desc = "Live Grep" })

		nmap("<leader>b", function()
			require("telescope.builtin").buffers({
				layout_strategy = "window",
				sort_mru = true,
				ignore_current_buffer = true,
			})
		end, { noremap = true, desc = "Buffers" })

		nmap("<leader>p", function()
			require("ah.plugins.telescope.repos")({
				layout_strategy = "window",
				roots = {
					code = "~/Code",
					plugin = vim.fn.stdpath("data") .. "/lazy",
				},
			})
		end, { noremap = true, desc = "Projects" })

		nmap("<leader>f", function()
			local opts = {
				layout_strategy = "window",
				cwd = buf_cwd(),
			}

			local out = vim.system(
				{ "git", "rev-parse", "--is-inside-work-tree" },
				{ text = true, cwd = opts.cwd }
			):wait()

			if out.code == 0 then
				require("telescope.builtin").git_files(merge(opts, {
					use_git_root = false,
					show_untracked = true,
				}))
			else
				require("telescope.builtin").find_files(opts)
			end
		end, { noremap = true, desc = "Git Files" })

		-- Telescope

		nmap("<leader>tt", function()
			require("telescope.builtin").builtin({ include_extensions = true })
		end, { noremap = true, desc = "Pickers" })

		nmap("<leader>th", function()
			require("telescope.builtin").help_tags({})
		end, { noremap = true, desc = "Help Tags" })

		nmap("<leader>tf", function()
			require("telescope.builtin").find_files({
				layout_strategy = "window",
				cwd = buf_cwd(),
				hidden = true,
			})
		end, { noremap = true, desc = "Files" })

		nmap("<leader>tl", function()
			require("telescope.builtin").current_buffer_fuzzy_find({
				layout_strategy = "window",
			})
		end, { noremap = true, desc = "Buffer lines" })

		nmap("<leader>tc", function()
			require("telescope.builtin").colorscheme({
				enable_preview = true,
			})
		end, { noremap = true, desc = "Colorschemes" })

		-- Git

		nmap("<leader>gb", function()
			require("telescope.builtin").git_branches({
				previewer = false,
				layout_config = {
					horizontal = {
						size = { width = "60%", height = "50%" },
					},
				},
			})
		end, { noremap = true, desc = "All Git Branches" })

		nmap("<leader>gl", function()
			require("telescope.builtin").git_branches({
				previewer = false,
				show_remote_tracking_branches = false,
				layout_config = {
					horizontal = {
						size = { width = "60%", height = "50%" },
					},
				},
			})
		end, { noremap = true, desc = "Local Git Branches" })

		nmap("<leader>gs", function()
			require("telescope.builtin").git_stash({
				previewer = false,
			})
		end, { noremap = true, desc = "Git Stashes" })
	end,
	config = function()
		local mappings = {
			-- Do not scroll previewer on <c-u>. Instead perform the default
			-- action which is to clear the prompt.
			["<c-u>"] = false,
			["<c-]>"] = require("telescope.actions").cycle_history_next,
			["<c-[>"] = require("telescope.actions").cycle_history_prev,
			["<c-1>"] = require("telescope.actions.layout").toggle_preview,
			["<c-2>"] = require("telescope.actions.layout").toggle_prompt_position,
			["<c-3>"] = require("telescope.actions.layout").toggle_mirror,
			["<c-4>"] = require("telescope.actions.layout").cycle_layout_next,
			["<c-5>"] = require("telescope.actions.layout").cycle_layout_prev,
		}

		require("telescope").setup({
			defaults = {
				prompt_prefix = "  ",
				selection_caret = " ",
				dynamic_preview_title = true,
				sorting_strategy = "ascending",
				mappings = { i = mappings, n = mappings },
				layout_strategy = "horizontal",
				create_layout = function(picker)
					local layouts = require("ah.plugins.telescope.layouts")
					local PickerLayout = require("telescope.pickers.layout")
					return PickerLayout(layouts[picker.layout_strategy](picker))
				end,
			},
			extensions = {
				fzf = {
					fuzzy = true,
					override_generic_sorter = true,
					override_file_sorter = true,
					case_mode = "smart_case",
				},
			},
		})

		-- -- Undo folding fix: https://github.com/nvim-telescope/telescope.nvim/issues/699
		-- au({ "BufEnter" }, {
		-- 	desc = "Undo telescope folding fix",
		-- 	callback = function()
		-- 		vim.schedule(function()
		-- 			-- vim.opt.foldmethod = "indent"
		-- 			vim.wo.foldmethod = "expr"
		-- 			vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
		-- 		end)
		-- 	end,
		-- })
	end,
}
