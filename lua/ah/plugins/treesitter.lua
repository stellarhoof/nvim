-- Nvim Treesitter configurations and abstraction layer
local ensure_installed = {
  "bash",
  "css",
  "diff",
  "dockerfile",
  "fish",
  "git_config",
  "git_rebase",
  "gitattributes",
  "gitcommit",
  "gitignore",
  "graphql",
  "html",
  "http",
  "javascript",
  "jsdoc",
  "json",
  "json5",
  "jsonc",
  "lua",
  "markdown",
  "nix",
  "norg",
  "python",
  "regex",
  "sql",
  "tsx",
  "typescript",
  "vim",
  "vimdoc",
  "xml",
  "yaml",
}

return {
  "https://github.com/nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  config = function()
    vim.wo.foldmethod = "expr"
    vim.wo.foldexpr = "nvim_treesitter#foldexpr()"
    require("nvim-treesitter.configs").setup({
      sync_install = true,
      auto_install = false,
      ignore_install = {},
      ensure_installed = ensure_installed,
      indent = {
        enable = false,
      },
      highlight = {
        enable = true,
        -- Disable slow treesitter highlight for large files
        disable = function(lang, buf)
          local max_filesize = 100 * 1024 -- 100 KB
          local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
          if ok and stats and stats.size > max_filesize then
            print("Disabling treesitter highlighting...")
            return true
          end
        end,
      },
    })
  end,
}
