-- :h dap.txt

-- TODO: https://github.com/igorlfs/nvim-dap-view
-- Resources
-- https://www.youtube.com/watch?v=Ul_WPhS2bis
-- https://theosteiner.de/debugging-javascript-frameworks-in-neovim

local function configure_vscode_js_debug_adapter()
  local dap = require("dap")

  -- `:h dap-adapter`.
  for _, type in ipairs({ "pwa-node", "pwa-chrome" }) do
    -- These configurations don't work with adapter names other than `pwa-*`
    -- prefixed ones. Not sure why because `nvim-dap` mentions in the
    -- documentation that the names are arbitrary.
    dap.adapters[type] = {
      -- `server` means connect to a debug adapter via TCP.
      type = "server",
      -- The default is `127.0.0.1` which doesn't work in my machine.
      host = "localhost",
      -- `${port}` resolves to a free port.
      port = "${port}",
      -- Launch the debug adapter on each new debug session and connect to it.
      executable = {
        command = "js-debug-adapter",
        -- `${port}` is replaced to the resolved free port above.
        args = { "${port}" },
      },
    }
  end

  -- See `:h dap-configuration`
  -- See https://code.visualstudio.com/docs/nodejs/nodejs-debugging#_launch-configuration-attributes
  local node_launch_config = {
    -- Type of configuration.
    request = "launch",
    -- Friendly name for this configuration.
    name = "Launch node for the current file and attach debug adapter to it",
    -- Which debug adapter to use
    type = "pwa-node",
    -- Absolute path to the runtime executable.
    runtimeExecutable = "node",
    -- Arguments passed to the runtime executable.
    runtimeArgs = {},
    -- Launch the debugee from this directory.
    cwd = "${workspaceFolder}",
    -- Absolute path to the debugee.
    program = "${file}",
    -- Arguments passed to the debugee.
    args = {},
    -- Use JS sourcemaps if available.
    sourceMaps = true,
    -- Locations from where source maps should be parsed.
    resolveSourceMapLocations = {
      "${workspaceFolder}/**",
      "!**/node_modules/**",
    },
    -- Avoid stepping into files inside these directories when debugging.
    skipFiles = {
      -- Skip built-in core node modules
      "<node_internals>/**",
      "node_modules/**",
    },
    -- TODO
    -- console = "",
  }

  -- See `:h dap-configuration`
  -- See https://code.visualstudio.com/docs/nodejs/browser-debugging
  -- sourceMaps = true,
  -- webRoot = "${workspaceFolder}",
  -- userDataDir = false,
  -- https://github.com/lakarpusky/react-vscode-brave-debug/blob/main/run-browser.sh
  local chrome_launch_config = {
    request = "launch",
    name = "Launch brave for the current file and attach debug adapter to it",
    type = "pwa-chrome",
    trace = true,
    url = "http://localhost:3000",
    runtimeExecutable = "/Users/ah/.nix-profile/bin/brave",
  }

  dap.configurations.javascript = { node_launch_config, chrome_launch_config }

  dap.configurations.javascriptreact = { node_launch_config, chrome_launch_config }

  dap.configurations.typescript = {
    -- vim.tbl_extend("force", vim.deepcopy(node_launch_config), {
    --   runtimeArgs = "--import tsx/esm",
    -- }),
    chrome_launch_config,
  }

  dap.configurations.typescriptreact = {
    vim.tbl_extend("force", vim.deepcopy(node_launch_config), {
      runtimeArgs = "--import tsx/esm",
    }),
    chrome_launch_config,
  }
end

vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" }, { confirm = false })
configure_vscode_js_debug_adapter()
local dap = require("dap")
vim.keymap.set("n", "<f5>", dap.continue, { desc = "Debug: continue" })
vim.keymap.set("n", "<f9>", dap.toggle_breakpoint, {
  desc = "Debug: toggle breakpoint",
})
vim.keymap.set("n", "<f10>", dap.step_over, { desc = "Debug: step over" })
vim.keymap.set("n", "<f11>", dap.step_into, { desc = "Debug: step into" })
vim.keymap.set("n", "<f12>", dap.step_out, { desc = "Debug: step out" })
