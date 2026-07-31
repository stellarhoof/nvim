-- Enables the :subsitute "/g" flag by default.
vim.o.gdefault = true
-- Ignore case in search patterns.
vim.o.ignorecase = true
-- Unset 'ignorecase' if search pattern contains uppercase characters.
vim.o.smartcase = true

-- Do not treat dashes in the middle of words as negative signs when inc/dec
-- with i_CTRL-X and i_CTRL-A.
vim.o.nrformats = "blank"

-- Do not create swap files.
vim.o.swapfile = false

-- Insert spaces instead of tabs.
vim.o.expandtab = true
-- Use 'shiftwidth'.
vim.o.softtabstop = -1
-- Round indent to multiple of 'shiftwidth'.
vim.o.shiftround = true
-- Use 'tabstop' for one level of (auto)indentation.
vim.o.shiftwidth = 0
-- Column multiple to display the tab character.
vim.o.tabstop = 2

-- Wrap text at this number of columns.
vim.o.textwidth = 80

-- Allo virtual editing in visual block mode only.
-- Virtual editing means the cursor can be positioned where there is no actual
-- character.
vim.o.virtualedit = "block"

-- When joining >2 lines, keep cursor at same position as if joining 2 lines.
vim.opt.cpoptions:append("q")

vim.keymap.set({ "i" }, "jk", "<esc>", {
  noremap = true,
  desc = "Exit insert mode",
})

vim.keymap.set({ "t" }, "jk", "<c-\\><c-n>", {
  noremap = true,
  desc = "Exit terminal mode",
})

vim.keymap.set({ "n", "v" }, "k", "gk", {
  noremap = true,
  desc = "Move up a wrapped line",
})

vim.keymap.set({ "n", "v" }, "j", "gj", {
  noremap = true,
  desc = "Move down a wrapped line",
})

vim.keymap.set({ "n", "v" }, ",", ":", {
  noremap = true,
  desc = "Enter cmdline mode",
})

vim.keymap.set({ "n", "v" }, ":", ",", {
  noremap = true,
  desc = "Repeat latest f, t, F, or T in opposite direction",
})

vim.keymap.set({ "n" }, "gp", '"`[" . strpart(getregtype(), 0, 1) . "`]"', {
  expr = true,
  noremap = true,
  desc = "Visually select last pasted text",
})

-- Move lines in normal mode and visual selections.
later(function ()
  require("mini.move").setup()
end)

-- Auto-insert pairs of delimiters.
later(function ()
  require("mini.pairs").setup()
end)

-- Create/change/delete surrounding delimiter pairs.
later(function ()
  require("mini.surround").setup()
end)

-- Various text editing operators.
later(function ()
  require("mini.operators").setup({
    exchange = { prefix = "ge" },
    replace = { prefix = "gs" },
    multiply = { prefix = "" },
    sort = { prefix = "" },
  })
end)

-- TODO: Missing textobjs: subword, url, filepath, argument
-- TODO: Use approach in https://github.com/nvim-mini/mini.nvim/issues/387 for
-- swapping
later(function ()
  require("mini.ai").setup({
    custom_textobjects = {
      i = require("mini.extra").gen_ai_spec.indent(),
    },
  })
end)

-- Insert mode snippets.
later(function ()
  require("mini.snippets").setup({
    snippets = {
      require("mini.snippets").gen_loader.from_lang({
        lang_patterns = {
          html = { "html.json" },
          javascript = { "html.json", "javascript.json", "javascriptreact.json" },
          tsx = {
            "html.json",
            "javascript.json",
            "javascriptreact.json",
            "typescript.json",
            "typescriptreact.json",
          },
          typescript = { "html.json", "javascript.json", "typescript.json" },
        },
      }),
    },
  })
end)

-- Enable dot-repeat on supported plugin maps.
vim.pack.add({ "https://github.com/tpope/vim-repeat" }, { confirm = false })

-- Sets 'commentstring' based on the cursor location in a file.
vim.pack.add({ "https://github.com/folke/ts-comments.nvim" }, { confirm = false })

-- Simple alignment operator.
vim.pack.add({ "https://github.com/tommcdo/vim-lion" }, { confirm = false })

-- Close and rename html/jsx tags.
vim.pack.add({ "https://github.com/tronikelis/ts-autotag.nvim" }, { confirm = false })

-- Move 'up' or 'down' without changing the cursor column.
-- "https://github.com/vim-utils/vim-vertical-move",

-- Navigate code with search labels, enhanced character motions and treesitter integration.
later(function ()
  vim.pack.add({ "https://github.com/folke/flash.nvim" }, { confirm = false })
  require("flash").setup({
    modes = {
      search = { enabled = false },
      char = { enabled = false },
      treesitter = {
        label = { after = false },
        highlight = { backdrop = true },
      },
    },
    highlight = { groups = { label = "IncSearch" } },
  })
  vim.keymap.set({ "n", "x", "o" }, "m", require("flash").jump, {
    desc = "Jump to words",
  })
  vim.keymap.set({ "n", "x", "o" }, "gm", require("flash").treesitter, {
    desc = "Select treesitter nodes",
  })
end)
