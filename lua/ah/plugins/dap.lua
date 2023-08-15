local M = {
  "https://github.com/mfussenegger/nvim-dap",
  lazy = true,
  dependencies = {
    "https://github.com/rcarriga/nvim-dap-ui",
    "https://github.com/mxsdev/nvim-dap-vscode-js",
  },
}

function M.init()
  nmap("<leader>dc", function()
    require("dap").continue()
  end, { desc = "[D]ebugger [C]continue" })

  nmap("<leader>do", function()
    require("dap").step_over()
  end, { desc = "[D]ebugger Step [O]ver" })

  nmap("<leader>di", function()
    require("dap").step_into()
  end, { desc = "[D]ebugger Step [I]nto" })

  nmap("<leader>du", function()
    require("dap").step_out()
  end, { desc = "[D]ebugger Step O[u]t" })

  nmap("<leader>db", function()
    require("dap").toggle_breakpoint()
  end, { desc = "[D]ebugger [B]reakpoint" })

  nmap("<leader>dr", function()
    require("dap").repl.open()
  end, { desc = "[D]ebugger [R]epl" })

  nmap("<leader>dw", function()
    require("dap.ui.widgets").hover()
  end, { desc = "Widgets" })

  nmap("<leader>du", function()
    require("dapui").toggle()
  end, { desc = "Dap UI" })
end

function M.config()
  require("dap-vscode-js").setup({
    adapters = { "pwa-node" },
    debugger_path = fn.stdpath("data") .. "/mason/bin/js-debug-adapter", -- Path to VSCode Debugger
    debugger_cmd = { "js-debug-adapter" },
  })

  -- https://theosteiner.de/debugging-javascript-frameworks-in-neovim
  for _, lang in ipairs({ "javascript", "typescript" }) do
    require("dap").configurations[lang] = {
      {
        -- Launch a node process for the current file and attach debugger to it
        name = "Launch nodejs javascript file",
        -- Use nvim-dap-vscode-js's pwa-node debug adapter
        type = "pwa-node",
        -- Launch a new process to attach the debugger to
        request = "launch",
        -- Launch current file
        program = "${file}",
        cwd = "${workspaceFolder}",
        -- Do not debug code inside node_modules
        skipFiles = { "${workspaceFolder}/node_modules/**" },
      },
      {
        -- Attach to a node process that has been started with `--inspect` for
        -- long running tasks or `--inspect-brk` for short tasks
        name = "Attach debugger to existing node process",
        -- Use nvim-dap-vscode-js's pwa-node debug adapter
        type = "pwa-node",
        -- Attach to an already running node process with `--inspect` flag
        -- Default port: 9222
        request = "attach",
        -- Allows us to pick the process using a picker
        processId = require("dap.utils").pick_process,
        -- For compiled languages like TypeScript or Svelte.js
        sourceMaps = true,
        -- Resolve source maps in nested locations while ignoring node_modules
        resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
        -- Path to src in vite based projects (and most other projects as well)
        cwd = "${workspaceFolder}/src",
        -- Do not debug code inside node_modules
        skipFiles = { "${workspaceFolder}/node_modules/**" },
      },
      {
        name = "Vitest Debug",
        type = "pwa-node",
        request = "launch",
        cwd = fn.getcwd(),
        program = "${workspaceFolder}/node_modules/vitest/vitest.mjs",
        args = { "--threads", "false", "run", "${file}" },
        autoAttachChildProcesses = true,
        smartStep = true,
        console = "integratedTerminal",
        skipFiles = { "<node_internals>/**", "node_modules/**" },
      },
      {
        type = "pwa-node",
        request = "attach",
        name = "Attach",
        processId = require("dap.utils").pick_process,
        cwd = "${workspaceFolder}",
      },
    }
  end

  require("dapui").setup()

  require("dap").listeners.after.event_initialized["dapui_config"] = function()
    require("dapui").open({ reset = true })
  end
  require("dap").listeners.before.event_terminated["dapui_config"] = require("dapui").close
  require("dap").listeners.before.event_exited["dapui_config"] = require("dapui").close
end

return M
