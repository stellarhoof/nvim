-- Interesting mapping: https://github.com/neovim/neovim/discussions/34076

-- Enables the :subsitute "/g" flag by default.
vim.o.gdefault = true
-- Ignore case in search patterns.
vim.o.ignorecase = true
-- Unset 'ignorecase' if search pattern contains uppercase characters.
vim.o.smartcase = true
vim.o.infercase = true

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

vim.api.nvim_create_autocmd("FileType", {
  pattern = { "*" },
  callback = function ()
    -- Do not auto-insert hard newlines in while typing. Manual (gq/gw) formatting
    -- still respects |textwidth|.
    vim.opt.formatoptions:remove("t")
    vim.opt.formatoptions:remove("c")
  end,
})

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

-- Move lines/blocks
do
  function N_move_above()
    vim.cmd("silent! move --" .. vim.v.count1)
  end
  vim.keymap.set({ "n" }, "[e", function ()
    vim.go.operatorfunc = "v:lua.N_move_above"
    return "g@l"
  end, { expr = true, desc = "Move current line up" }
  )

  function X_move_above()
    vim.cmd("silent! '<,'>move '<--" .. vim.v.count1)
  end
  vim.keymap.set({ "x" }, "[e", function ()
    vim.go.operatorfunc = "v:lua.X_move_above"
    return "g@l"
  end, { expr = true, desc = "Move current selection up" }
  )

  function N_move_below()
    vim.cmd("silent! move +" .. vim.v.count1)
  end
  vim.keymap.set({ "n" }, "]e", function ()
    vim.go.operatorfunc = "v:lua.N_move_below"
    return "g@l"
  end, { expr = true, desc = "Move current line down" }
  )

  function X_move_below()
    vim.cmd("silent! '<,'>move '>+" .. vim.v.count1)
  end
  vim.keymap.set({ "x" }, "]e", function ()
    vim.go.operatorfunc = "v:lua.X_move_below"
    return "g@l"
  end, { expr = true, desc = "Move current selection up" }
  )
end

-- Auto-insert pairs of delimiters.
later(function ()
  require("mini.pairs").setup()
end)

-- Create/change/delete surrounding delimiter pairs.
later(function ()
  require("mini.surround").setup({
    -- Similar to vim-surround
    mappings = { add = "s", delete = "ds", find = "", find_left = "", replace = "cs" },
    -- Place surroundings on separate lines in linewise mode.
    -- Place surroundings on each line in blockwise mode.
    respect_selection_type = true,
  })
  -- Make special mapping for "add surrounding for line"
  vim.keymap.set("n", "ss", "s_", { remap = true })
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

-- TODO: Delete between commas should act on a single line
-- TODO: Missing textobjs: subword, url, filepath
-- TODO: Use approach in https://github.com/nvim-mini/mini.nvim/issues/387 for
-- swapping
later(function ()
  require("mini.ai").setup({
    custom_textobjects = {
      i = require("mini.extra").gen_ai_spec.indent(),
    },
    mappings = {
      -- Unset these mappings as they override default neovim's incremental selection mappings
      around_next = "",
      inside_next = "",
      around_last = "",
      inside_last = "",
    },
    -- prev/next matches take priority over enclosing surroundings which I find unintuitive.
    search_method = "cover",
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

-- Move 'up' or 'down' without changing the cursor column.
-- "https://github.com/vim-utils/vim-vertical-move",

-- Simple alignment operator.
vim.pack.add({ "https://github.com/tommcdo/vim-lion" }, { confirm = false })

-- Sets 'commentstring' based on the cursor location in a file.
later(function ()
  vim.pack.add({ "https://github.com/folke/ts-comments.nvim" }, { confirm = false })
end)

later(function ()
  vim.g.user_emmet_leader_key = "<c-,>"
  vim.g.user_emmet_expandabbr_key = "<c-,><c-,>"
  vim.g.user_emmet_mode = "i"
  vim.pack.add({ "https://github.com/mattn/emmet-vim" }, { confirm = false })
end)

-- Navigate code with search labels, enhanced character motions and treesitter integration.
later(function ()
  vim.pack.add({
    {
      src = "https://github.com/folke/flash.nvim",
      version = "c92888d432bebeb145dad09c07ab65cc7c577184",
    },
  },
    {
      confirm = false,
    })
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

-- Preserves extmarks and folds
-- Fixes bad-behaving LSP formatters
-- Enables range formatting for all formatters
-- Formats embedded code blocks
later(function ()
  vim.pack.add({ "https://github.com/stevearc/conform.nvim" }, { confirm = false })
  require("conform").setup({
    formatters_by_ft = {
      http = { "kulala-fmt" },
      python = { "isort", "black" },
      sh = { "shfmt" },
      fish = { "fish_indent" },
    },
    format_on_save = { timeout_ms = 500, lsp_format = "fallback" },
  })
  vim.o.formatexpr = require("conform").formatexpr
end)
