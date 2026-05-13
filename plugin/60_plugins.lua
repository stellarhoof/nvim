----------------------------------------------------------
-- Colorschemes
----------------------------------------------------------

G.misc.safely("now", function()
  vim.pack.add({
    "https://github.com/rktjmp/lush.nvim",
    "https://github.com/mcchrish/zenbones.nvim",
  })
  vim.g.zenbones_darkness = "stark"
  vim.g.zenwritten_darkness = "stark"
  vim.api.nvim_create_autocmd({ "ColorScheme" }, {
    pattern = "zen*",
    desc = "Override zenbones colorscheme highlights",
    callback = function()
      G.hl_update("Constant", { italic = false })
      G.hl_update("Comment", { italic = false })
      G.hl_link("FloatBorder", "NormalFloat")
      G.hl_link("FloatTitle", "NormalFloat", { bold = true })
    end,
  })
end)

G.misc.safely("now", function()
  vim.api.nvim_create_autocmd("PackChanged", {
    desc = "Update tree-sitter parsers after plugin is updated",
    pattern = "nvim-treesitter",
    callback = function(ev)
      if ev.data.kind == "update" then
        vim.cmd("TSUpdate")
      end
    end,
  })

  vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

  -- Installed and auto enable parsers for the following languages.
  -- See `:=require('nvim-treesitter').get_available()`
  local languages = {
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
    "nix",
    "python",
    "regex",
    "sql",
    "tsx",
    "typescript",
    "xml",
    "yaml",
  }

  require("nvim-treesitter").install(languages)

  -- Enable tree-sitter after opening a file for a target language
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end

  vim.api.nvim_create_autocmd("FileType", {
    desc = "Start streesitter",
    pattern = filetypes,
    callback = function(ev)
      vim.treesitter.start(ev.buf)
    end,
  })

  -- -- Disable slow treesitter highlight for large files
  -- disable = function(_, buf)
  --   local max_filesize = 100 * 1024 -- 100 KB
  --   local ok, stats = pcall(vim.loop.fs_stat, vim.api.nvim_buf_get_name(buf))
  --   if ok and stats and stats.size > max_filesize then
  --     print("Disabling treesitter highlighting...")
  --     return true
  --   end
  -- end,
end)

G.misc.safely("now", function()
  vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
end)

G.misc.safely("later", function()
  vim.pack.add({ "https://github.com/stevearc/conform.nvim" })
  require("conform").setup({
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
      json = { "oxfmt", "biome-check", "prettierd" },
      jsonc = { "oxfmt", "biome-check", "prettierd" },
      javascript = { "oxfmt", "biome-check", "prettierd" },
      javascriptreact = { "oxfmt", "biome-check", "prettierd" },
      typescript = { "oxfmt", "biome-check", "prettierd" },
      typescriptreact = { "oxfmt", "biome-check", "prettierd" },
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
  })
end)
