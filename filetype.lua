-- Set filetype of `mdx` for files with extension `.mdx`
vim.filetype.add({ extension = { mdx = "mdx" } })

-- Use the markdown parser for `mdx` filetypes
vim.treesitter.language.register("markdown", "mdx")

-- Set filetype of `http` for files with extension `.http`
vim.filetype.add({ extension = { http = "http" } })
