return {
  "https://github.com/nvim-telescope/telescope.nvim",
  -- enabled = false,
  dependencies = {
    { "https://github.com/MunifTanjim/nui.nvim" },
    {
      "https://github.com/nvim-telescope/telescope-fzf-native.nvim",
      build = "make",
      config = function()
        require("telescope").load_extension("fzf")
      end,
    },
    {
      "https://github.com/smartpde/telescope-recent-files",
      init = function()
        G.nmap("<leader>h", function()
          require("telescope").extensions.recent_files.pick({
            layout_strategy = "window",
            hidden = true,
            no_ignore = true,
          })
        end, { noremap = true, desc = "File History" })
      end,
      config = function()
        require("telescope").load_extension("recent_files")
      end,
    },
    -- Select and insert Nerd icons
    {
      "https://github.com/2KAbhishek/nerdy.nvim",
      init = function()
        G.nmap("<leader>ti", function()
          require("telescope").extensions.nerdy.nerdy({
            layout_strategy = "center",
          })
        end, { noremap = true, desc = "Nerd Icons" })
      end,
      config = function()
        require("telescope").load_extension("nerdy")
      end,
    },
    {
      "https://github.com/piersolenski/telescope-import.nvim",
      init = function()
        G.nmap("<leader>i", function()
          require("telescope").extensions.import.import({})
        end, { noremap = true, desc = "Insert imports" })
      end,
      config = function()
        require("telescope").load_extension("import")
      end,
    },
  },
  cmd = { "Telescope" },
  init = function()
    G.nmap("<leader>s", function()
      require("telescope.builtin").live_grep({
        cwd = G.buf_cwd(),
        layout_strategy = "vertical",
      })
    end, { noremap = true, desc = "Live Grep" })

    G.nmap("<leader>b", function()
      require("telescope.builtin").buffers({
        layout_strategy = "window",
        sort_mru = true,
        ignore_current_buffer = true,
      })
    end, { noremap = true, desc = "Buffers" })

    G.nmap("<leader>p", function()
      require("ah.plugins.telescope.repos")({
        layout_strategy = "window",
        roots = {
          code = "~/Code",
          plugin = vim.fn.stdpath("data") .. "/lazy",
        },
      })
    end, { noremap = true, desc = "Projects" })

    G.nmap(
      "<leader>f",
      require("ah.plugins.telescope.handlers").find_files,
      { noremap = true, desc = "Git Files" }
    )

    G.nmap("<leader>tt", function()
      require("telescope.builtin").builtin({ include_extensions = true })
    end, { noremap = true, desc = "Pickers" })

    G.nmap("<leader>th", function()
      require("telescope.builtin").help_tags({})
    end, { noremap = true, desc = "Help Tags" })

    G.nmap("<leader>tf", function()
      require("telescope.builtin").find_files({
        layout_strategy = "window",
        cwd = G.buf_cwd(),
        hidden = true,
      })
    end, { noremap = true, desc = "Files" })

    G.nmap("<leader>tl", function()
      require("telescope.builtin").current_buffer_fuzzy_find({
        layout_strategy = "window",
      })
    end, { noremap = true, desc = "Buffer lines" })

    G.nmap("<leader>tc", function()
      require("telescope.builtin").colorscheme({
        enable_preview = true,
      })
    end, { noremap = true, desc = "Colorschemes" })

    -- Git

    G.nmap("<leader>gb", function()
      require("telescope.builtin").git_branches({
        previewer = false,
        layout_config = {
          horizontal = {
            size = { width = "60%", height = "50%" },
          },
        },
      })
    end, { noremap = true, desc = "All Git Branches" })

    G.nmap("<leader>gl", function()
      require("telescope.builtin").git_branches({
        previewer = false,
        show_remote_tracking_branches = false,
        layout_config = {
          horizontal = {
            size = { width = "60%", height = "50%" },
          },
        },
      })
    end, { noremap = true, desc = "Local Git Branches" })

    G.nmap("<leader>gs", function()
      require("telescope.builtin").git_stash({
        previewer = false,
      })
    end, { noremap = true, desc = "Git Stashes" })
  end,
  config = function()
    local mappings = {
      -- Do not scroll previewer on <c-u>. Instead perform the default
      -- action which is to clear the prompt.
      ["<c-u>"] = false,
      ["<c-]>"] = require("telescope.actions").cycle_history_next,
      ["<c-[>"] = require("telescope.actions").cycle_history_prev,
      ["<c-1>"] = require("telescope.actions.layout").toggle_preview,
      ["<c-2>"] = require("telescope.actions.layout").toggle_prompt_position,
      ["<c-3>"] = require("telescope.actions.layout").toggle_mirror,
      ["<c-4>"] = require("telescope.actions.layout").cycle_layout_next,
      ["<c-5>"] = require("telescope.actions.layout").cycle_layout_prev,
    }

    vim.api.nvim_create_autocmd("User", {
      pattern = "TelescopeFindPre",
      callback = function()
        vim.opt_local.winborder = "none"
        vim.api.nvim_create_autocmd("WinLeave", {
          once = true,
          callback = function()
            vim.opt_local.winborder = "single"
          end,
        })
      end,
    })

    require("telescope").setup({
      defaults = {
        prompt_prefix = "  ",
        selection_caret = " ",
        dynamic_preview_title = true,
        sorting_strategy = "ascending",
        mappings = { i = mappings, n = mappings },
        layout_strategy = "horizontal",
        create_layout = function(picker)
          local layouts = require("ah.plugins.telescope.layouts")
          local PickerLayout = require("telescope.pickers.layout")
          return PickerLayout(layouts[picker.layout_strategy](picker))
        end,
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
  end,
}
