vim.defer_fn(function()
	require("no-neck-pain").setup({
		width = 86,
		buffers = {
			backgroundColor = "catppuccin-frappe",
			textColor = "#777777",
		},
		integrations = {
			NvimTree = {
				position = "right",
			},
		},
	})
end, 100)
