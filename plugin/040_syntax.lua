-- Installed and auto enable parsers for the following languages.
-- See `require('nvim-treesitter').get_available()`
local languages = {
  "bash", "css", "diff", "dockerfile", "fish", "git_config", "git_rebase",
  "gitattributes", "gitcommit", "gitignore", "graphql", "html", "http", "javascript",
  "jsdoc", "json", "json5", "nix", "python", "regex", "sql", "tsx", "typescript", "xml",
  "yaml",
}

later(function ()
  vim.api.nvim_create_autocmd("PackChanged", {
    desc = "Keep parsers in sync with tree-sitter plugin",
    pattern = { "nvim-treesitter" },
    callback = function (ev)
      if not ev.data.active then
        vim.cmd.packadd("nvim-treesitter")
      end
      if ev.data.kind == "install" then
        require("nvim-treesitter").install(languages)
      end
      if ev.data.kind == "update" then
        require("nvim-treesitter").install(languages)
        require("nvim-treesitter").update(languages)
      end
      if ev.data.kind == "delete" then
        require("nvim-treesitter").uninstall(languages)
      end
    end,
  })

  vim.pack.add(
    { "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false }
  )

  local filetypes = vim
    .iter(languages)
    :map(vim.treesitter.language.get_filetypes)
    :flatten()
    :totable()

  vim.api.nvim_create_autocmd("FileType", {
    desc = "Start streesitter on supported filetypes",
    pattern = filetypes,
    callback = function (ev)
      vim.treesitter.start(ev.buf)
    end,
  })
end)
