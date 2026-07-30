-- See `:h default-mappings`

vim.keymap.set({ "n" }, "<c-k>", "<cmd>wincmd k<cr>", { silent = true, desc = "Goto top split" })
vim.keymap.set({ "n" }, "<c-j>", "<cmd>wincmd j<cr>", { silent = true, desc = "Goto bottom split" })
vim.keymap.set({ "n" }, "<c-l>", "<cmd>wincmd l<cr>", { silent = true, desc = "Goto right split" })
vim.keymap.set({ "n" }, "<c-h>", "<cmd>wincmd h<cr>", { silent = true, desc = "Goto left split" })

-- `:help CTRL-L-default`
-- `<c-l>` was remapped above so we need a new one.
vim.keymap.set(
  { "n" },
  "<a-l>",
  --- Use normal! <c-l> to prevent inserting raw <c-l> when using i_<c-o>. #17473
  "<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>",
  { desc = "Redraw screen, clear search highlights, and update diffs." }
)

vim.keymap.set({ "n" }, "]<tab>", "<cmd>tabnext<cr>", { desc = "Next Tab" })
vim.keymap.set({ "n" }, "[<tab>", "<cmd>tabprevious<cr>", { desc = "Previous Tab" })

vim.keymap.set({ "i" }, "jk", "<esc>", { desc = "Exit insert mode" })
vim.keymap.set({ "t" }, "jk", "<c-\\><c-n>", { noremap = true, desc = "Exit terminal mode" })
vim.keymap.set({ "n", "v" }, ",", ":", { noremap = true, desc = "Enter cmdline mode" })
vim.keymap.set(
  { "n", "v" },
  ":",
  ",",
  { noremap = true, desc = "Repeat latest f, t, F, or T in opposite direction" }
)

vim.keymap.set({ "n", "v" }, "k", "gk", { noremap = true, desc = "Move up a wrapped line" })
vim.keymap.set({ "n", "v" }, "j", "gj", { noremap = true, desc = "Move down a wrapped line" })

vim.keymap.set({ "n" }, "<c-s>", vim.cmd.wall, { desc = "Write all buffers" })

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

vim.keymap.set("n", "gK", vim.show_pos, { desc = "Show items at a given buffer position." })

-- UI toggles
do
  local function index_of(tbl, item)
    for i, v in ipairs(tbl) do
      if v == item then
        return i
      end
    end
  end

  local function toggle_option(value, states)
    local idx = index_of(states, value) or 0
    return states[(idx % #states) + 1]
  end

  vim.keymap.set({ "n" }, "<leader>ui", function()
    vim.wo.list = toggle_option(vim.wo.list, { true, false })
  end, { desc = "Toggle 'list' option" })

  vim.keymap.set({ "n" }, "<leader>un", function()
    vim.wo.number = toggle_option(vim.wo.number, { true, false })
  end, { desc = "Toggle 'number' option" })

  vim.keymap.set({ "n" }, "<leader>uw", function()
    vim.wo.wrap = toggle_option(vim.wo.wrap, { true, false })
  end, { desc = "Toggle 'wrap' option" })

  vim.keymap.set({ "n" }, "<leader>ud", function()
    vim.cmd(vim.wo.diff and "diffoff" or "diffthis")
  end, { desc = "Toggle diff mode" })

  vim.keymap.set({ "n" }, "<leader>ul", function()
    vim.cmd(vim.fn.getloclist(0, { winid = true }).winid ~= 0 and "lclose" or "lopen")
    vim.cmd.wincmd("p")
  end, { desc = "Toggle location list" })

  vim.keymap.set({ "n" }, "<leader>uq", function()
    vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and "cclose" or "copen")
    vim.cmd.wincmd("p")
  end, { desc = "Toggle quickfix list" })
end

-- Move lines/blocks
-- TODO: Replace with https://github.com/nvim-mini/mini.nvim/blob/main/readmes/mini-move.md
do
  function N_move_above()
    vim.cmd("silent! move --" .. vim.v.count1)
  end
  vim.keymap.set({ "n" }, "[e", function()
    vim.go.operatorfunc = "v:lua.N_move_above"
    return "g@l"
  end, { expr = true, desc = "Move current line up" })

  function X_move_above()
    vim.cmd("silent! '<,'>move '<--" .. vim.v.count1)
  end
  vim.keymap.set({ "x" }, "[e", function()
    vim.go.operatorfunc = "v:lua.X_move_above"
    return "g@l"
  end, { expr = true, desc = "Move current selection up" })

  function N_move_below()
    vim.cmd("silent! move +" .. vim.v.count1)
  end
  vim.keymap.set({ "n" }, "]e", function()
    vim.go.operatorfunc = "v:lua.N_move_below"
    return "g@l"
  end, { expr = true, desc = "Move current line down" })

  function X_move_below()
    vim.cmd("silent! '<,'>move '>+" .. vim.v.count1)
  end
  vim.keymap.set({ "x" }, "]e", function()
    vim.go.operatorfunc = "v:lua.X_move_below"
    return "g@l"
  end, { expr = true, desc = "Move current selection up" })
end
