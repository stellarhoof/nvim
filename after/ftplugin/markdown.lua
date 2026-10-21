-- Use 'shiftwidth'.
vim.bo.softtabstop = -1
-- Use 'tabstop' for one level of (auto)indentation.
vim.bo.shiftwidth = 0
-- Column multiple to display the tab character.
vim.bo.tabstop = 2

vim.wo[0][0].foldmethod = "expr"
vim.wo[0][0].foldexpr = vim.treesitter.foldexpr
