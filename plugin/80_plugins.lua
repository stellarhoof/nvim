G.misc.safely("now", function()
  vim.pack.add({
    -- Move 'up' or 'down' without changing the cursor column.
    "https://github.com/vim-utils/vim-vertical-move",
    -- Quickstart configs for Nvim LSP.
    "https://github.com/neovim/nvim-lspconfig",
    -- Enable repeating supported plugin maps with "."
    "https://github.com/tpope/vim-repeat",
    -- Sets 'commentstring' based on the cursor location in a file.
    "https://github.com/folke/ts-comments.nvim",
    -- A simple alignment operator
    "https://github.com/tommcdo/vim-lion",
    -- Auto insert pairs of delimiters.
    "https://github.com/windwp/nvim-autopairs", -- InsertEnter
    -- Handle line and column numbers in file names.
    "https://github.com/wsdjeg/vim-fetch",
    -- A vim plugin to perform diffs on blocks of code
    "https://github.com/AndrewRadev/linediff.vim",
    -- Integration for https://pi.dev, the minimal coding agent
    "https://github.com/pablopunk/pi.nvim",
    -- Extra commands on top of vtsls. See `after/lsp/vtsls.lua`
    "https://github.com/yioneko/nvim-vtsls",
    "https://github.com/dlyongemallo/diffview.nvim",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/konfekt/vim-alias",
  }, { confirm = false })

  vim.cmd.Alias({ args = { "w", "up" }, bang = true })
  vim.cmd.Alias({ args = { "man", "Man" }, bang = true })
end)

G.misc.safely("now", function()
  vim.pack.add({
    -- Pairs of handy bracket mappings
    "https://github.com/tpope/vim-unimpaired",
    -- Close and rename html/jsx elements with the power of treesitter
    "https://github.com/tronikelis/ts-autotag.nvim",
    -- Add/change/delete surrounding delimiter pairs with ease.
    "https://github.com/kylechui/nvim-surround",
  }, { confirm = false })

  G.nmap("co", "<plug>(unimpaired-toggle)")
end)
