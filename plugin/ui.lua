-- Wrapped lines have the same indentation level as the beginning of that line.
vim.o.breakindent = true

-- String to show at the start of wrapped lines.
vim.o.showbreak = "↪ "

-- Do not conceal text.
vim.o.conceallevel = 0

-- Always show signs column.
vim.o.signcolumn = "yes"

-- Default border style of floating windows.
vim.o.winborder = "single"

-- Do not show search count message when searching. Custom statusline shows it.
vim.opt.shortmess:append("S")

-- Do not display custom text in fold lines.
vim.o.foldtext = ""
-- Indentation defines fold levels.
vim.o.foldmethod = "indent"
-- Show nothing folded by default.
vim.o.foldlevel = 99
-- Close folds even for single lines.
vim.o.foldminlines = 0

-- Various UI filler characters.
vim.opt.fillchars = {
  -- Do not show characters for deleted lines in diffs. Highlighting is enough.
  diff = " ",
}

-- Characters to show in 'list' mode.
vim.opt.listchars = {
  -- End of line.
  eol = "¬",
  -- Tabs.
  tab = "»·",
  -- Trailing whitespace.
  trail = ".",
}

-- Cursor styles for each mode.
vim.opt.guicursor = {
  -- Normal, visual, command-line normal: block
  "n-v-c-sm:block",
  -- Insert, command-line insert: vertical bar (i-beam)
  "i-ci-ve:ver25",
  -- Replace, command-line replace, operator pending: horizontal bar
  "r-cr-o:hor20",
  -- Terminal: block (with TermCursor highlight)
  "t:block-TermCursor",
}

-- Visual settings for diff mode.
vim.opt.diffopt:append({
  -- Do not show the 'foldcolumn'.
  "foldcolumn:0",
  -- Ignore all whitespace changes.
  "iwhiteall",
  -- Start diff mode in vertical splits.
  "vertical",
  -- Use the "patience" diff algorithm.
  "algorithm:patience",
  -- Not sure.
  "linematch:60",
  -- Highlight character-wise diffs.
  "inline:char",
})

-- `:help CTRL-L-default`
vim.keymap.set(
  { "n" },
  -- `<c-l>` was remapped so we need a new one.
  "<a-i>",
  --- Use normal! <c-l> to prevent inserting raw <c-l> when using i_<c-o>. #17473
  "<cmd>nohlsearch<bar>diffupdate<bar>normal! <c-l><cr>",
  { desc = "Redraw screen, clear search highlights, and update diffs." }
)

vim.keymap.set({ "n" }, "<c-k>", "<cmd>wincmd k<cr>", {
  silent = true,
  desc = "Move cursor to window above",
})

vim.keymap.set({ "n" }, "<c-j>", "<cmd>wincmd j<cr>", {
  silent = true,
  desc = "Move cursor to window below",
})

vim.keymap.set({ "n" }, "<c-l>", "<cmd>wincmd l<cr>", {
  silent = true,
  desc = "Move cursor to window right",
})

vim.keymap.set({ "n" }, "<c-h>", "<cmd>wincmd h<cr>", {
  silent = true,
  desc = "Move cursor to window left",
})

vim.keymap.set({ "n" }, "]<tab>", "<cmd>tabnext<cr>", {
  silent = true,
  desc = "Go to the next tabpage",
})

vim.keymap.set({ "n" }, "[<tab>", "<cmd>tabprevious<cr>", {
  silent = true,
  desc = "Go to the previous tabpage",
})

-- Various UI toggles
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

  vim.keymap.set({ "n" }, "<leader>ui", function ()
    vim.wo.list = toggle_option(vim.wo.list, { true, false })
  end, { desc = "Toggle 'list' option" }
  )

  vim.keymap.set({ "n" }, "<leader>un", function ()
    vim.wo.number = toggle_option(vim.wo.number, { true, false })
  end, { desc = "Toggle 'number' option" }
  )

  vim.keymap.set({ "n" }, "<leader>uw", function ()
    vim.wo.wrap = toggle_option(vim.wo.wrap, { true, false })
  end, { desc = "Toggle 'wrap' option" }
  )

  vim.keymap.set({ "n" }, "<leader>ud", function ()
    vim.cmd(vim.wo.diff and "diffoff" or "diffthis")
  end, { desc = "Toggle diff mode" }
  )

  vim.keymap.set({ "n" }, "<leader>ul", function ()
    vim.cmd(vim.fn.getloclist(0, { winid = true }).winid ~= 0 and "lclose" or "lopen")
    vim.cmd.wincmd("p")
  end, { desc = "Toggle location list" }
  )

  vim.keymap.set({ "n" }, "<leader>uq", function ()
    vim.cmd(vim.fn.getqflist({ winid = true }).winid ~= 0 and "cclose" or "copen")
    vim.cmd.wincmd("p")
  end, { desc = "Toggle quickfix list" }
  )
end

-- Diagnostics are errors or warnings from external tools displayed in the UI.
vim.diagnostic.config({
  float = { source = true },
  jump = {
    wrap = false,
    severity = { min = vim.diagnostic.severity.HINT },
    on_jump = function (_, bufnr)
      vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
    end,
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = " ",
      [vim.diagnostic.severity.WARN] = " ",
      [vim.diagnostic.severity.INFO] = " ",
      [vim.diagnostic.severity.HINT] = " ",
    },
  },
})

-- Icon provider. Used by other plugins to render icons.
now(function ()
  require("mini.icons").setup()
end)

-- Statusline. See |statusline| and |mini.statusline|.
now(function ()
  require("mini.statusline").setup({
    content = {
      active = function ()
        local statusline = require("mini.statusline")
        local mode, mode_hl = statusline.section_mode({ trunc_width = 120 })
        local searchcount = statusline.section_searchcount({ trunc_width = 75 })
        if searchcount ~= "" then
          searchcount = "󱎸 " .. searchcount
        end
        return statusline.combine_groups({
          { hl = mode_hl, strings = { mode } },
          "%<", -- Mark general truncate point
          {
            hl = "MiniStatuslineFilename",
            strings = {
              require("mini.icons").get("filetype", vim.bo.filetype),
              statusline.section_filename({ trunc_width = 140 }),
            },
          },
          "%=", -- End left alignment
          { hl = mode_hl, strings = { searchcount } },
        })
      end,
      inactive = function ()
        local statusline = require("mini.statusline")
        return statusline.combine_groups({
          {
            hl = "MiniStatuslineFilename",
            strings = {
              require("mini.icons").get("filetype", vim.bo.filetype),
              statusline.section_filename({ trunc_width = 140 }),
            },
          },
        })
      end,
    },
  })
  vim.api.nvim_set_hl(0, "MiniStatuslineFilename", { bold = true })
end)

-- File explorer.
now(function ()
  require("mini.files").setup()
  -- https://github.com/nvim-mini/mini.nvim/discussions/2173
end)

-- Find and replace.
later(function ()
  vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" }, { confirm = false })

  require("grug-far").setup({
    normalModeSearch = true,
    startInInsertMode = false,
    helpLine = { enabled = false },
    showCompactInputs = true,
    showInputsTopPadding = false,
    showStatusIcon = false,
    resultsSeparatorLineChar = " ",
    icons = {
      searchInput = "",
      replaceInput = "",
      filesFilterInput = "",
      flagsInput = "",
      pathsInput = "",
    },
    folding = {
      foldcolumn = "0",
    },
    resultLocation = {
      showNumberLabel = false,
    },
  })

  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "grug-far" },
    callback = function ()
      vim.wo.signcolumn = "no"
      vim.api.nvim_set_hl(0, "GrugFarResultsPath", { link = "Directory" })
    end,
  })

  vim.keymap.set("n", "<leader>r", function ()
    require("grug-far").open({ prefills = { paths = vim.b.dir } })
  end, { noremap = true, desc = "Open search and replace" }
  )
end)

-- Undo tree visualizer.
later(function ()
  vim.pack.add({ "https://github.com/mbbill/undotree" }, { confirm = false })
  vim.g.undotree_DiffAutoOpen = 0
  vim.g.undotree_SetFocusWhenToggle = 1
  vim.g.undotree_SplitWidth = 40
  vim.keymap.set({ "n" }, "<leader>uu", vim.cmd.UndotreeToggle, {
    silent = true,
    desc = "Toggle Undotree",
  })
end)

-- Tabpage interface for cycling through diffs.
later(function ()
  vim.pack.add({ "https://github.com/dlyongemallo/diffview-plus.nvim" }, {
    confirm = false,
  })
end)

-- Show next key clues in a popup window. Useful for discovery of key mappings.
later(function ()
  local miniclue = require("mini.clue")
  miniclue.setup({
    -- These keys trigger the clue window.
    triggers = {
      -- Leader triggers
      { mode = { "n", "x" }, keys = "<leader>" },
      { mode = { "n" }, keys = "<localleader>" },
      -- Built-in mapping groups
      { mode = { "n", "x" }, keys = "g" },
      { mode = { "n", "x" }, keys = "z" },
      { mode = { "n", "x" }, keys = "[" },
      { mode = { "n", "x" }, keys = "]" },
      -- Built-in completion
      { mode = { "i" }, keys = "<C-x>" },
      -- Registers
      { mode = { "n", "x" }, keys = '"' },
      { mode = { "i", "c" }, keys = "<c-r>" },
      -- Window commands
      { mode = { "n" }, keys = "<c-w>" },
    },
    -- Define which clues to show. User-defined mappings are picked
    -- automatically and don't need to be defined here.
    clues = {
      -- Built-in mappig groups
      miniclue.gen_clues.g(),
      miniclue.gen_clues.z(),
      miniclue.gen_clues.square_brackets(),
      -- Built-in completion
      miniclue.gen_clues.builtin_completion(),
      -- Registers
      miniclue.gen_clues.registers(),
      -- Window commands
      miniclue.gen_clues.windows(),
      -- Custom mappings
      { mode = { "n" }, keys = "<leader>d", desc = "+Diagnostics" },
      { mode = { "n" }, keys = "<leader>l", desc = "+LSP" },
      { mode = { "n" }, keys = "<leader>u", desc = "+UI" },
      { mode = { "n" }, keys = "<leader>k", desc = "+Snacks" },
      { mode = { "n" }, keys = "<leader>n", desc = "+Snippets" },
    },
    window = {
      config = { width = 60 },
    },
  })
end)

-- -- TODO: Copy some of the tweaks in zenbones to the default colorscheme
-- -- TODO: Check https://github.com/kyzabuilds/xeno.nvim
-- vim.g.zenbones_darkness = "stark"
-- vim.g.zenwritten_darkness = "stark"
--
-- vim.pack.add({
--   "https://github.com/rktjmp/lush.nvim",
--   "https://github.com/zenbones-theme/zenbones.nvim",
-- }, { confirm = false })
--
-- vim.api.nvim_create_autocmd({ "ColorScheme" }, {
--   desc = "Override zenbones colorscheme highlights",
--   pattern = { "zen*" },
--   callback = function ()
--     vim.api.nvim_set_hl(0, "Folded", {})
--     vim.api.nvim_set_hl(0, "Comment", { italic = false, update = true })
--     vim.api.nvim_set_hl(0, "FloatBorder", { link = "NormalFloat" })
--   end,
-- })
--
-- vim.cmd.colorscheme("zenbones")
