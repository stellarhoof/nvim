local snippets_dir = root .. "/lua/ah/plugins/luasnip/snippets"

return {
	"https://github.com/L3MON4D3/LuaSnip",
	event = "InsertEnter",
	version = "v2.*",
	build = "make install_jsregexp",
	keys = {
		{
			"<leader>us",
			function()
				local ftypes = {}
				local paths = {}

				local bufnr = vim.api.nvim_get_current_buf()
				vim.list_extend(ftypes, require("luasnip.util.util").get_snippet_filetypes())
				vim.list_extend(ftypes, require("luasnip.loaders.util").get_load_fts(bufnr))

				local data = require("luasnip.loaders.data")
				for _, ft in pairs(vim.fn.uniq(vim.fn.sort(ftypes))) do
					vim.list_extend(paths, vim.tbl_keys(data.lua_ft_paths[ft]))
					vim.list_extend(paths, vim.tbl_keys(data.snipmate_ft_paths[ft]))
					vim.list_extend(paths, vim.tbl_keys(data.vscode_ft_paths[ft]))
				end

				if vim.tbl_isempty(paths) then
					vim.notify("No snippets for current filetype", vim.log.levels.WARN)
				else
					vim.ui.select(vim.fn.sort(paths), {
						kind = "snippets",
						prompt = "Select snippet file to edit",
						format_item = function(item)
							return string.sub(item, #snippets_dir + 2, #item)
						end,
					}, function(choice)
						vim.cmd.edit(choice)
					end)
				end
			end,
			desc = "Open snippets for current filetype",
		},
	},
	config = function()
		local luasnip = require("luasnip")

		-- Include rhs snippets in lhs filetypes
		-- luasnip.filetype_extend("javascriptreact", { "javascript" })
		-- luasnip.filetype_extend("typescript", { "javascript" })
		-- luasnip.filetype_extend("typescriptreact", { "typescript" })

		-- luasnip.filetype_extend("javascriptreact", { "javascript" })
		-- luasnip.filetype_extend("typescript", { "javascript" })
		-- luasnip.filetype_extend("typescriptreact", { "typescript", "javascriptreact" })

		require("luasnip.loaders.from_snipmate").lazy_load({ paths = { snippets_dir } })

		-- Use tab in visual mode to wrap stuff in snippets
		luasnip.config.setup({ store_selection_keys = "<tab>" })

		map({ "i", "s" }, "<tab>", function()
			return luasnip.expand_or_jumpable() and "<plug>luasnip-expand-or-jump" or "<tab>"
		end, { silent = true, expr = true, desc = "Expand or jump in snippet" })

		map({ "i", "s" }, "<s-tab>", function()
			require("luasnip").jump(-1)
		end, { silent = true, desc = "Jump backwards in snippet" })

		map({ "i", "s" }, "<c-tab>", function()
			return luasnip.choice_active() and "<plug>luasnip-next-choice" or "<c-tab>"
		end, { silent = true, expr = true, desc = "Select choice in snippet" })
	end,
}
