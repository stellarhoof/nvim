-- Easily install and manage LSP servers, DAP servers, linters, and formatters.

local install = {
  -- LSP
  "eslint-lsp",
  "lua-language-server",
  "emmet-language-server",
  "typescript-language-server",
  -- Formatters
  "prettierd",
  "stylua",
  "shfmt",
  "isort",
  "black",
  -- DAP
  "js-debug-adapter",
  "chrome-debug-adapter",
}

local function ensure_installed()
  local registry = require("mason-registry")
  for _, name in ipairs(install) do
    local pack = registry.get_package(name)
    if not pack:is_installed() then
      pack:install()
    end
  end
end

return {
  "https://github.com/williamboman/mason.nvim",
  config = function()
    require("mason").setup()
    local registry = require("mason-registry")
    if registry.refresh then
      registry.refresh(ensure_installed)
    else
      ensure_installed()
    end
  end,
}
