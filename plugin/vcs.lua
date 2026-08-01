-- Git wrapper.
later(function ()
  vim.pack.add({ "https://github.com/tpope/vim-fugitive" }, { confirm = false })
  vim.cmd.Alias({ args = { "g", "G" } })
  vim.cmd.Alias({ args = { "gbl", "Git blame -w -M" } })
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
end)

-- Github extension for fugitive.
later(function ()
  vim.pack.add({ "https://github.com/tpope/vim-rhubarb" }, { confirm = false })
  vim.cmd.Alias({ args = { "gbr", "GBrowse" } })
end)

-- https://github.com/justinmk/guh.nvim
-- https://github.com/barrettruth/diffs.nvim
