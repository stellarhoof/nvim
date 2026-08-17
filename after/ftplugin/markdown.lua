-- Use 'shiftwidth'.
vim.bo.softtabstop = -1
-- Use 'tabstop' for one level of (auto)indentation.
vim.bo.shiftwidth = 0
-- Column multiple to display the tab character.
vim.bo.tabstop = 2

vim.wo.foldmethod = "expr"
vim.wo.foldexpr = vim.treesitter.foldexpr
