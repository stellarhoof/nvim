imap("jk", "<esc>")

nmap("<c-k>", "<cmd>wincmd k<cr>", { silent = true, desc = "Goto top split" })
nmap("<c-j>", "<cmd>wincmd j<cr>", { silent = true, desc = "Goto bottom split" })
nmap("<c-l>", "<cmd>wincmd l<cr>", { silent = true, desc = "Goto right split" })
nmap("<c-h>", "<cmd>wincmd h<cr>", { silent = true, desc = "Goto left split" })

map({ "n", "v" }, ",", ":", { noremap = true })
map({ "n", "v" }, ":", ",", { noremap = true })
map({ "n", "v" }, "k", "gk", { noremap = true })
map({ "n", "v" }, "j", "gj", { noremap = true })

nmap("<c-s>", cmd.wall, { desc = "Write all buffers" })

nmap("<space>d", function()
	vim.o.foldmethod = "indent"
end, { desc = "Set foldmethod to indent" })

nmap("go", function()
	local open = (fn.has("mac") == 1 and "open") or (fn.has("unix") == 1 and "xdg-open")
	fn.jobstart({ open, fn.expand("<cfile>") }, { detach = true })
end, { desc = "Open URL under cursor" })

nmap("<leader>w", function()
	local _ = fn.getloclist(0, { winid = 1 }).winid ~= 0 and cmd.lclose() or cmd.lopen()
	cmd.wincmd("p")
end, { desc = "Toggle location window" })

nmap("<leader>q", function()
	local _ = fn.getqflist({ winid = 1 }).winid ~= 0 and cmd.cclose() or cmd("botright copen")
	cmd.wincmd("p")
end, { desc = "Toggle quickfix window" })

nmap(
	"gp",
	'"`[" . strpart(getregtype(), 0, 1) . "`]"',
	{ expr = true, noremap = true, desc = "Visually select last pasted text" }
)

-- Expand to directory of current file.
cmap("%%", '<c-r>=fnameescape(expand("%:~:h"))<cr>', { noremap = true })

nmap("ga", vim.show_pos, { desc = "Show all the items at a given buffer position." })
