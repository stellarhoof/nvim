local getcwd = function()
	return vim.o.ft == "oil" and require("oil").get_current_dir()
end

-- config = function(_, opts)
-- local mappings = {
-- 	["<c-u>"] = false,
-- 	["<c-d>"] = false,
-- 	["<c-l>"] = false,
-- 	["<c-/>"] = require("telescope.actions").which_key,
-- 	["<c-1>"] = require("telescope.actions.layout").toggle_preview,
-- 	["<c-2>"] = require("telescope.actions.layout").toggle_prompt_position,
-- 	["<c-3>"] = require("telescope.actions.layout").toggle_mirror,
-- 	["<c-4>"] = require("telescope.actions.layout").cycle_layout_next,
-- 	["<c-5>"] = require("telescope.actions.layout").cycle_layout_prev,
-- }

return {
	"https://github.com/nvim-telescope/telescope.nvim",
	dependencies = {
		{ "https://github.com/MunifTanjim/nui.nvim" },
		{
			"https://github.com/smartpde/telescope-recent-files",
			config = function()
				require("telescope").load_extension("recent_files")
			end,
		},
		{
			"https://github.com/nvim-telescope/telescope-fzf-native.nvim",
			build = "make",
			config = function()
				require("telescope").load_extension("fzf")
			end,
		},
		{
			"https://github.com/benfowler/telescope-luasnip.nvim",
			config = function()
				require("telescope").load_extension("luasnip")
			end,
		},
	},
	cmd = { "Telescope" },
	opts = {
		defaults = {
			prompt_prefix = "󱈄 ",
			selection_caret = "󰮺 ",
			dynamic_preview_title = true,
			vimgrep_arguments = vim.g.grepprg,
			sorting_strategy = "ascending",
			-- mappings = { i = mappings, n = mappings },
			layout_strategy = "default",
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
	},
	init = function()
		nmap("<space>h", function()
			require("telescope.builtin").help_tags({})
		end, { noremap = true, desc = "Help Tags" })

		nmap("<space>m", function()
			require("telescope.builtin").man_pages({ previewer = false })
		end, { noremap = true, desc = "Man Pages" })

		nmap("<space>n", function()
			require("telescope").extensions.luasnip.luasnip({
				layout_strategy = "vertical",
				sorting_strategy = "ascending",
			})
		end, { noremap = true, desc = "Luasnips snippets" })

		nmap("<space>t", function()
			require("telescope.builtin").treesitter({
				layout_strategy = "window",
			})
		end, { noremap = true, desc = "Treesitter symbols" })

		nmap("<space>r", function()
			require("telescope.builtin").live_grep({
				cwd = getcwd(),
				layout_strategy = "vertical",
			})
		end, { noremap = true, desc = "Live Grep" })

		nmap("<space>aa", function()
			require("telescope.builtin").git_branches({
				previewer = false,
				layout_config = { size = { width = "60%", height = "50%" } },
			})
		end, { noremap = true, desc = "All Git Branches" })

		nmap("<space>al", function()
			require("telescope.builtin").git_branches({
				previewer = false,
				show_remote_tracking_branches = false,
				layout_config = { size = { width = "60%", height = "50%" } },
			})
		end, { noremap = true, desc = "Local Git Branches" })

		nmap("<space>as", function()
			require("telescope.builtin").git_stash({
				previewer = false,
			})
		end, { noremap = true, desc = "Git Stashes" })

		nmap("<space>g", function()
			require("telescope.builtin").git_files({
				layout_strategy = "window",
				cwd = getcwd(),
				use_git_root = false,
				show_untracked = true,
			})
		end, { noremap = true, desc = "Git Files" })

		nmap("<space>f", function()
			require("telescope.builtin").find_files({
				layout_strategy = "window",
				cwd = getcwd(),
				hidden = true,
			})
		end, { noremap = true, desc = "Files" })

		nmap("<space>b", function()
			require("telescope.builtin").buffers({
				layout_strategy = "window",
				sort_mru = true,
				ignore_current_buffer = true,
			})
		end, { noremap = true, desc = "Buffers" })

		nmap("<space>c", function()
			require("telescope.builtin").colorscheme({
				enable_preview = true,
			})
		end, { noremap = true, desc = "Colorschemes" })

		nmap("<space>o", function()
			require("ah.plugins.telescope.repos")({
				layout_strategy = "window",
				roots = {
					code = "~/code",
					plugin = vim.fn.stdpath("data") .. "/lazy",
				},
			})
		end, { noremap = true, desc = "Repositories" })

		nmap("<space>i", function()
			require("telescope").extensions.recent_files.pick({
				layout_strategy = "window",
				hidden = true,
				no_ignore = true,
			})
		end, { noremap = true, desc = "Recent Files" })
	end,
}
