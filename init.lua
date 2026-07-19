_G.G = {}

-- 'mini.nvim' - all-in-one plugin powering most features.
-- Load now to have 'mini.misc' available for custom loading helpers.
vim.pack.add({ "https://github.com/nvim-mini/mini.nvim" })

G.misc = require("mini.misc")

function G.buf_cwd()
  return vim.b.dir or vim.fn.getcwd()
end

-- Enable experimental UI intended to replace the message grid in the TUI
require("vim._core.ui2").enable({ enable = true })

-- Set filetype of `mdx` for files with extension `.mdx`
vim.filetype.add({ extension = { mdx = "mdx" } })

-- Use the markdown parser for `mdx` filetypes
vim.treesitter.language.register("markdown", "mdx")
