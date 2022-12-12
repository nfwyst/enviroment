local status_ok, util = pcall(require, "lspconfig/util")
if not status_ok then
	return {}
end

return {
	root_dir = function(pattern)
		local cwd = vim.loop.cwd()
		local root = util.root_pattern(".git")(pattern)
		-- local root = util.root_pattern("package.json", "tsconfig.json", ".git")(pattern)
		return root or cwd
	end,
	settings = {
		diagnostics = {
			ignoredCodes = { 7016, 80001, 80006, 80007, 2305 },
		},
	},
}
