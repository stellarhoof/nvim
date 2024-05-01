-- Window movements
nmap("<c-k>", "<cmd>wincmd k<cr>", { silent = true, desc = "Goto top split" })
nmap("<c-j>", "<cmd>wincmd j<cr>", { silent = true, desc = "Goto bottom split" })
nmap("<c-l>", "<cmd>wincmd l<cr>", { silent = true, unique = false, desc = "Goto right split" })
nmap("<c-h>", "<cmd>wincmd h<cr>", { silent = true, desc = "Goto left split" })

-- Window sizing
nmap("<c-up>", "<cmd>resize +2<cr>", { silent = true, desc = "Increase window height" })
nmap("<c-down>", "<cmd>resize -2<cr>", { silent = true, desc = "Decrease window height" })
nmap("<c-left>", "<cmd>vertical resize -2<cr>", { silent = true, desc = "Decrease window width" })
nmap("<c-right>", "<cmd>vertical resize +2<cr>", { silent = true, desc = "Increase window width" })

-- Tab movements
nmap("]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
nmap("[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

-- Faster mode switching
imap("jk", "<esc>")
map({ "n", "v" }, ",", ":", { noremap = true })
map({ "n", "v" }, ":", ",", { noremap = true })

-- Treat wrapped lines as normal lines when moving up/down
map({ "n", "v" }, "k", "gk", { noremap = true })
map({ "n", "v" }, "j", "gj", { noremap = true })

map({ "i", "n", "s", "x" }, "<c-s>", vim.cmd.wall, { desc = "Write all buffers" })

nmap(
	"gp",
	'"`[" . strpart(getregtype(), 0, 1) . "`]"',
	{ expr = true, noremap = true, desc = "Visually select last pasted text" }
)

cmap(
	"%%",
	'<c-r>=fnameescape(expand("%:~:h"))<cr>',
	{ noremap = true, desc = "Expand to directory of current file." }
)

-- UI Show/Toggles

nmap("<leader>ui", vim.show_pos, { desc = "Show items at a given buffer position." })

nmap("<leader>ul", function()
	local _ = vim.fn.getloclist(0, { winid = 1 }).winid ~= 0 and vim.cmd.lclose() or vim.cmd.lopen()
	vim.cmd.wincmd("p")
end, { desc = "Toggle location list" })

nmap("<leader>uq", function()
	local _ = vim.fn.getqflist({ winid = 1 }).winid ~= 0 and vim.cmd.cclose()
		or vim.cmd("botright copen")
	vim.cmd.wincmd("p")
end, { desc = "Toggle quickfix list" })
