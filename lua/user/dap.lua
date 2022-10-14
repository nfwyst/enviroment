local dvj_ok, dvj = pcall(require, "dap-vscode-js")
local dvt_ok, dvt = pcall(require, "nvim-dap-virtual-text")
local ui_ok, ui = pcall(require, "dapui")
local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

local cwd = vim.fn.getcwd()
local before_listener = dap.listeners.before
local signs = {
	{ name = "DapBreakpoint", text = "🟥" },
	{ name = "DapStopped", text = "🟦" },
}
for _, sign in ipairs(signs) do
	vim.fn.sign_define(sign.name, { text = sign.text, numhl = "" })
end

if dvt_ok then
	dvt.setup()
end

if ui_ok then
	ui.setup()
	local function close_ui()
		ui.close()
	end

	before_listener.event_terminated["dapui_config"] = close_ui
	before_listener.event_exited["dapui_config"] = close_ui
end

if not dvj_ok then
	return
end

dvj.setup({
	node_path = "/usr/local/bin/node",
	adapters = { "pwa-node", "pwa-chrome", "pwa-msedge", "node-terminal", "pwa-extensionHost" },
})

function _G.debug_node()
	print("attaching node")
	dap.run({
		type = "pwa-node",
		request = "attach",
		name = "Attach",
		processId = require("dap.utils").pick_process,
		cwd = cwd,
		sourceMaps = true,
		skipFiles = { "<node_internals>/**/*.js" },
	})
end

function _G.debug_jest()
	print("starting jest")
	dap.run({
		type = "pwa-node",
		request = "launch",
		name = "Debug Jest Tests",
		-- trace = true, -- include debugger info
		runtimeExecutable = "node",
		runtimeArgs = {
			"./node_modules/jest/bin/jest.js",
			"--runInBand",
		},
		rootPath = cwd,
		cwd = cwd,
		console = "integratedTerminal",
		internalConsoleOptions = "neverOpen",
		sourceMaps = true,
		skipFiles = { "<node_internals>/**/*.js" },
	})
end
