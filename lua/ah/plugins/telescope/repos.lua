local Path = require("plenary.path")
local Iter = require("plenary.iterators").iter
local strings = require("plenary.strings")
local pickers = require("telescope.pickers")
local finders = require("telescope.finders")
local conf = require("telescope.config").values
local make_entry = require("telescope.make_entry")
local utils = require("telescope.utils")

local function make_command(opts)
  local command = {
    "fd",
    "--absolute-path",
    "--max-depth",
    "5",
    "--unrestricted",
    "--case-sensitive",
    "--type",
    "d",
    "--glob",
    ".git",
    "--exec",
    "echo",
    "{//}",
    ";",
  }
  table.insert(command, vim.tbl_values(opts.roots))
  return vim.iter(command):flatten():totable()
end

return function(opts)
  -- Make roots absolute paths
  opts.roots = vim.tbl_map(function(r)
    return vim.fn.fnamemodify(r, ":p")
  end, opts.roots)

  -- Calculate width of longest root name for padding purposes
  local maxw = math.max(unpack(vim.tbl_map(string.len, vim.tbl_keys(opts.roots))))

  opts.entry_maker = function(line)
    local entry = make_entry.gen_from_file(opts)(line)
    local meta = getmetatable(entry)
    local name = nil

    -- Find this entry's root directory
    name, meta.cwd = Iter(opts.roots):find(function(name, root)
      return string.find(entry.value, "^" .. root)
    end)

    -- Remove root directory so we don't sort on it
    entry.ordinal = string.gsub(entry.value, meta.cwd, "")

    meta.display = function(entry)
      local hl_group

      -- Same as telescope's, but instead display the ordinal value.
      local display = utils.transform_path(opts, entry.ordinal)

      -- Prefix path with the root directory's name
      display =
        string.format("%s %s", strings.align_str(string.format("(%s)", name), maxw + 2), display)

      -- Same as telescope's, but make transform_devicons return a git icon.
      display, hl_group = utils.transform_devicons(".git", display, opts.disable_devicons)

      if hl_group then
        return display, { { { 0, 4 }, hl_group }, { { 4, maxw + 6 }, "Comment" } }
      end

      return display, { { { 0, maxw + 2 }, "Comment" } }
    end

    return entry
  end

  pickers
    .new(opts, {
      prompt_title = "Repositories",
      finder = finders.new_oneshot_job(make_command(opts), opts),
      sorter = conf.file_sorter(opts),
      previewer = conf.file_previewer(opts),
    })
    :find()
end

-- vim.fs.find({".git"}, { limit = math.huge, path = "~/Code", type = "directory", stop = ".git" })

-- function M.cycle_directories(directories)
-- 	local counter = 0
-- 	local inserted_cwd = false

-- 	return function(prompt_bufnr)
-- 		local picker = action_state.get_current_picker(prompt_bufnr)

-- 		if not inserted_cwd then
-- 			table.insert(directories, picker.cwd)
-- 			inserted_cwd = true
-- 		end

-- 		picker.cwd = directories[counter % #directories + 1]
-- 		counter = counter + 1

-- 		picker.entry_maker = entry_maker(picker)
-- 		picker:refresh(finders.new_oneshot_job(command, picker))
-- 	end
-- end
