G.misc.safely("now", function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = "http",
    callback = function()
      G.nmap("<localleader>r", function()
        require("kulala").run()
      end, { noremap = true, buffer = true, desc = "Run request under the cursor" })
    end,
  })

  vim.pack.add({ "https://github.com/mistweaverco/kulala.nvim" }, { confirm = false })

  require("kulala").setup({
    default_env = "dev",
    kulala_keymaps = false,
    kulala_keymaps_prefix = "<leader>R",
    global_keymaps = false,
    formatters = {
      json = { "jq", "." },
      xml = { "xmllint", "--format", "-" },
      html = { "xmllint", "--format", "--html", "-" },
    },
    ui = { max_response_size = 1024000 },
  })
end)
