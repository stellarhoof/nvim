_G.G = {}

function G.buf_cwd()
  return vim.b.dir or vim.fn.getcwd()
end

-- Enable experimental UI intended to replace the message grid in the TUI
require("vim._core.ui2").enable({ enable = true })

-- Set filetype of `mdx` for files with extension `.mdx`
vim.filetype.add({ extension = { mdx = "mdx" } })
