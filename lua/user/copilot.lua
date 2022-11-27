local options = {
	copilot_proxy = "localhost:7890",
}

for k, v in pairs(options) do
	vim.g[k] = v
end
