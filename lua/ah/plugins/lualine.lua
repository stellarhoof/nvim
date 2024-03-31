return {
	"https://github.com/nvim-lualine/lualine.nvim",
	opts = function()
		local filetype = {
			"filetype",
			colored = false,
			icon_only = true,
			icon = { align = "" },
			-- color = "lualine_a_normal",
		}
		local filename = {
			"filename",
			path = 1,
			newfile_status = true,
			-- color = "lualine_a_normal",
		}
		local diagnostics = {
			"diagnostics",
			colored = false,
		}
		local location = {
			"location",
			-- color = "lualine_a_normal",
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
}
