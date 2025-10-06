-- https://github.com/yioneko/vtsls/issues/242
local function typescript_root_dir(filename)
  local root_pattern = require("lspconfig.util").root_pattern

  -- Sounds like a good idea until you realize you can't jump to definitions
  -- from library to library :(
  -- -- Disable if file is inside node_modules
  -- if string.find(filename, "node_modules/") then
  -- 	return nil
  -- end

  -- Support monorepos by resolving to the root project
  local dir = root_pattern(".git")(filename)
  if dir and vim.fn.globpath(dir, "tsconfig.json") ~= "" then
    return dir
  end

  return root_pattern("tsconfig.json", ".git", "jsconfig.json", "package.json")(filename)
end

return {
  -- root_dir = typescript_root_dir,
  -- https://github.com/yioneko/vtsls/blob/41ad8c9d3f9dbd122ce3259564f34d020b7d71d9/packages/service/configuration.schema.json
  settings = {
    typescript = {
      updateImportsOnFileMove = "always",
      preferTypeOnlyAutoImports = true,
      tsserver = { maxTsServerMemory = 8192 },
    },
    javascript = {
      updateImportsOnFileMove = "always",
    },
    vtsls = {
      -- https://github.com/yioneko/vtsls#typescript-version
      autoUseWorkspaceTsdk = true,
    },
  },
  on_attach = function(_, bufnr)
    G.nmap("grf", require("vtsls").commands.file_references, {
      buffer = bufnr,
      desc = "[vtsls] commands.file_references",
    })

    G.nmap("grs", require("vtsls").commands.source_actions, {
      buffer = bufnr,
      desc = "[vtsls] commands.source_actions",
    })

    G.nmap("grm", require("vtsls").commands.rename_file, {
      buffer = bufnr,
      desc = "[vtsls] commands.rename_file",
    })

    G.nmap("gd", require("vtsls").commands.goto_source_definition, {
      buffer = bufnr,
      desc = "[vtsls] commands.goto_source_definition",
    })
  end,
}
