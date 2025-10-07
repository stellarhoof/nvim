-- Neovim file explorer: edit your filesystem like a buffer
return {
  "https://github.com/stevearc/oil.nvim",
  opts = {
    cleanup_delay_ms = false,
    view_options = { show_hidden = true },
    skip_confirm_for_simple_edits = true,
    -- :h |oil-config|
    keymaps = {
      ["<C-v>"] = false,
      ["<C-s>"] = false,
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<C-c>"] = false,
      ["~"] = false,
      ["gs"] = false,
      ["g\\"] = false,
      ["gt"] = { "actions.open_terminal", mode = "n" },
    },
    win_options = {
      conceallevel = 0,
    },
    lsp_file_methods = {
      -- Time to wait for LSP file operations to complete before skipping
      timeout_ms = 2000,
      -- Set to true to autosave buffers that are updated with LSP willRenameFiles
      -- Set to "unmodified" to only save unmodified buffers
      autosave_changes = true,
    },
  },
  config = function(_, opts)
    require("oil").setup(opts)
    G.nmap("-", vim.cmd.Oil, { desc = "Open buffer directory" })
    vim.api.nvim_create_autocmd({ "FileType" }, {
      pattern = "oil",
      callback = function()
        vim.b.dir = require("oil").get_current_dir()
      end,
    })
  end,
}
