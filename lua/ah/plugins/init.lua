-- Colorscheme plugins
local colorschemes = {
  {
    "https://github.com/mcchrish/zenbones.nvim",
    priority = 1000,
    dependencies = { "https://github.com/rktjmp/lush.nvim" },
    config = function()
      vim.g.zenbones = { italic_comments = false }
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

  {
    "https://github.com/ThePrimeagen/refactoring.nvim",
    opts = {},
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

  {
    "https://github.com/echasnovski/mini.icons",
    version = false,
    opts = {},
    config = function(_, opts)
      require("mini.icons").setup(opts)
      G.hl_link("MiniIconsAzure", "Normal")
      G.hl_link("MiniIconsBlue", "Normal")
      G.hl_link("MiniIconsCyan", "Normal")
      G.hl_link("MiniIconsGreen", "Normal")
      G.hl_link("MiniIconsGrey", "Normal")
      G.hl_link("MiniIconsOrange", "Normal")
      G.hl_link("MiniIconsPurple", "Normal")
      G.hl_link("MiniIconsRed", "Normal")
      G.hl_link("MiniIconsYellow", "Normal")
    end,
  },

  -- Neovim plugin to improve the default vim.ui interfaces.
  {
    "https://github.com/stevearc/dressing.nvim",
    event = "VeryLazy",
    opts = {
      input = {
        title_pos = "center",
        border = "single",
      },
      select = {
        get_config = function(opts)
          if opts.kind == "codeaction" or opts.kind == "snippets" then
            return {
              backend = "nui",
              nui = {
                relative = "cursor",
                position = { row = 1, col = 0 },
                border = { style = "single" },
              },
            }
          end
          return { backend = "fzf_lua" }
        end,
      },
    },
    config = function(_, opts)
      require("dressing").setup(opts)
      G.au({ "FileType" }, {
        pattern = "DressingSelect",
        callback = function(evt)
          G.nmap("q", "<cmd>q<cr>", { buffer = evt.buf })
        end,
      })
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

  -- A high-performance color highlighter with no external dependencies.
  {
    "https://github.com/NvChad/nvim-colorizer.lua",
    cmd = { "ColorizerToggle" },
    opts = {
      filetypes = {},
      user_default_options = { names = false, hsl_fn = true, rgb_fn = true },
    },
  },

  -- Capture and show any messages in a customisable (floating) buffer.
  {
    "https://github.com/AckslD/messages.nvim",
    opts = {
      post_open_float = function()
        G.nmap("q", "<cmd>q<cr>", { buffer = true })
      end,
    },
    config = function(_, opts)
      require("messages").setup(opts)
      local alias = vim.cmd.Alias
      alias({ args = { "ms", "Messages" } })
      alias({ args = { "mess", "Messages" } })
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

  -- -- Neovim file explorer: edit your filesystem like a buffer
  -- {
  --   "https://github.com/stevearc/oil.nvim",
  --   opts = {
  --     cleanup_delay_ms = false,
  --     view_options = { show_hidden = true },
  --     skip_confirm_for_simple_edits = true,
  --     -- :h |oil-config|
  --     keymaps = {
  --       ["<C-v>"] = false,
  --       ["<C-s>"] = false,
  --       ["<C-h>"] = false,
  --       ["<C-l>"] = false,
  --       ["<C-c>"] = false,
  --       ["~"] = false,
  --       ["gs"] = false,
  --       ["g\\"] = false,
  --     },
  --     win_options = {
  --       conceallevel = 0,
  --     },
  --     lsp_file_methods = {
  --       -- Time to wait for LSP file operations to complete before skipping
  --       timeout_ms = 2000,
  --       -- Set to true to autosave buffers that are updated with LSP willRenameFiles
  --       -- Set to "unmodified" to only save unmodified buffers
  --       autosave_changes = true,
  --     },
  --   },
  --   config = function(_, opts)
  --     require("oil").setup(opts)
  --     G.nmap("-", vim.cmd.Oil, { desc = "Open buffer directory" })
  --     G.au({ "FileType" }, {
  --       pattern = "oil",
  --       callback = function()
  --         vim.b.dir = require("oil").get_current_dir()
  --       end,
  --     })
  --   end,
  -- },
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
        -- "emmet-language-server",
        "vtsls", -- Prefer this one over typescript-language-server
        "typescript-language-server",
        -- Formatters
        "prettierd",
        "stylua",
        "shfmt",
        "isort",
        "black",
        "jq",
        -- DAP
        "js-debug-adapter",
        "chrome-debug-adapter",
      },
    },
  },

  -- A Git wrapper so awesome, it should be illegal.
  {
    "https://github.com/tpope/vim-fugitive",
    event = "VeryLazy",
    dependencies = { "https://github.com/tpope/vim-rhubarb" },
    config = function()
      local alias = vim.cmd.Alias
      alias({ args = { "g", "G" } })
      alias({ args = { "gbl", "Git blame -w -M" } })
      alias({ args = { "gd", "Gdiffsplit" } })
      alias({ args = { "ge", "Gedit" } })
      alias({ args = { "gr", "Gread" } })
      alias({ args = { "gs", "Git" } })
      alias({ args = { "gw", "Gwrite" } })
      alias({ args = { "gg", "Ggrep" } })
      alias({ args = { "gco", "Git checkout" } })
      alias({ args = { "gcm", "Git commit" } })
      alias({ args = { "gcma", "Git commit --amend" } })
      alias({ args = { "gcman", "Git commit --amend --reuse-message HEAD" } })

      local function cleanup_fugitive_windows()
        for _, winnr in pairs(vim.api.nvim_tabpage_list_wins(0)) do
          local bufnr = vim.fn.winbufnr(winnr)
          if vim.startswith(vim.fn.bufname(bufnr), "fugitive://") then
            vim.cmd.bdelete(bufnr)
          end
        end
      end

      local function diff_current_quickfix_entry()
        local qf = vim.fn.getqflist({ idx = 0, title = 0, context = 0 })
        if qf.idx and qf.context and qf.context.items and string.find(qf.title, "difftool") then
          local item = qf.context.items[qf.idx]
          if item and item.diff then
            cleanup_fugitive_windows()
            vim.cmd.cc()
            vim.cmd.Gdiffsplit(item.diff[1].module)
          end
        end
      end

      G.nmap("[c", function()
        vim.cmd.cpfile()
        diff_current_quickfix_entry()
      end, { unique = false })

      G.nmap("]c", function()
        vim.cmd.cnfile()
        diff_current_quickfix_entry()
      end, { unique = false })

      local function get_active_visual_region()
        return vim.fn.getregion(vim.fn.getpos("."), vim.fn.getpos("v"), { type = vim.fn.mode() })
      end

      local function get_active_visual_lines()
        return table.concat(vim.iter(get_active_visual_region()):map(vim.trim):totable())
      end

      local gx_desc =
        "Open filepath or URI under cursor or current file with system handler (file explorer, web browser, …)"

      vim.keymap.set({ "n" }, "gx", function()
        if require("ah.util").open_uri(vim.fn.expand("<cfile>")) then
          vim.cmd.GBrowse()
        end
      end, { desc = gx_desc })

      vim.keymap.set({ "x" }, "gx", function()
        if require("ah.util").open_uri(get_active_visual_lines()) then
          vim.cmd.GBrowse({ range = { vim.fn.line("v"), vim.fn.line(".") } })
        end
      end, { desc = gx_desc })

      -- Required by Fugitive to open a url since we're not using netrw.
      vim.api.nvim_create_user_command("Browse", function(args)
        require("ah.util").open_uri(args.args)
      end, { nargs = 1 })
    end,
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
      formatters = {
        json = { "jq", "." },
        xml = { "xmllint", "--format", "-" },
        html = { "xmllint", "--format", "--html", "-" },
      },
    },
    config = function(_, opts)
      require("kulala").setup(opts)
      G.au("FileType", {
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

  -- Project-wide search and replace
  {
    "https://github.com/MagicDuck/grug-far.nvim",
    keys = {
      {
        "<leader>e",
        function()
          require("grug-far").open({ transient = true })
          -- require("spectre").toggle({ cwd = G.buf_cwd() })
        end,
        desc = "Toggle search and replace",
      },
    },
    opts = {},
  },
}

local other = {
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
