---@module 'snacks'
return {
  "https://github.com/folke/snacks.nvim",
  ---@type snacks.Config
  opts = {
    picker = {
      formatters = {
        file = { truncate = 1000, icon_width = 3 },
      },
      sources = {
        smart = { layout = { preset = "select", preview = nil } },
        files = { layout = { preset = "select", preview = nil } },
        git_files = { layout = { preset = "select", preview = nil } },
      },
    },
  },
  keys = {
    -- -- stylua: ignore start
    -- { "<leader>fb", function() Snacks.picker.buffers() end, desc = "Buffers" },
    -- { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end, desc = "Find Config File" },
    -- { "<leader>ff", function() Snacks.picker.files() end, desc = "Find Files" },
    -- { "<leader>fg", function() Snacks.picker.git_files() end, desc = "Find Git Files" },
    -- { "<leader>fp", function() Snacks.picker.projects() end, desc = "Projects" },
    -- { "<leader>fr", function() Snacks.picker.recent() end, desc = "Recent" },
    -- -- stylua: ignore end
  },
}
