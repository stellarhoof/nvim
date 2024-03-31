-- General purpose motions.
return {
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
			modes = {
				search = {
					enabled = false,
				},
				char = {
					enabled = false,
				},
				treesitter = {
					label = { after = false },
					highlight = {
						backdrop = true,
					},
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
		})

		map({ "n", "x", "o" }, "m", require("flash").jump, { desc = "Jump to words" })

		map(
			{ "n", "x", "o" },
			"gm",
			require("flash").treesitter,
			{ desc = "Select treesitter nodes" }
		)
	end,
}
