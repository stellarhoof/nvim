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
      formatters = {
        file = { truncate = 1000, icon_width = 3 },
      },
      sources = {
        -- stylua: ignore start
        recent          = { layout = { preset = "vertical", hidden = { "preview" } } },
        files           = { layout = { preset = "vertical", hidden = { "preview" } } },
        git_files       = { layout = { preset = "vertical", hidden = { "preview" } } },
        buffers         = { layout = { preset = "vertical", hidden = { "preview" } }, current = false },
        command_history = { layout = { preset = "vertical", hidden = { "preview" } } },
        git_branches    = { layout = { preset = "vertical", hidden = { "preview" }, fullscreen = true } },
        grep            = { layout = { preset = "vertical", hidden = { "preview" }, fullscreen = true } },
        colorschemes    = { layout = { preset = "sidebar", hidden = { "preview" } } },
        help            = { layout = { preset = "default", fullscreen = true } },
        zoxide          = { layout = { preset = "sidebar", layout = { width = 50 } } },
        -- stylua: ignore end
        projects = {
          layout = { preset = "sidebar", layout = { width = 50 } },
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
      },
    },
  },
  keys = {
    -- stylua: ignore start
    { "<leader>k", function() Snacks.picker.pickers() end, desc = "Snacks.picker.pickers" },
    -- Common pickers
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Snacks.picker.buffers" },
    { "<leader>/", function() Snacks.picker.grep({ cwd = G.buf_cwd() }) end, desc = "Snacks.picker.grep" },
    { "<leader>:", function() Snacks.picker.command_history() end, desc = "Snacks.picker.command_history" },
    { "<leader>?", function() Snacks.picker.help() end, desc = "Snacks.picker.help" },
    { "<leader>r", function() Snacks.picker.recent({ cwd = G.buf_cwd() }) end, desc = "Snacks.picker.recent" },
    { "<leader>f", function() Snacks.picker.git_files({ cwd = G.buf_cwd() }) end, desc = "Snacks.picker.git_files" },
    -- Git
    -- TODO: Combine these two by providing a keymap to switch between local and
    -- all branches
    { "<leader>gl", function() Snacks.picker.git_branches() end, desc = "Snacks.picker.git_branches" },
    { "<leader>gb", function() Snacks.picker.git_branches({ all = true }) end, desc = "Snacks.picker.git_branches (all)" },
    -- Search
    { "<leader>si", function() require("import").pick() end, desc = "imports" },
    { "<leader>sc", function() Snacks.picker.colorschemes() end, desc = "Snacks.picker.colorschemes" },
    { "<leader>sp", function() Snacks.picker.projects() end, desc = "Snacks.picker.projects" },
    { "<leader>sl", function() Snacks.picker.lazy() end, desc = "Snacks.picker.lazy" },
    { "<leader>sz", function() Snacks.picker.zoxide() end, desc = "Snacks.picker.zoxide" },
    -- stylua: ignore end
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    require("snacks").util.set_hl({
      SnacksPickerDir = { link = "Text" },
    })
  end,
}
