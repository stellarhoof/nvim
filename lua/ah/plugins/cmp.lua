return {
	"https://github.com/hrsh7th/nvim-cmp",
	event = "InsertEnter",
	dependencies = {
		"https://github.com/hrsh7th/cmp-nvim-lsp",
		"https://github.com/hrsh7th/cmp-buffer",
		"https://github.com/hrsh7th/cmp-path",
		{
			"https://github.com/onsails/lspkind.nvim",
			config = function()
				require("lspkind").init({
					symbol_map = require("ah.plugins.lsp.icons").kind,
				})
			end,
		},
	},
	config = function()
		require("cmp").setup({
			completion = {
				autocomplete = false, -- Do not autocomplete as you type
				completeopt = "menu,menuone,select",
			},
			formatting = {
				fields = { "kind", "abbr", "menu" },
				format = require("lspkind").cmp_format(),
			},
			sources = require("cmp").config.sources({
				{ name = "nvim_lsp", group_index = 1 },
				{ name = "buffer", group_index = 1 },
				{ name = "path", group_index = 1 },
			}),
			snippet = {
				expand = function() end,
			},
			mapping = require("cmp").mapping.preset.insert({
				-- Pick selected entry
				["<cr>"] = require("cmp").mapping.confirm(),
				-- Trigger completion if no menu is open. Otherwise select next item
				["<c-n>"] = function()
					local cmp = require("cmp")
					if not cmp.visible() then
						cmp.complete()
					else
						cmp.select_next_item()
					end
				end,
			}),
		})
	end,
}
