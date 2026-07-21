-- Use the markdown parser for `mdx` filetypes
vim.treesitter.language.register("markdown", "mdx")

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

now(function()
  vim.api.nvim_create_autocmd("PackChanged", {
    desc = "Update tree-sitter parsers after plugin is updated",
    pattern = "nvim-treesitter",
    callback = function(ev)
      if ev.data.kind == "update" then
        vim.cmd("TSUpdate")
      end
    end,
  })

  vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" }, { confirm = false })

  require("nvim-treesitter").install(languages)

  -- Enable tree-sitter after opening a file for a target language
  local filetypes = {}
  for _, lang in ipairs(languages) do
    for _, ft in ipairs(vim.treesitter.language.get_filetypes(lang)) do
      table.insert(filetypes, ft)
    end
  end

  vim.api.nvim_create_autocmd("FileType", {
    desc = "Start streesitter on supported filetypes",
    pattern = filetypes,
    callback = function(ev)
      vim.treesitter.start(ev.buf)
    end,
  })
end)
