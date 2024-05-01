return {
	"https://github.com/nvim-lualine/lualine.nvim",
	opts = function()
		local filetype = {
			"filetype",
			colored = false,
			icon_only = true,
			icon = { align = "" },
		}
		local filename = {
			"filename",
			path = 1,
			shorting_target = 0,
			newfile_status = true,
		}
		local diagnostics = {
			"diagnostics",
			colored = false,
		}
		return {
			options = { section_separators = "", component_separators = "" },
			-- Manage statusline for buffers with the following filetypes
			extensions = { "fugitive", "man", "oil", "overseer", "quickfix", "trouble" },
			sections = {
				lualine_a = { filetype, filename },
				lualine_b = { diagnostics, "searchcount" },
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
			inactive_sections = {
				lualine_a = { filetype, filename },
				lualine_b = { diagnostics },
				lualine_c = {},
				lualine_x = {},
				lualine_y = {},
				lualine_z = {},
			},
		}
	end,
}
