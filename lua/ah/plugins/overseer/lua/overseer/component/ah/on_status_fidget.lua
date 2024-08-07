return {
  desc = "Notify via fidget.nvim when task changes status",
  constructor = function()
    local ok_fidget, fidget = pcall(require, "fidget")
    if not ok_fidget then
      return {}
    end

    local progress = require("fidget.progress")
    local spinner = require("fidget.spinner")
    local notification = require("fidget.notification")
    local display = fidget.options.progress.display
    local overrides = display.overrides.overseer.states

    local states = G.merge({
      RUNNING = {
        message = display.format_message({ done = false }),
        level = vim.log.levels.INFO,
        icon = spinner.animate(unpack(vim.tbl_values(display.progress_icon))),
      },
      SUCCESS = {
        message = "Success...",
        level = vim.log.levels.INFO,
        icon = display.done_icon,
      },
      CANCELED = { message = "Canceled...", level = vim.log.levels.WARN },
      FAILURE = { message = "Failed...", level = vim.log.levels.ERROR },
    }, overrides)

    return {
      on_init = function(self, task)
        notification.set_config(task.name, progress.display.make_config("overseer"), false)
      end,
      on_status = function(self, task, status)
        local args = vim.tbl_get(states, status)
        notification.notify(args.message, args.level, {
          key = task.id,
          group = task.name,
          annote = task.name,
          update_only = false,
          ttl = status == "RUNNING" and math.huge or 0,
          data = { icon = args.icon },
        })
      end,
      on_dispose = function(self, task)
        notification.clear(task.name)
      end,
    }
  end,
}
