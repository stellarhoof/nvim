-- :h dap.txt

-- DAP-Client ----- Debug Adapter ------- Debugger ------ Debugee
-- (nvim-dap)  |   (per language)  |   (per language)    (your app)
--             |                   |
--             |        Implementation specific communication
--             |        Debug adapter and debugger could be the same process
--             |
--      Communication via the Debug Adapter Protocol

-- Resources
-- https://www.youtube.com/watch?v=Ul_WPhS2bis
-- https://theosteiner.de/debugging-javascript-frameworks-in-neovim

return {
	"https://github.com/mfussenegger/nvim-dap",
	dependencies = { "https://github.com/mxsdev/nvim-dap-vscode-js" },
	config = function()
		local dap = require("dap")

		-- require("dap-vscode-js").setup({
		-- 	adapters = { "pwa-node" },
		-- 	debugger_cmd = { "js-debug-adapter" },
		-- 	port = "${port}",
		-- })
		--
		-- -- https://theosteiner.de/debugging-javascript-frameworks-in-neovim
		-- for _, lang in ipairs({ "javascript", "typescript" }) do
		-- 	require("dap").configurations[lang] = {
		-- 		{
		-- 			type = "pwa-node",
		-- 			request = "launch",
		-- 			name = "Launch file",
		-- 			program = "${file}",
		-- 			cwd = vim.fn.getcwd(),
		-- 			sourceMaps = true,
		-- 		},
		-- 	}
		-- end

		-- Neovim needs a debug adapter with which it can communicate. Neovim can
		-- either launch the debug adapter itself, or it can attach to an existing
		-- one.

		dap.adapters["node-adapter"] = {
			type = "server",
			host = "127.0.0.1",
			-- Use random free port
			port = "${port}",
			-- Should be installed with Mason
			executable = { command = "js-debug-adapter", args = { "${port}" } },
		}

		dap.adapters["chrome-adapter"] = {
			type = "executable",
			command = "node",
			-- Should be installed with Mason
			executable = { command = "chrome-debug-adapter" },
		}

		-- In addition to launching (possibly) and connecting to a debug adapter,
		-- Neovim needs to instruct the debug adapter itself how to launch and
		-- connect to the debugee. The debugee is the application you want to debug.
		dap.configurations.javascript = {
			-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#vscode-js-debug
			{
				type = "node-adapter",
				request = "launch",
				name = "Launch a node process for the current file and attach debugger to it.",
				cwd = "${workspaceFolder}",
				program = "${file}",
			},
			{
				type = "node-adapter",
				request = "attach",
				name = "Attach debugger to a node process started with `--inspect`.",
				cwd = "${workspaceFolder}",
				skipFiles = { "${workspaceFolder}/node_modules/**" },
				processId = require("dap.utils").pick_process,
				sourceMaps = true,
				resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
			},
			-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#javascript-chrome
			{
				type = "chrome-adapter",
				request = "attach",
				name = "Attach debugger to a chrome instance started with `--inspect`.",
				program = "${file}",
				cwd = vim.fn.getcwd(),
				sourceMaps = true,
				resolveSourceMapLocations = { "${workspaceFolder}/**", "!**/node_modules/**" },
				protocol = "inspector",
				port = 9222,
				webRoot = "${workspaceFolder}",
			},
		}

		dap.configurations.javascriptreact = dap.configurations.javascript
		dap.configurations.typescript = dap.configurations.javascript
		dap.configurations.typescriptreact = dap.configurations.javascript

		nmap("<f5>", dap.continue, { desc = "Debug: continue" })
		nmap("<f9>", dap.toggle_breakpoint, { desc = "Debug: toggle breakpoint" })
		nmap("<f10>", dap.step_over, { desc = "Deubg: step over" })
		nmap("<f11>", dap.step_into, { desc = "Debug: step into" })
		nmap("<f12>", dap.step_out, { desc = "Debug: step out" })
	end,
}
