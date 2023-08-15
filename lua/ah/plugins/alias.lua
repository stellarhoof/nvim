local M = {
  "https://github.com/konfekt/vim-alias",
}

function M.config()
  local alias = cmd.Alias
  alias({ args = { "w", "up" }, bang = true })
  alias({ args = { "man", "Man" }, bang = true })

  -- Fugitive
  alias({ args = { "g", "G" } })
  alias({ args = { "gbl", "Git blame -w -M" } })
  alias({ args = { "gd", "Gdiffsplit" } })
  alias({ args = { "ge", "Gedit" } })
  alias({ args = { "gr", "Gread" } })
  alias({ args = { "gs", "Git" } })
  alias({ args = { "gw", "Gwrite" } })
  alias({ args = { "gco", "Git checkout" } })
  alias({ args = { "gcm", "Git commit" } })
  alias({ args = { "gcma", "Git commit --amend" } })
  alias({
    args = { "gcman", "Git commit --amend --reuse-message HEAD" },
  })

  -- Rhubarb
  alias({
    args = { "go", "GBrowse" },
    -- range = true -- TODO: Why doesn't range work?
  })

  -- Eunuch
  alias({ args = { "mv", "Move" } })
  alias({ args = { "rm", "Delete" } })
  alias({ args = { "ren", "Rename" } })
  alias({ args = { "cmo", "Chmod" } })
  alias({ args = { "mk", "Mkdir" } })
  alias({ args = { "sue", "SudoEdit" } })
  alias({ args = { "suw", "SudoWrite" } })

  -- Messages
  alias({ args = { "ms", "Messages" } })
  alias({ args = { "mess", "Messages" } })
end

return M
