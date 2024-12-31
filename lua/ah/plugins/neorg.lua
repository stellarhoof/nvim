return {
  "https://github.com/nvim-neorg/neorg",
  enabled = false,
  version = "*",
  opts = {
    ["core.defaults"] = {},

    -- -- https://github.com/nvim-neorg/neorg/wiki/Indent
    -- ["core.esupports.indent"] = {},
    --
    -- -- Automatically inserts prefix character in iterable items like lists.
    -- -- https://github.com/nvim-neorg/neorg/wiki/Itero
    -- ["core.itero"] = {
    --   config = {
    --     iterables = {
    --       "unordered_list%d",
    --       "ordered_list%d",
    --       "quote%d",
    --     },
    --   },
    -- },
    --
    -- -- Increase/decrease indentation level for various neorg objects.
    -- -- https://github.com/nvim-neorg/neorg/wiki/Promo
    -- ["core.promo"] = {},
    --
    -- -- Toggle between ordered/unordered lists.
    -- -- https://github.com/nvim-neorg/neorg/wiki/Pivot
    -- ["core.pivot"] = {},
    --
    -- -- Edit code block in a dedicated buffer.
    -- -- https://github.com/nvim-neorg/neorg/wiki/Looking-Glass
    -- ["core.looking-glass"] = {},

    -- Display markup as icons instead of text.
    -- https://github.com/nvim-neorg/neorg/wiki/Concealer
    ["core.concealer"] = {
      config = {
        -- folds = false,
        init_open_folds = "never",
      },
    },

    -- Manages directories of .norg files.
    ["core.dirman"] = {
      config = {
        workspaces = {
          notes = "~/Notes",
        },
      },
    },
  },
  config = function(_, opts)
    require("neorg").setup({ load = opts })
    G.au({ "FileType" }, {
      pattern = "norg",
      callback = function()
        -- https://github.com/nvim-neorg/neorg/issues/857
        -- Probably a better solution is to change the value of the 'comment'
        -- option
        vim.opt_local.formatoptions:remove("r")
        G.unmap("n", "<cr>", { buffer = true })
        -- G.imap(
        --   "<cr>",
        --   "<plug>(neorg.itero.next-iteration)",
        --   { buffer = true, desc = "[neorg] Continue Iterable Object" }
        -- )
        -- G.nmap(
        --   "<<",
        --   "<plug>(neorg.promo.demote.nested)",
        --   { buffer = true, desc = "[neorg] Dedent object recursively" }
        -- )
        -- G.vmap(
        --   "<",
        --   "<plug>(neorg.promo.demote.range)",
        --   { buffer = true, desc = "[neorg] Dedent object recursively" }
        -- )
        -- G.nmap(
        --   ">>",
        --   "<plug>(neorg.promo.promote.nested)",
        --   { buffer = true, desc = "[neorg] Indent object recursively" }
        -- )
        -- G.vmap(
        --   ">",
        --   "<plug>(neorg.promo.promote.range)",
        --   { buffer = true, desc = "[neorg] Indent object recursively" }
        -- )
        -- G.nmap(
        --   "<localleader>ng",
        --   "<plug>(neorg.looking-glass.magnify-code-block)",
        --   { buffer = true, desc = "[neorg] Magnify Code Block" }
        -- )
        -- G.nmap(
        --   "<localleader>nt",
        --   "<plug>(neorg.pivot.toggle-list-type)",
        --   { buffer = true, desc = "[neorg] Toggle (Un)ordered List" }
        -- )
      end,
    })
  end,
}
