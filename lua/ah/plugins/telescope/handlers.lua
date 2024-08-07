local M = {}

function M.find_files(opts)
  opts = G.merge({ layout_strategy = "window", cwd = G.buf_cwd() }, opts or {})

  local out = vim
    .system({ "git", "rev-parse", "--is-inside-work-tree" }, { text = true, cwd = opts.cwd })
    :wait()

  if out.code == 0 then
    require("telescope.builtin").git_files(G.merge(opts, {
      use_git_root = false,
      show_untracked = true,
    }))
  else
    require("telescope.builtin").find_files(opts)
  end
end

return M
