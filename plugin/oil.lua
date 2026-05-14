-- helper function to parse output
local function parse_output(proc)
  local result = proc:wait()
  local ret = {}
  if result.code == 0 then
    for line in vim.gsplit(result.stdout, "\n", { plain = true, trimempty = true }) do
      -- Remove trailing slash
      line = line:gsub("/$", "")
      ret[line] = true
    end
  end
  return ret
end

-- build git status cache
local function new_git_status()
  return setmetatable({}, {
    __index = function(self, key)
      local ignore_proc = vim.system(
        { "git", "ls-files", "--ignored", "--exclude-standard", "--others", "--directory" },
        {
          cwd = key,
          text = true,
        }
      )
      local tracked_proc = vim.system({ "git", "ls-tree", "HEAD", "--name-only" }, {
        cwd = key,
        text = true,
      })
      local ret = {
        ignored = parse_output(ignore_proc),
        tracked = parse_output(tracked_proc),
      }

      rawset(self, key, ret)
      return ret
    end,
  })
end

G.misc.safely("now", function()
  vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = "oil",
    callback = function()
      vim.b.dir = require("oil").get_current_dir()
    end,
  })

  vim.pack.add({ "https://github.com/stevearc/oil.nvim" }, { confirm = false })

  local git_status = new_git_status()

  require("oil").setup({
    cleanup_delay_ms = false,
    view_options = {
      show_hidden = true,
      is_hidden_file = function(name, bufnr)
        local dir = require("oil").get_current_dir(bufnr)
        local is_dotfile = vim.startswith(name, ".") and name ~= ".."
        -- if no local directory (e.g. for ssh connections), just hide dotfiles
        if not dir then
          return is_dotfile
        end
        -- dotfiles are considered hidden unless tracked
        if is_dotfile then
          return not git_status[dir].tracked[name]
        else
          -- Check if file is gitignored
          return git_status[dir].ignored[name]
        end
      end,
    },
    skip_confirm_for_simple_edits = true,
    -- :h |oil-config|
    keymaps = {
      ["<C-v>"] = false,
      ["<C-s>"] = false,
      ["<C-h>"] = false,
      ["<C-l>"] = false,
      ["<C-c>"] = false,
      ["~"] = false,
      ["gs"] = false,
      ["g\\"] = false,
      ["gt"] = { "actions.open_terminal", mode = "n" },
    },
    win_options = {
      conceallevel = 0,
    },
    lsp_file_methods = {
      -- Time to wait for LSP file operations to complete before skipping
      timeout_ms = 2000,
      -- Set to true to autosave buffers that are updated with LSP willRenameFiles
      -- Set to "unmodified" to only save unmodified buffers
      autosave_changes = true,
    },
  })

  local refresh = require("oil.actions").refresh
  local orig_refresh = refresh.callback
  refresh.callback = function(...)
    git_status = new_git_status()
    orig_refresh(...)
  end

  G.nmap("-", vim.cmd.Oil, { desc = "Open buffer directory" })
end)
