vim.pack.add({
  -- Move 'up' or 'down' without changing the cursor column.
  -- "https://github.com/vim-utils/vim-vertical-move",

  -- Handle line and column numbers in file names.
  "https://github.com/wsdjeg/vim-fetch",

  -- Integration for https://pi.dev, the minimal coding agent
    -- TODO: Check https://github.com/monkeymonk/prompt.nvim
    -- TODO: Check https://github.com/dabstractor/pi-nvim-bridge
  "https://github.com/pablopunk/pi.nvim",

  -- Git stuff
  "https://github.com/tpope/vim-fugitive",
  "https://github.com/tpope/vim-rhubarb",
}, { confirm = false })

-- Fugitive aliases
vim.cmd.Alias({ args = { "g", "G" } })
vim.cmd.Alias({ args = { "gbl", "Git blame -w -M" } })
vim.cmd.Alias({ args = { "gbr", "GBrowse" } })
vim.cmd.Alias({ args = { "gd", "Gdiffsplit" } })
vim.cmd.Alias({ args = { "ge", "Gedit" } })
vim.cmd.Alias({ args = { "gr", "Gread" } })
vim.cmd.Alias({ args = { "gs", "Git" } })
vim.cmd.Alias({ args = { "gw", "Gwrite" } })
vim.cmd.Alias({ args = { "gg", "Ggrep" } })
vim.cmd.Alias({ args = { "gco", "Git checkout" } })
vim.cmd.Alias({ args = { "gcm", "Git commit" } })
vim.cmd.Alias({ args = { "gcma", "Git commit --amend" } })
vim.cmd.Alias({ args = { "gcman", "Git commit --amend --reuse-message HEAD" } })
