-- Navigate your code with search labels, enhanced character motions and
-- Treesitter integration
return {
  "https://github.com/folke/flash.nvim",
  event = "VeryLazy",
  opts = {
    -- search = {
    --   -- Match beginning of words only
    --   mode = function(str)
    --     return "\\<" .. str
    --   end,
    -- },
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
    G.map({ "n", "x", "o" }, "m", require("flash").jump, { desc = "Jump to words" })
    G.map(
      { "n", "x", "o" },
      "gm",
      require("flash").treesitter,
      { desc = "Select treesitter nodes" }
    )
  end,
}
