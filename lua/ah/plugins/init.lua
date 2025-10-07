-- Colorscheme plugins
local colorschemes = {
  {
    "https://github.com/mcchrish/zenbones.nvim",
    priority = 1000,
    dependencies = { "https://github.com/rktjmp/lush.nvim" },
    config = function()
      vim.api.nvim_create_autocmd({ "ColorScheme" }, {
        pattern = "zen*",
        desc = "Override zenbones colorscheme highlights",
        callback = function()
          G.hl_update("Constant", { italic = false })
          G.hl_link("FloatBorder", "NormalFloat")
          G.hl_link("FloatTitle", "NormalFloat", { bold = true })
        end,
      })
    end,
  },
}

-- Plugins that provide motions and/or movements
local motions = {
  -- Move 'up' or 'down' without changing the cursor column.
  {
    "https://github.com/vim-utils/vim-vertical-move",
  },

  -- Pairs of handy bracket mappings
  {
    "https://github.com/tpope/vim-unimpaired",
    event = "VeryLazy",
    config = function()
      G.nmap("co", "<plug>(unimpaired-toggle)")
    end,
  },
}

-- Plugins that extend neovim's editing capabilities
local editing = {
  -- Enable repeating supported plugin maps with "."
  {
    "https://github.com/tpope/vim-repeat",
  },

  -- Sets 'commentstring' based on the cursor location in a file.
  {
    "https://github.com/folke/ts-comments.nvim",
    opts = {},
  },

  -- Close and rename html/jsx elements with the power of treesitter
  {
    "https://github.com/tronikelis/ts-autotag.nvim",
    opts = {},
    event = "VeryLazy",
  },

  -- A simple alignment operator
  {
    "https://github.com/tommcdo/vim-lion",
  },

  -- Auto insert pairs of delimiters.
  {
    "https://github.com/windwp/nvim-autopairs",
    event = "InsertEnter",
    opts = {},
  },

  -- Add/change/delete surrounding delimiter pairs with ease.
  {
    "https://github.com/kylechui/nvim-surround",
    event = "VeryLazy",
    opts = {
      -- https://github.com/ggandor/leap.nvim/discussions/59#discussioncomment-3943323
      -- If the key ends in "_line", the delimiter pair is added on new lines.
      -- If the key ends in "_cur", the surround is performed around the current line.
      keymaps = {
        insert = "<C-g>s",
        insert_line = "<C-g>S",
        normal = "s",
        normal_cur = "ss",
        normal_line = "S",
        normal_cur_line = "SS",
        visual = "s",
        visual_line = "S",
        delete = "ds",
        change = "cs",
      },
      aliases = {
        ["0"] = ")",
        ["9"] = "(",
      },
    },
  },

  -- Reorder delimited items.
  {
    "https://github.com/machakann/vim-swap",
    init = function()
      vim.g.swap_no_default_key_mappings = 1
    end,
    config = function()
      G.nmap("g<", "<plug>(swap-prev)")
      G.nmap("g>", "<plug>(swap-next)")
      G.omap("i,", "<plug>(swap-textobject-i)")
      G.xmap("i,", "<plug>(swap-textobject-i)")
      G.omap("a,", "<plug>(swap-textobject-a)")
      G.xmap("a,", "<plug>(swap-textobject-a)")
    end,
  },

  -- Bundle of two dozen new text objects for Neovim.
  {
    "https://github.com/chrisgrieser/nvim-various-textobjs",
    config = function()
      local textobj = require("various-textobjs")

      -- Surrounding lines with same or higher indentation
      G.map({ "o", "x" }, "ii", function()
        textobj.indentation("inner", "inner")
      end, { desc = "inner indented block" })
      G.map({ "o", "x" }, "ai", function()
        textobj.indentation("outer", "outer")
      end, { desc = "outer indented block" })

      -- Like iw, but treating -, _, and . as word delimiters and only part of camelCase
      G.map({ "o", "x" }, "iv", function()
        textobj.subword("inner")
      end, { desc = "inner subword" })
      G.map({ "o", "x" }, "av", function()
        textobj.subword("outer")
      end, { desc = "outer subword" })

      -- Between any unescaped ", ', or ` in a line
      G.map({ "o", "x" }, "iq", function()
        textobj.anyQuote("inner")
      end, { desc = "inner quote in a line" })
      G.map({ "o", "x" }, "aq", function()
        textobj.anyQuote("outer")
      end, { desc = "outer quote in a line" })
    end,
  },

  -- Operators to substitute and exchange text.
  -- Lua version of
  --  https://github.com/svermeulen/vim-subversive
  --  https://github.com/tommcdo/vim-exchange
  {
    "https://github.com/gbprod/substitute.nvim",
    opts = {
      highlight_substituted_text = {
        enabled = false,
      },
    },
    config = function(_, opts)
      require("substitute").setup(opts)

      G.nmap("gs", require("substitute").operator, {
        noremap = true,
        desc = "Substitute text object with contents of default register",
      })
      G.nmap("gss", require("substitute").line, {
        noremap = true,
        desc = "Substitute line with contents of default register",
      })
      G.nmap("gS", require("substitute").eol, {
        noremap = true,
        desc = "Substitute up to EOL with contents of default register",
      })
      G.xmap("gs", require("substitute").visual, {
        noremap = true,
        desc = "Substitute visual selection with contents of default register",
      })
      G.nmap("ge", require("substitute.exchange").operator, {
        noremap = true,
        desc = "Exchange with text object",
      })
      G.nmap("gee", require("substitute.exchange").line, {
        noremap = true,
        desc = "Exchange with line",
      })
      G.nmap("gE", require("substitute.exchange").cancel, {
        noremap = true,
        desc = "Exchange up to EOL",
      })
      G.xmap("ge", require("substitute.exchange").visual, {
        noremap = true,
        desc = "Exchange with visual selection",
      })
    end,
  },

  -- Readline motions and deletions in Neovim.
  {
    "https://github.com/sysedwinistrator/readline.nvim",
    config = function()
      local readline = require("readline")

      -- Move word
      G.map({ "i", "c" }, "<m-f>", readline.forward_word, { desc = "Forward word" })
      G.map({ "i", "c" }, "<m-b>", readline.backward_word, { desc = "Backward word" })

      -- Move line
      G.map({ "i", "c" }, "<c-a>", readline.beginning_of_line, { desc = "Beginning of line" })
      G.map({ "i", "c" }, "<c-e>", readline.end_of_line, { desc = "End of line" })

      -- Edit char
      G.map({ "i", "c" }, "<c-d>", "<delete>", { desc = "Forward Delete char" })
      G.map({ "i", "c" }, "<c-h>", "<bs>", { desc = "Backward delete char" })

      -- Edit word
      G.map({ "i", "c" }, "<m-d>", readline.kill_word, { desc = "Forward kill word" })
      G.map({ "i", "c" }, "<m-bs>", readline.backward_kill_word, { desc = "Backward kill word" })

      -- Edit line
      G.map({ "i", "c" }, "<c-k>", readline.kill_line, { desc = "Forward kill line" })
      G.map({ "i", "c" }, "<c-u>", readline.backward_kill_line, { desc = "Backward kill line" })
    end,
  },
}

-- Plugins that enhance neovim's ui or provide ui components
local ui = {
  -- Extensible UI for Neovim notifications and LSP progress messages.
  {
    "https://github.com/j-hui/fidget.nvim",
    opts = {
      progress = {
        display = {
          done_icon = " ",
          icon_style = "Normal",
          overrides = {
            overseer = {
              ttl = 10,
              debug_style = "Constant",
              info_style = "Constant",
              warn_style = "Constant",
              error_style = "Constant",
              icon = function(now, items)
                for _, item in ipairs(items) do
                  local icon = item.data.icon
                  return type(icon) == "string" and icon or icon(now, items)
                end
              end,
              states = { CANCELED = { icon = "󰜺 " }, FAILURE = { icon = " " } },
            },
          },
        },
      },
      notification = {
        override_vim_notify = true,
        window = { normal_hl = "Comment", winblend = 0 },
      },
    },
  },

  -- A vim plugin to perform diffs on blocks of code
  {
    "https://github.com/AndrewRadev/linediff.vim",
    cmd = "Linediff",
  },

  -- File type icons
  {
    "https://github.com/nvim-tree/nvim-web-devicons",
    lazy = true,
    -- enabled = false,
    opts = { color_icons = false, default = true },
  },

  -- Easily create and edit VSCode style snippets
  {
    "https://github.com/chrisgrieser/nvim-scissors",
    opts = {
      jsonFormatter = "jq",
      backdrop = { enabled = false },
      snippetSelection = { picker = "telescope" },
      icons = { scissors = "" },
    },
    config = function(_, opts)
      require("scissors").setup(opts)
      G.nmap("<leader>ne", require("scissors").editSnippet, { desc = "Edit snippet" })
      G.nmap("<leader>na", require("scissors").addNewSnippet, { desc = "Add snippet" })
      -- Prefill selection as the snippet body.
      G.xmap("<leader>na", require("scissors").addNewSnippet, { desc = "Add snippet" })
    end,
  },

  -- Displays popup with possible keybindings of the command you started typing.
  {
    "https://github.com/folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      delay = 500,
      icons = {
        mappings = false,
      },
      plugins = {
        marks = false,
        registers = false,
      },
    },
    config = function(_, opts)
      require("which-key").setup(opts)
      require("which-key").add({
        { "<leader>d", group = "Diagnostics" },
        { "<leader>l", group = "LSP" },
        { "<leader>u", group = "UI" },
      })
    end,
  },

  -- The undo history visualizer for VIM
  {
    "https://github.com/mbbill/undotree",
    keys = {
      {
        "<leader>uu",
        vim.cmd.UndotreeToggle,
        silent = true,
        desc = "Toggle UndoTree",
      },
    },
    config = function()
      vim.g.undotree_DiffAutoOpen = 0
      vim.g.undotree_SetFocusWhenToggle = 1
      vim.g.undotree_SplitWidth = 40
    end,
  },
}

-- Plugins that interact with external tools
local external = {
  -- Easily install and manage LSP servers, DAP servers, linters, and formatters.
  {
    "https://github.com/williamboman/mason.nvim",
    opts = {},
  },

  -- Automatically install and upgrade third party tools.
  {
    "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim",
    cmd = { "MasonToolsInstall", "MasonToolsInstallSync" },
    opts = {
      ensure_installed = {
        -- LSP
        "eslint-lsp",
        "lua-language-server",
        "tailwindcss-language-server",
        "vtsls",
        -- Formatters
        "prettierd",
        "stylua",
        "shfmt",
        "isort",
        "black",
        "jq",
        -- DAP
        "js-debug-adapter",
      },
    },
  },

  -- Lightweight yet powerful formatter plugin for Neovim
  {
    "https://github.com/stevearc/conform.nvim",
    event = "VeryLazy",
    opts = {
      formatters = {
        kulala = {
          command = "kulala-fmt",
          args = { "$FILENAME" },
          stdin = false,
        },
      },
      formatters_by_ft = {
        -- sh = { "shfmt" },
        nix = { "nixfmt" },
        lua = { "stylua" },
        python = { "isort", "black" },
        markdown = { "prettierd" },
        html = { "prettierd" },
        http = { "kulala" },
        svg = { "prettierd" },
        json = { "biome-check", "prettierd" },
        jsonc = { "biome-check", "prettierd" },
        javascript = { "biome-check", "prettierd" },
        javascriptreact = { "biome-check", "prettierd" },
        typescript = { "biome-check", "prettierd" },
        typescriptreact = { "biome-check", "prettierd" },
      },
      default_format_opts = {
        stop_after_first = true,
      },
      format_on_save = {
        timeout_ms = 500,
        lsp_fallback = false,
      },
      format_after_save = {
        lsp_fallback = false,
      },
    },
  },

  -- A fast Neovim http client written in Lua.
  {
    "https://github.com/mistweaverco/kulala.nvim",
    ft = { "http" },
    opts = {
      default_env = "dev",
      kulala_keymaps = false,
      formatters = {
        json = { "jq", "." },
        xml = { "xmllint", "--format", "-" },
        html = { "xmllint", "--format", "--html", "-" },
      },
      ui = {
        max_response_size = 1024000,
      },
    },
    config = function(_, opts)
      require("kulala").setup(opts)
      vim.api.nvim_create_autocmd("FileType", {
        pattern = "http",
        callback = function()
          G.nmap(
            "<localleader>r",
            require("kulala").run,
            { noremap = true, buffer = true, desc = "Run request under the cursor" }
          )
        end,
      })
    end,
  },

  -- AI-powered coding, seamlessly in Neovim
  {
    "https://github.com/olimorris/codecompanion.nvim",
    dependencies = {
      {
        "https://github.com/ravitemer/codecompanion-history.nvim",
      },
    },
    opts = {
      extensions = {
        history = {
          enabled = true,
        },
      },
    },
    keys = {
      {
        modes = { "n", "v" },
        "<leader>ca",
        function()
          require("codecompanion").actions()
        end,
        { noremap = true, silent = true },
      },
      {
        modes = { "n", "v" },
        "<leader>ct",
        function()
          require("codecompanion").toggle()
        end,
        { noremap = true, silent = true },
      },
      {
        modes = { "v" },
        "ga",
        function()
          require("codecompanion").add()
        end,
        { noremap = true, silent = true },
      },
    },
  },
}

local other = {
  {
    "https://github.com/neovim/nvim-lspconfig",
  },
  -- Extra commands on top of vtsls. See `after/lsp/vtsls.lua`
  {
    "https://github.com/yioneko/nvim-vtsls",
  },
  {
    "https://github.com/folke/lazydev.nvim",
    ft = "lua",
    opts = {
      library = {
        -- See the configuration section for more details
        -- Load luvit types when the `vim.uv` word is found
        { path = "${3rd}/luv/library", words = { "vim%.uv" } },
      },
      enabled = function(root_dir)
        -- Disable when a .luarc.json file is found
        return not vim.uv.fs_stat(root_dir .. "/.luarc.json")
      end,
    },
  },
  {
    "https://github.com/sindrets/diffview.nvim",
  },
}

return {
  {
    "https://github.com/nvim-lua/plenary.nvim",
    priority = 1000,
  },

  {
    "https://github.com/konfekt/vim-alias",
    priority = 1000,
    config = function()
      local alias = vim.cmd.Alias
      alias({ args = { "w", "up" }, bang = true })
      alias({ args = { "man", "Man" }, bang = true })
    end,
  },

  colorschemes,
  motions,
  editing,
  ui,
  external,
  other,
}
