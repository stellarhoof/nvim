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
        smart = { layout = { preset = "select", hidden = { "preview" } } },
        files = { layout = { preset = "select", hidden = { "preview" } } },
        git_files = { layout = { preset = "select", hidden = { "preview" } } },
        buffers = { current = false, layout = { preset = "select", hidden = { "preview" } } },
        help = { layout = { preset = "sidebar", layout = { width = 80 } } },
        -- TODO: Preview colorscheme via keymap
        colorschemes = { layout = { preset = "sidebar", hidden = { "preview" } } },
        git_branches = { layout = { preset = "bottom", hidden = { "preview" } } },
        grep = { layout = { preset = "vertical", fullscreen = true, hidden = { "preview" } } },
        projects = {
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
    { "<leader>k", function() Snacks.picker() end, desc = "Picker" },
    -- Common pickers
    { "<leader>h", function() Snacks.picker.smart({ cwd = G.buf_cwd() }) end, desc = "Snacks.picker.smart" },
    { "<leader>f", function() Snacks.picker.git_files({ cwd = G.buf_cwd() }) end, desc = "Snacks.picker.git_files" },
    { "<leader>,", function() Snacks.picker.buffers() end, desc = "Snacks.picker.buffers" },
    { "<leader>/", function() Snacks.picker.grep() end, desc = "Snacks.picker.grep" },
    -- Git
    { "<leader>gl", function() Snacks.picker.git_branches() end, desc = "Snacks.picker.git_branches" },
    { "<leader>gb", function() Snacks.picker.git_branches({ all = true }) end, desc = "Snacks.picker.git_branches (all)" },
    -- Search
    { "<leader>si", function() require("import").pick() end, desc = "imports" },
    { "<leader>sh", function() Snacks.picker.help() end, desc = "Snacks.picker.help" },
    { "<leader>sb", function() Snacks.picker.lines() end, desc = "Snacks.picker.lines" },
    { "<leader>sc", function() Snacks.picker.colorschemes() end, desc = "Snacks.picker.colorschemes" },
    { "<leader>sp", function() Snacks.picker.projects() end, desc = "Snacks.picker.projects" },
    { "<leader>sl", function() Snacks.picker.lazy() end, desc = "Snacks.picker.lazy" },
    -- stylua: ignore end
  },
  config = function(_, opts)
    require("snacks").setup(opts)
    require("snacks").util.set_hl({
      SnacksPickerDir = { link = "Text" },
    })
  end,
}
