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

-- Configure lsp
require("ah.lsp")

-- Setup plugins. Install plugin manager if necessary.
require("ah.lazy")

-- Enable experimental UI intended to replace the message grid in the TUI
require("vim._extui").enable({ enable = true })
