now(function()
  vim.pack.add({
    -- Move 'up' or 'down' without changing the cursor column.
    "https://github.com/vim-utils/vim-vertical-move",
    -- Quickstart configs for Nvim LSP.
    "https://github.com/neovim/nvim-lspconfig",
    -- Enable repeating supported plugin maps with "."
    "https://github.com/tpope/vim-repeat",
    -- Sets 'commentstring' based on the cursor location in a file.
    "https://github.com/folke/ts-comments.nvim",
    -- A simple alignment operator
    "https://github.com/tommcdo/vim-lion",
    -- Auto insert pairs of delimiters.
    "https://github.com/windwp/nvim-autopairs", -- InsertEnter
    -- Handle line and column numbers in file names.
    "https://github.com/wsdjeg/vim-fetch",
    -- A vim plugin to perform diffs on blocks of code
    "https://github.com/AndrewRadev/linediff.vim",
    -- Integration for https://pi.dev, the minimal coding agent
    "https://github.com/pablopunk/pi.nvim",
    -- Extra commands on top of vtsls. See `after/lsp/vtsls.lua`
    "https://github.com/yioneko/nvim-vtsls",
    "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/konfekt/vim-alias",
    -- Pairs of handy bracket mappings
    "https://github.com/tpope/vim-unimpaired",
    -- Close and rename html/jsx elements with the power of treesitter
    "https://github.com/tronikelis/ts-autotag.nvim",
    -- Add/change/delete surrounding delimiter pairs with ease.
    "https://github.com/kylechui/nvim-surround",
    -- Lightweight yet powerful formatter plugin for Neovim
    "https://github.com/stevearc/conform.nvim",
    -- Single tabpage interface for easily cycling through diffs for all
    -- modified files for any git rev
    "https://github.com/dlyongemallo/diffview-plus.nvim",
  }, { confirm = false })

  vim.cmd.Alias({ args = { "w", "up" }, bang = true })
  vim.cmd.Alias({ args = { "man", "Man" }, bang = true })
  vim.cmd.Alias({ args = { "dt", "DiffviewToggle" } })

  vim.keymap.set("n", "co", "<plug>(unimpaired-toggle)")

  require("nvim-autopairs").setup({})

  require("conform").setup({
    formatters_by_ft = {
      -- sh = { "shfmt" },
      nix = { "nixfmt" },
      lua = { "stylua" },
      python = { "isort", "black" },
      markdown = { "prettierd" },
      html = { "prettierd" },
      http = { "kulala-fmt" },
      svg = { "prettierd" },
      json = { "oxfmt", "prettierd" },
      jsonc = { "oxfmt", "prettierd" },
      javascript = { "oxfmt", "prettierd" },
      javascriptreact = { "oxfmt", "prettierd" },
      typescript = { "oxfmt", "prettierd" },
      typescriptreact = { "oxfmt", "prettierd" },
    },
    format_on_save = {},
    default_format_opts = { stop_after_first = true },
  })
end)
