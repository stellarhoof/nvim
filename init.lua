-- Define global utilities
require("ah.globals")

-- Set editor options
require("ah.options")

-- Set keymaps
require("ah.keymaps")

-- Set autocommands
require("ah.autocommands")

-- Configure diagnostics
require("ah.diagnostics")

-- Setup plugins. Install plugin manager if necessary.
require("ah.lazy")

-- https://github.com/neovim/neovim/issues/32074
vim.lsp.enable({ "vtsls", "biome", "eslint", "lua_ls" })
