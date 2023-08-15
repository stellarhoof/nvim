local M = {
  "https://github.com/nvim-telescope/telescope.nvim",
  cmd = { "Telescope" },
  dependencies = {
    "https://github.com/smartpde/telescope-recent-files",
    "https://github.com/benfowler/telescope-luasnip.nvim",
    { "https://github.com/nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
}

local layouts = {}

function layouts.buffer_window(self)
  local layout = require("telescope.pickers.window").get_initial_window_options(self)
  local prompt = layout.prompt
  local results = layout.results
  local preview = layout.preview
  local config = self.layout_config
  local padding = self.window.border and 2 or 0
  local width = api.nvim_win_get_width(self.original_win_id)
  local height = api.nvim_win_get_height(self.original_win_id)
  local pos = api.nvim_win_get_position(self.original_win_id)
  local wline = pos[1] + 1
  local wcol = pos[2] + 1

  -- Height
  prompt.height = 1
  preview.height = self.previewer and math.floor(height * 0.4) or 0
  results.height = height
      - padding
      - (prompt.height + padding)
      - (self.previewer and (preview.height + padding) or 0)

  -- Line
  local rows = {}
  local mirror = config.mirror == true
  local top_prompt = config.prompt_position == "top"
  if mirror and top_prompt then
    rows = { prompt, results, preview }
  elseif mirror and not top_prompt then
    rows = { results, prompt, preview }
  elseif not mirror and top_prompt then
    rows = { preview, prompt, results }
  elseif not mirror and not top_prompt then
    rows = { preview, results, prompt }
  end
  local next_line = wline + padding / 2
  for k, v in pairs(rows) do
    if v.height ~= 0 then
      v.line = next_line
      next_line = v.line + padding + v.height
    end
  end

  -- Width
  prompt.width = width - padding
  results.width = prompt.width
  preview.width = prompt.width

  -- Col
  prompt.col = wcol + padding / 2
  results.col = prompt.col
  preview.col = prompt.col

  if not self.previewer then
    layout.preview = nil
  end

  return layout
end

local themes = {}

local center_borders = {
  prompt = { "─", "│", " ", "│", "╭", "╮", "│", "│" },
  results = { "─", "│", "─", "│", "├", "┤", "╯", "╰" },
  preview = { "─", "│", "─", "│", "╭", "╮", "╯", "╰" },
}

function themes.dropdown(opts)
  return vim.tbl_deep_extend("force", {
    preview_title = false,
    results_title = false,
    prompt_title = false,
    layout_strategy = "center",
    borderchars = center_borders,
    layout_config = { width = 0.6, height = 0.5 },
  }, opts or {})
end

function themes.horizontal(opts)
  return vim.tbl_deep_extend("force", {
    preview_title = false,
    results_title = false,
    prompt_title = false,
    layout_strategy = "horizontal",
    layout_config = { height = 0.9 },
  }, opts or {})
end

function themes.bufwindow(opts)
  return vim.tbl_deep_extend("force", {
    border = false,
    layout_strategy = "buffer_window",
    cycle_layout_list = {
      {
        layout_strategy = "vertical",
        layout_config = { prompt_position = "top" },
      },
      {
        layout_strategy = "buffer_window",
        layout_config = { prompt_position = "top" },
      },
    },
  }, opts or {})
end

function M.config()
  local telescope = require("telescope")

  for k, v in pairs(layouts) do
    require("telescope.pickers.layout_strategies")[k] = v
    require("telescope.pickers.layout_strategies")._configurations[k] = {
      mirror = "Flip the location of the results/prompt and preview windows",
      prompt_position = "Where to place prompt window",
    }
  end

  local mappings = {
    ["<c-u>"] = false,
    ["<c-d>"] = false,
    ["<c-l>"] = false,
    ["<c-/>"] = require("telescope.actions").which_key,
    ["<c-1>"] = require("telescope.actions.layout").toggle_preview,
    ["<c-2>"] = require("telescope.actions.layout").toggle_prompt_position,
    ["<c-3>"] = require("telescope.actions.layout").toggle_mirror,
    ["<c-4>"] = require("telescope.actions.layout").cycle_layout_next,
    ["<c-5>"] = require("telescope.actions.layout").cycle_layout_prev,
  }

  telescope.setup({
    defaults = {
      preview = false,
      prompt_prefix = " ",
      selection_caret = "  ",
      color_devicons = false,
      vimgrep_arguments = vim.g.grepprg,
      layout_strategy = "vertical",
      sorting_strategy = "ascending",
      layout_config = { prompt_position = "top" },
      get_status_text = function()
        return ""
      end,
      mappings = { i = mappings, n = mappings },
    },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  })

  require("telescope").load_extension("fzf")
  require("telescope").load_extension("luasnip")
  require("telescope").load_extension("recent_files")
end

local getcwd = function()
  return vim.o.ft == "dirvish" and vim.b.dirvish._dir
end

function M.init()
  nmap("<space>h", function()
    require("telescope.builtin").help_tags(themes.horizontal({
      preview = true,
      layout_config = { preview_width = 0.6 },
    }))
  end, { noremap = true, desc = "Help Tags" })

  nmap("<space>n", function()
    require("telescope").extensions.luasnip.luasnip(themes.dropdown({
      preview = true,
      layout_config = { anchor = "N", height = 0.4, width = 0.8 },
      borderchars = center_borders,
    }))
  end, { noremap = true, desc = "Luasnips snippets" })

  nmap("<space>t", function()
    require("telescope.builtin").treesitter(themes.bufwindow())
  end, { noremap = true, desc = "Treesitter symbols" })

  nmap("<space>l", function()
    require("telescope.builtin").current_buffer_fuzzy_find(themes.bufwindow())
  end, { noremap = true, desc = "Buffer Lines" })

  nmap("<space>r", function()
    require("telescope.builtin").live_grep(themes.horizontal({
      cwd = getcwd(),
      preview = true,
      layout_strategy = "center",
      layout_config = { anchor = "N", height = 0.4, width = 0.8 },
      borderchars = center_borders,
    }))
  end, { noremap = true, desc = "Live Grep" })

  nmap("<space>aa", function()
    require("telescope.builtin").git_branches(themes.dropdown())
  end, { noremap = true, desc = "All Git Branches" })

  nmap("<space>al", function()
    require("telescope.builtin").git_branches(
      themes.dropdown({ show_remote_tracking_branches = false })
    )
  end, { noremap = true, desc = "Local Git Branches" })

  nmap("<space>as", function()
    require("telescope.builtin").git_stash(themes.dropdown())
  end, { noremap = true, desc = "Git Stashes" })

  nmap("<space>g", function()
    require("telescope.builtin").git_files(themes.bufwindow({
      cwd = getcwd(),
      use_git_root = false,
      show_untracked = true,
    }))
  end, { noremap = true, desc = "Git Files" })

  nmap("<space>f", function()
    require("telescope.builtin").find_files(themes.bufwindow({
      cwd = getcwd(),
      hidden = true,
    }))
  end, { noremap = true, desc = "Files" })

  nmap("<space>b", function()
    require("telescope.builtin").buffers(themes.bufwindow({
      sort_mru = true,
      ignore_current_buffer = true,
    }))
  end, { noremap = true, desc = "Buffers" })

  nmap("<space>p", function()
    require("ah.plugins.telescope.repos")(themes.bufwindow({
      layout_config = { width = 0.4 },
      roots = {
        code = "~/code",
        plugin = fn.stdpath("data") .. "/lazy",
      },
    }))
  end, { noremap = true, desc = "Repositories" })

  nmap("<space>i", function()
    require("telescope").extensions.recent_files.pick(themes.bufwindow({
      hidden = true,
      no_ignore = true,
    }))
  end, { noremap = true, desc = "Recent Files" })
end

return M
