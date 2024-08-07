-- Window movements
G.nmap("<c-k>", "<cmd>wincmd k<cr>", { silent = true, desc = "Goto top split" })
G.nmap("<c-j>", "<cmd>wincmd j<cr>", { silent = true, desc = "Goto bottom split" })
G.nmap("<c-l>", "<cmd>wincmd l<cr>", { silent = true, unique = false, desc = "Goto right split" })
G.nmap("<c-h>", "<cmd>wincmd h<cr>", { silent = true, desc = "Goto left split" })

-- Window sizing
G.nmap("<c-up>", "<cmd>resize +2<cr>", { silent = true, desc = "Increase window height" })
G.nmap("<c-down>", "<cmd>resize -2<cr>", { silent = true, desc = "Decrease window height" })
G.nmap("<c-left>", "<cmd>vertical resize -2<cr>", { silent = true, desc = "Decrease window width" })
G.nmap(
  "<c-right>",
  "<cmd>vertical resize +2<cr>",
  { silent = true, desc = "Increase window width" }
)

-- Tab movements
G.nmap("]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
G.nmap("[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Faster mode switching
G.imap("jk", "<esc>")
G.map({ "n", "v" }, ",", ":", { noremap = true })
G.map({ "n", "v" }, ":", ",", { noremap = true })

-- Treat wrapped lines as normal lines when moving up/down
G.map({ "n", "v" }, "k", "gk", { noremap = true })
G.map({ "n", "v" }, "j", "gj", { noremap = true })

G.map({ "i", "n", "s", "x" }, "<c-s>", vim.cmd.wall, { desc = "Write all buffers" })

G.nmap(
  "gp",
  '"`[" . strpart(getregtype(), 0, 1) . "`]"',
  { expr = true, noremap = true, desc = "Visually select last pasted text" }
)

G.cmap(
  "%%",
  '<c-r>=fnameescape(expand("%:~:h"))<cr>',
  { noremap = true, desc = "Expand to directory of current file." }
)

-- UI Show/Toggles

G.nmap("<leader>ui", vim.show_pos, { desc = "Show items at a given buffer position." })

G.nmap("<leader>ul", function()
  local _ = vim.fn.getloclist(0, { winid = 1 }).winid ~= 0 and vim.cmd.lclose() or vim.cmd.lopen()
  vim.cmd.wincmd("p")
end, { desc = "Toggle location list" })

G.nmap("<leader>uq", function()
  local _ = vim.fn.getqflist({ winid = 1 }).winid ~= 0 and vim.cmd.cclose()
    or vim.cmd("botright copen")
  vim.cmd.wincmd("p")
end, { desc = "Toggle quickfix list" })
