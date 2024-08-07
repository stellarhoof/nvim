return {
  "https://github.com/stevearc/overseer.nvim",
  opts = {
    dap = false,
    -- Window for editing tasks/templates
    form = { win_opts = { winblend = 0 } },
    -- Window used for confirmation prompts
    confirm = { win_opts = { winblend = 0 } },
    -- Task floating windows
    task_win = { win_opts = { winblend = 0 } },
    -- Mapping help floating windows
    help_win = { win_opts = { winblend = 0 } },
    task_list = {
      direction = "bottom",
      separator = "",
    },
    component_aliases = {
      default = {
        "display_duration",
        "on_output_summarize",
        "on_exit_set_status",
        "on_complete_dispose",
        "ah.on_status_fidget",
      },
    },
  },
  config = function(_, opts)
    require("overseer").setup(opts)
    vim.opt.runtimepath:append(G.root .. "/lua/ah/plugins/overseer")
  end,
}
