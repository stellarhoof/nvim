G.misc.safely("now", function()
  vim.pack.add({
    "https://github.com/folke/snacks.nvim",
    "https://github.com/piersolenski/import.nvim",
  }, { confirm = false })

  require("import").setup({ picker = "snacks" })

  require("snacks").setup({
    picker = {
      main = {
        -- Open files in current window
        current = true,
      },
      formatters = {
        file = { truncate = 1000, icon_width = 3 },
      },
      layouts = {
        window = {
          preset = "vscode",
          layout = {
            row = function()
              return vim.api.nvim_win_get_position(0)[1]
            end,
            col = function()
              return vim.api.nvim_win_get_position(0)[2]
            end,
            height = function()
              return vim.api.nvim_win_get_height(0)
            end,
            width = function()
              return vim.api.nvim_win_get_width(0)
            end,
          },
        },
      },
      sources = {
        -- stylua: ignore start
        recent          = { layout = "window" },
        files           = { layout = "window" },
        git_files       = { layout = "window" },
        buffers         = { layout = "window", current = false },
        command_history = { layout = { preset = "vertical", hidden = { "preview" } } },
        grep            = { layout = { preset = "vertical", hidden = { "preview" }, fullscreen = true } },
        colorschemes    = { layout = { preset = "sidebar", hidden = { "preview" } } },
        help            = { layout = { preset = "default", fullscreen = true } },
        zoxide          = { layout = { preset = "sidebar", layout = { width = 50 } } },
        -- stylua: ignore end
        explorer = {
          layout = {
            auto_hide = { "input" },
            layout = { layout = { width = 50 } },
          },
          diagnostics = false,
        },
        projects = {
          layout = { preset = "sidebar", hidden = { "preview" }, layout = { width = 50 } },
          patterns = { ".git", "package.json", "tsconfig.json" },
          recent = false,
          dev = {
            "~/Projects",
            "~/Projects/stellarhoof",
            "~/Projects/headless-ui-libs",
            "~/Projects/smartprocure",
            "~/Projects/smartprocure/contexture/packages",
            "~/.config/nvim",
            "~/.config/home-manager",
          },
        },
        git_branches = {
          all = true,
          layout = { preset = "vertical", hidden = { "preview" }, fullscreen = true },
          actions = {
            toggle_all = function(picker)
              picker.opts["all"] = not picker.opts["all"]
              picker:find()
            end,
          },
          win = {
            input = {
              keys = {
                ["<c-a>"] = { "toggle_all", mode = { "n", "i" }, desc = "Toggle all branches" },
              },
            },
          },
        },
      },
    },
  })

  require("snacks").util.set_hl({
    SnacksPickerDir = { link = "Text" },
  })

  vim.keymap.set("n", "<leader>,", function()
    Snacks.picker.buffers()
  end, { desc = "Snacks.picker.buffers" })

  vim.keymap.set("n", "<leader>e", function()
    Snacks.picker.explorer()
  end, { desc = "Snacks.picker.explorer" })

  vim.keymap.set("n", "<leader>s", function()
    Snacks.picker.grep({ cwd = G.buf_cwd(), hidden = true })
  end, { desc = "Snacks.picker.grep" })

  vim.keymap.set("n", "<leader>:", function()
    Snacks.picker.command_history()
  end, { desc = "Snacks.picker.command_history" })

  vim.keymap.set("n", "<leader>?", function()
    Snacks.picker.help()
  end, { desc = "Snacks.picker.help" })

  vim.keymap.set("n", "<leader>h", function()
    Snacks.picker.recent({ cwd = G.buf_cwd() })
  end, { desc = "Snacks.picker.recent" })

  vim.keymap.set("n", "<leader>f", function()
    Snacks.picker.git_files({ cwd = G.buf_cwd() })
  end, { desc = "Snacks.picker.git_files" })

  vim.keymap.set("n", "<leader>i", function()
    require("import").pick()
  end, { desc = "imports" })

  vim.keymap.set("n", "<leader>b", function()
    Snacks.picker.git_branches()
  end, { desc = "Snacks.picker.git_branches" })

  vim.keymap.set("n", "<leader>kk", function()
    Snacks.picker.pickers()
  end, { desc = "Snacks.picker.pickers" })

  vim.keymap.set("n", "<leader>kf", function()
    Snacks.picker.files()
  end, { desc = "Snacks.picker.files" })

  vim.keymap.set("n", "<leader>kc", function()
    Snacks.picker.colorschemes()
  end, { desc = "Snacks.picker.colorschemes" })

  vim.keymap.set("n", "<leader>kp", function()
    Snacks.picker.projects()
  end, { desc = "Snacks.picker.projects" })

  vim.keymap.set("n", "<leader>kz", function()
    Snacks.picker.zoxide()
  end, { desc = "Snacks.picker.zoxide" })
end)
