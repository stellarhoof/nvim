vim.keymap.set("n", "<c-k>", "<cmd>wincmd k<cr>", { silent = true, desc = "Goto top split" })
vim.keymap.set("n", "<c-j>", "<cmd>wincmd j<cr>", { silent = true, desc = "Goto bottom split" })
vim.keymap.set("n", "<c-l>", "<cmd>wincmd l<cr>", { silent = true, desc = "Goto right split" })
vim.keymap.set("n", "<c-h>", "<cmd>wincmd h<cr>", { silent = true, desc = "Goto left split" })

vim.keymap.set("n", "]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set("n", "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

vim.keymap.set("i", "jk", "<esc>", { desc = "Exit insert mode" })
vim.keymap.set({ "n", "v" }, ",", ":", { noremap = true, desc = "Enter cmdline mode" })
vim.keymap.set(
  { "n", "v" },
  ":",
  ",",
  { noremap = true, desc = "Repeat latest f, t, F, or T in opposite direction" }
)

vim.keymap.set({ "n", "v" }, "k", "gk", { noremap = true, desc = "Move up a wrapped line" })
vim.keymap.set({ "n", "v" }, "j", "gj", { noremap = true, desc = "Move down a wrapped line" })

vim.keymap.set("t", "jk", "<c-\\><c-n>", { noremap = true, desc = "Exit terminal mode" })

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

vim.keymap.set("n", "<leader>ui", vim.show_pos, { desc = "Show items at a given buffer position." })

vim.keymap.set("n", "<leader>ul", function()
  if vim.fn.getloclist(0, { winid = 1 }).winid ~= 0 then
    vim.cmd.lclose()
  else
    vim.cmd.lopen()
  end
  vim.cmd.wincmd("p")
end, { desc = "Toggle location list" })

vim.keymap.set("n", "<leader>uq", function()
  if vim.fn.getqflist({ winid = 1 }).winid ~= 0 then
    vim.cmd.cclose()
  else
    vim.cmd.copen()
  end
  vim.cmd.wincmd("p")
end, { desc = "Toggle quickfix list" })
