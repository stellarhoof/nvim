-- This directory

-- Define global utilities
local globals = require("ah.globals")

-- TODO: Make all globals actually global with _G
globals.root = vim.fn.fnamemodify(debug.getinfo(1, "S").source:sub(2), ":h")

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
vim.lsp.enable({ "vtsls", "biome", "eslint", "lua_ls", "tailwindcss" })
