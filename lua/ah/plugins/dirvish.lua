return {
  "https://github.com/justinmk/vim-dirvish",
  dependencies = { "https://github.com/roginfarrer/vim-dirvish-dovish" },
  init = function()
    vim.g.dirvish_mode = 2
    vim.g.dirvish_dovish_map_keys = 0
  end,
  config = function()
    G.au("FileType", {
      pattern = "dirvish",
      callback = function()
        vim.b.dir = vim.fn.bufname()
        vim.cmd.sort(",^.*[\\/],") -- Sort directories first
        G.nmap(
          "<localleader>f",
          "<plug>(dovish_create_file)",
          { buffer = true, desc = "Create file" }
        )
        G.nmap(
          "<localleader>i",
          "<plug>(dovish_create_directory)",
          { buffer = true, desc = "Create directory" }
        )
        G.nmap(
          "<localleader>d",
          "<plug>(dovish_delete)",
          { buffer = true, desc = "Delete entry under cursor" }
        )
        G.nmap(
          "<localleader>r",
          "<plug>(dovish_rename)",
          { buffer = true, desc = "Rename entry under cursor" }
        )
        G.nmap(
          "<localleader>y",
          "<plug>(dovish_yank)",
          { buffer = true, desc = "Yank entry under cursor" }
        )
        G.xmap(
          "<localleader>y",
          "<plug>(dovish_yank)",
          { buffer = true, desc = "Yank entry under cursor" }
        )
        G.nmap(
          "<localleader>p",
          "<plug>(dovish_copy)",
          { buffer = true, desc = "Paste entry to current directory" }
        )
        G.nmap(
          "<localleader>x",
          "<plug>(dovish_move)",
          { buffer = true, desc = "Move entry to current directory" }
        )
      end,
    })
  end,
}
