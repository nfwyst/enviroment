local status_ok, dap = pcall(require, "dap")
if not status_ok then
	return
end

local status, dap_utils = pcall(require, "dap.utils")
if not status then
	return
end

dap.adapters.js = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. ".local/share/nvim/dev/microsoft/vscode-js-debug/out/src/debugServer.js" },
}

dap.configurations.javascript = {
	{
		name = "Launch",
		type = "js",
		request = "launch",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		-- For this to work you need to make sure the node process is started with the `--inspect` flag.
		name = "Attach to process",
		type = "js",
		request = "attach",
		processId = dap_utils.pick_process,
	},
}

dap.configurations.javascriptreact = { -- change this to javascript if needed
	{
		type = "js",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}

dap.configurations.typescriptreact = { -- change to typescript if needed
	{
		type = "js",
		request = "attach",
		program = "${file}",
		cwd = vim.fn.getcwd(),
		sourceMaps = true,
		protocol = "inspector",
		port = 9222,
		webRoot = "${workspaceFolder}",
	},
}
