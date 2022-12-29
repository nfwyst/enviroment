vim.defer_fn(function()
	require("copilot").setup({
		panel = {
			enabled = true,
			keymap = {
				refresh = "<leader>Cr",
				open = "<leader>Co",
			},
		},
		suggestion = {
			enabled = true,
			keymap = {
				accept = "<C-j>",
				dismiss = "<C-e>",
			},
		},
	})
end, 100)
