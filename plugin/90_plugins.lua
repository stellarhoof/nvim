now(function()
  vim.pack.add({
    -- Move 'up' or 'down' without changing the cursor column.
    -- "https://github.com/vim-utils/vim-vertical-move",

    -- Quickstart configs for neovim's native lsp.
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
    -- TODO: Check https://github.com/monkeymonk/prompt.nvim
    -- TODO: Check https://github.com/dabstractor/pi-nvim-bridge
    "https://github.com/pablopunk/pi.nvim",

    -- Extra commands on top of vtsls. See `after/lsp/vtsls.lua`
    "https://github.com/yioneko/nvim-vtsls",

    -- "https://github.com/nvim-lua/plenary.nvim",
    "https://github.com/konfekt/vim-alias",
    "https://github.com/machakann/vim-swap",

    -- Close and rename html/jsx elements with the power of treesitter
    "https://github.com/tronikelis/ts-autotag.nvim",
    -- Add/change/delete surrounding delimiter pairs with ease.
    "https://github.com/kylechui/nvim-surround",
    "https://github.com/mbbill/undotree",

    -- Git stuff
    "https://github.com/tpope/vim-fugitive",
    "https://github.com/tpope/vim-rhubarb",
    "https://github.com/dlyongemallo/diffview-plus.nvim",
  }, { confirm = false })

  vim.cmd.Alias({ args = { "w", "up" }, bang = true })
  vim.cmd.Alias({ args = { "g", "G" } })
  vim.cmd.Alias({ args = { "gbl", "Git blame -w -M" } })
  vim.cmd.Alias({ args = { "gbr", "GBrowse" } })
  vim.cmd.Alias({ args = { "gd", "Gdiffsplit" } })
  vim.cmd.Alias({ args = { "ge", "Gedit" } })
  vim.cmd.Alias({ args = { "gr", "Gread" } })
  vim.cmd.Alias({ args = { "gs", "Git" } })
  vim.cmd.Alias({ args = { "gw", "Gwrite" } })
  vim.cmd.Alias({ args = { "gg", "Ggrep" } })
  vim.cmd.Alias({ args = { "gco", "Git checkout" } })
  vim.cmd.Alias({ args = { "gcm", "Git commit" } })
  vim.cmd.Alias({ args = { "gcma", "Git commit --amend" } })
  vim.cmd.Alias({ args = { "gcman", "Git commit --amend --reuse-message HEAD" } })

  require("nvim-autopairs").setup({})

  vim.g.undotree_DiffAutoOpen = 0
  vim.g.undotree_SetFocusWhenToggle = 1
  vim.g.undotree_SplitWidth = 40

  vim.keymap.set(
    { "n" },
    "<leader>uu",
    vim.cmd.UndotreeToggle,
    { silent = true, desc = "Toggle UndoTree" }
  )

  vim.keymap.set(
    { "n" },
    "<leader>uv",
    vim.cmd.DiffviewToggle,
    { silent = true, desc = "Toggle Diffview" }
  )

  vim.g.swap_no_default_key_mappings = 1
  vim.keymap.set({ "n" }, "g<", "<plug>(swap-prev)")
  vim.keymap.set({ "n" }, "g>", "<plug>(swap-next)")
  vim.keymap.set({ "o" }, "i,", "<plug>(swap-textobject-i)")
  vim.keymap.set({ "x" }, "i,", "<plug>(swap-textobject-i)")
  vim.keymap.set({ "o" }, "a,", "<plug>(swap-textobject-a)")
  vim.keymap.set({ "x" }, "a,", "<plug>(swap-textobject-a)")

  -- require("lazydev").setup({
  --   library = {
  --     -- See the configuration section for more details
  --     -- Load luvit types when the `vim.uv` word is found
  --     { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  --   },
  --   enabled = function(root_dir)
  --     -- Disable when a .luarc.json file is found
  --     return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
  --   end,
  -- })
end)
