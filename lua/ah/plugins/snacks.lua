---@module 'lazy'
---@module 'snacks'

---@type LazySpec
return {
  "https://github.com/folke/snacks.nvim",
  dependencies = {
    {
      "https://github.com/piersolenski/import.nvim",
      opts = { picker = "snacks" },
    },
  },
  ---@type snacks.Config
  opts = {
    ---@type snacks.picker.Config
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
            "~/Code",
            "~/Code/stellarhoof",
            "~/Code/headless-ui-libs",
            "~/Code/smartprocure",
            "~/Code/smartprocure/contexture/packages",
          },
        },
        git_branches = {
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
                ["<a-a>"] = { "toggle_all", mode = { "n", "i" }, desc = "Toggle all branches" },
              },
            },
          },
        },
      },
    },
  },
  keys = {
    -- stylua: ignore start
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Snacks.picker.buffers" },
    { "<leader>e", function() Snacks.picker.explorer() end, desc = "Snacks.picker.explorer" },
    { "<leader>s", function() Snacks.picker.grep({ cwd = G.buf_cwd() }) end, desc = "Snacks.picker.grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Snacks.picker.command_history" },
    { "<leader>?", function() Snacks.picker.help() end, desc = "Snacks.picker.help" },
    { "<leader>h", function() Snacks.picker.recent({ cwd = G.buf_cwd() }) end, desc = "Snacks.picker.recent" },
    { "<leader>f", function() Snacks.picker.git_files({ cwd = G.buf_cwd() }) end, desc = "Snacks.picker.git_files" },
    { "<leader>i", function() require("import").pick() end, desc = "imports" },
    { "<leader>b", function() Snacks.picker.git_branches() end, desc = "Snacks.picker.git_branches" },
    { "<leader>kk", function() Snacks.picker.pickers() end, desc = "Snacks.picker.pickers" },
    { "<leader>kc", function() Snacks.picker.colorschemes() end, desc = "Snacks.picker.colorschemes" },
    { "<leader>kp", function() Snacks.picker.projects() end, desc = "Snacks.picker.projects" },
    { "<leader>kl", function() Snacks.picker.lazy() end, desc = "Snacks.picker.lazy" },
    { "<leader>kz", function() Snacks.picker.zoxide() end, desc = "Snacks.picker.zoxide" },
    -- stylua: ignore end
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    require("snacks").util.set_hl({
      SnacksPickerDir = { link = "Text" },
    })
  end,
}
