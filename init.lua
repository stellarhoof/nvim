_G.G = {}

function G.buf_cwd()
  return vim.b.dir or vim.fn.getcwd()
end

-- Enable experimental UI intended to replace the message grid in the TUI
require("vim._core.ui2").enable({ enable = true })

-- Set filetype of `mdx` for files with extension `.mdx`
vim.filetype.add({ extension = { mdx = "mdx" } })

-- Enables project-local configuration via `.nvim.lua`, `.nvimrc`, or `.exrc` files.
-- This option has to be set here.
vim.o.exrc = true
