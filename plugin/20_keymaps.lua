-- Window movements
vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<cr>", { silent = true, desc = "Goto top split" })
vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<cr>", { silent = true, desc = "Goto bottom split" })
vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<cr>", { silent = true, desc = "Goto right split" })
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<cr>", { silent = true, desc = "Goto left split" })

-- Window sizing
vim.keymap.set(
  "n",
  "<c-up>",
  "<cmd>resize +2<cr>",
  { silent = true, desc = "Increase window height" }
)
vim.keymap.set(
  "n",
  "<c-down>",
  "<cmd>resize -2<cr>",
  { silent = true, desc = "Decrease window height" }
)
vim.keymap.set(
  "n",
  "<c-left>",
  "<cmd>vertical resize -2<cr>",
  { silent = true, desc = "Decrease window width" }
)
vim.keymap.set(
  "n",
  "<c-right>",
  "<cmd>vertical resize +2<cr>",
  { silent = true, desc = "Increase window width" }
)

-- Tab movements
vim.keymap.set("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Faster mode switching
vim.keymap.set("i", "jk", "<esc>")
vim.keymap.set({ "n", "v" }, ",", ":", { noremap = true })
vim.keymap.set({ "n", "v" }, ":", ",", { noremap = true })

-- Treat wrapped lines as normal lines when moving up/down
vim.keymap.set({ "n", "v" }, "k", "gk", { noremap = true })
vim.keymap.set({ "n", "v" }, "j", "gj", { noremap = true })

-- Terminal mappings
vim.keymap.set("t", "jk", "<c-\\><c-n>", { noremap = true })

vim.keymap.set({ "i", "n", "s", "x" }, "<c-s>", vim.cmd.wall, { desc = "Write all buffers" })

vim.keymap.set(
  "n",
  "gp",
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, noremap = true, desc = "Visually select last pasted text" }
)

vim.keymap.set(
  "c",
  "%%",
  '<c-r>=fnameescape(expand("%:~:h"))<cr>',
  { noremap = true, desc = "Expand to directory of current file." }
)

-- UI

vim.keymap.set("n", "<leader>ur", "<cmd>restart<cr>", { desc = "Restart UI" })

vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Show items at a given buffer position." })

vim.keymap.set("n", "<leader>ul", function()
  local _ = vim.fn.getloclist(0, { winid = 1 }).winid ~= 0 and vim.cmd.lclose() or vim.cmd.lopen()
  vim.cmd.wincmd("p")
end, { desc = "Toggle location list" })

vim.keymap.set("n", "<leader>uq", function()
  local _ = vim.fn.getqflist({ winid = 1 }).winid ~= 0 and vim.cmd.cclose()
    or vim.cmd("botright copen")
  vim.cmd.wincmd("p")
end, { desc = "Toggle quickfix list" })
