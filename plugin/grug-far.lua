G.misc.safely("now", function()
  vim.api.nvim_create_autocmd("FileType", {
    pattern = { "grug-far" },
    callback = function()
      vim.wo.signcolumn = "no"
      G.hl_link("GrugFarResultsPath", "Directory")
    end,
  })

  vim.pack.add({ "https://github.com/MagicDuck/grug-far.nvim" }, { confirm = false })

  require("grug-far").setup({
    normalModeSearch = true,
    startInInsertMode = false,
    helpLine = { enabled = false },
    showCompactInputs = true,
    showInputsTopPadding = false,
    showStatusIcon = false,
    resultsSeparatorLineChar = " ",
    icons = {
      searchInput = "",
      replaceInput = "",
      filesFilterInput = "",
      flagsInput = "",
      pathsInput = "",
    },
    folding = {
      foldcolumn = "0",
    },
    resultLocation = {
      showNumberLabel = false,
    },
  })

  G.nmap(
    "<leader>r",
    require("grug-far").open,
    { noremap = true, buffer = true, desc = "Run request under the cursor" }
  )
end)
