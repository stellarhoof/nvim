-- Use mini.snippets to expand single snippet or autocomplete available snippets
local function expand_snippet(cmp)
  if _G.MiniSnippets == nil then
    return
  end

  -- Get snippets matched at cursor
  local snippets = MiniSnippets.expand({ insert = false })
  if snippets == nil then
    return
  end

  -- A single snippet was matched so expand it right away
  if #snippets == 1 then
    local expand = MiniSnippets.config.expand.insert or MiniSnippets.default_insert
    if cmp.is_visible() then
      cmp.hide({
        callback = function()
          expand(snippets[1])
        end,
      })
    else
      vim.schedule(function()
        expand(snippets[1])
      end)
    end
  end

  -- More than a single snippet was matched so autocomplete options
  if #snippets > 1 then
    cmp.show({
      providers = { "snippets" },
      callback = function()
        -- Automatically show documentation upon opening the snippets completion menu
        cmp.show_documentation()
      end,
    })
  end
end

return {
  "https://github.com/saghen/blink.cmp",
  -- Use a release tag to download pre-built binaries
  version = "1.*",
  opts_extend = { "sources.default" },
  dependencies = {
    {
      "https://github.com/zbirenbaum/copilot.lua",
      opts = {
        suggestion = { enabled = false },
        panel = { enabled = false },
      },
    },
    {
      "https://github.com/fang2hou/blink-copilot",
    },
  },
  opts = {
    keymap = {
      --[[
      Mappings in the `enter` preset:
      - <cr>: Accept completion
      - <c-n>: Select next item
      - <c-p>: Select previous item
      - <c-e>: Hide menu
      - <c-k>: Toggle signature help if `signature.enabled`
      - <c-space>: Open menu or open docs if menu is already open
      --]]
      preset = "enter",

      -- Unset mappings
      ["<tab>"] = {}, -- Jump to the next snippet tabstop.
      ["<s-tab>"] = {}, -- Jump to the previous snippet tabstop.

      -- Expand single snippet or autocomplete available snippets
      ["<c-j>"] = { expand_snippet },
    },
    snippets = {
      -- Use `mini.snippets` for loading, expanding, and jumping snippets.
      preset = "mini_snippets",
    },
    appearance = {
      -- 'mono' (default) for 'Nerd Font Mono' or 'normal' for 'Nerd Font'
      -- Adjusts spacing to ensure icons are aligned.
      nerd_font_variant = "normal",
    },
    completion = {
      documentation = {
        auto_show = false,
      },
      menu = {
        max_height = 20,
        auto_show = function()
          local row, column = unpack(vim.api.nvim_win_get_cursor(0))
          local success, node = pcall(vim.treesitter.get_node, {
            pos = { row - 1, math.max(0, column - 1) },
            ignore_injections = true,
          })
          -- Do not show menu when inside any of these node types
          local reject = {
            "comment",
            "line_comment",
            "block_comment",
            "string_start",
            "string_content",
            "string_end",
          }
          if success and node and vim.tbl_contains(reject, node:type()) then
            return false
          end
          return true
        end,
        draw = {
          components = {
            -- Column showing imports
            label_description = {
              width = { max = 60 },
            },
          },
        },
      },
    },
    -- Default list of enabled providers defined so that you can extend it
    -- elsewhere in your config, without redefining it, due to `opts_extend`.
    sources = {
      default = { "lsp", "copilot", "path", "buffer" },
      per_filetype = { codecompanion = { "codecompanion" } },
      providers = {
        buffer = {
          enabled = function()
            return not vim.tbl_contains({ "DressingInput" }, vim.bo.filetype)
          end,
        },
        copilot = {
          name = "copilot",
          module = "blink-copilot",
          score_offset = 100,
          async = true,
        },
      },
    },
    -- (Default) Rust fuzzy matcher for typo resistance and significantly better
    -- performance You may use a lua implementation instead by using
    -- `implementation = "lua"` or fallback to the lua implementation, when the
    -- Rust fuzzy matcher is not available, by using `implementation =
    -- "prefer_rust"`.
    --
    -- See the fuzzy documentation for more information.
    fuzzy = { implementation = "prefer_rust_with_warning" },
  },
}
