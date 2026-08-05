local ranges_ns_id = vim.api.nvim_create_namespace("MiniPickRanges_fff")

-- TODO: Respect options passed through local_opts
-- TODO: Ignore current file
return function (_local_opts)
  -- -- Cache current file to deprioritize in fff.nvim
  -- if not state.current_file_cache then
  --   local current_buf = vim.api.nvim_get_current_buf()
  --   if current_buf and vim.api.nvim_buf_is_valid(current_buf) then
  --     local current_file = vim.api.nvim_buf_get_name(current_buf)
  --     if current_file ~= "" and vim.fn.filereadable(current_file) == 1 then
  --       local relative_path = vim.fs.relpath(vim.uv.cwd(), current_file)
  --       state.current_file_cache = relative_path
  --     else
  --       state.current_file_cache = nil
  --     end
  --   end
  -- end

  require("mini.pick").start({
    source = {
      name = "Files (fff)",
      items = {},
      match = function (_, _, query)
        local result = require("fff").file_search(table.concat(query))
        for _, item in ipairs(result.items) do
          -- Set "path" on item so default actions work. See |MiniPick-source.items-common}
          item['path'] = item.relative_path
        end
        require("mini.pick").set_picker_items(result.items, { do_match = false })
      end,
      show = function (buf_id, items)
        local buf_lines = vim.iter(items):map(function (item)
          local icon, _, _ = require("mini.icons").get("file", item.name)
          return string.format(" %s %s ", icon, item.relative_path)
        end):totable()

        -- Set buffer contents
        vim.api.nvim_buf_set_lines(buf_id, 0, -1, false, buf_lines)

        -- Clear previous matches ranges highlights
        vim.api.nvim_buf_clear_namespace(buf_id, ranges_ns_id, 0, -1)

        -- Add matches ranges highlights
        local prefix_len = 6 -- Length of prefix text before file path starts
        for row, item in ipairs(items) do
          for _, range in ipairs(item.match_ranges) do
            local start_col = range[1] + prefix_len
            local end_col = range[2] + prefix_len
            vim.api.nvim_buf_set_extmark(buf_id, ranges_ns_id, row - 1, start_col, {
              hl_group = "MiniPickMatchRanges",
              hl_mode = "combine",
              priority = 300,
              end_col = end_col,
            })
          end
        end
      end,
    },
  })

  -- state.current_file_cache = nil -- Reset cache
end
