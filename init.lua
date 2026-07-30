_G.G = {}

function G.buf_cwd()
  return vim.b.dir or vim.fn.getcwd()
end

-- Set filetype of `mdx` for files with extension `.mdx`
vim.filetype.add({ extension = { mdx = "mdx" } })
