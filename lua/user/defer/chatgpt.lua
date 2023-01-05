vim.defer_fn(function()
	require("chatgpt").setup({
		max_line_length = 2048,
		keymaps = {
			close = { "<Esc>", "<C-c>" },
			yank_last = "<C-y>",
			scroll_up = "<C-b>",
			scroll_down = "<C-f>",
			toggle_settings = "<C-o>",
			new_session = "<C-n>",
			cycle_windows = "<Tab>",
		},
		openai_params = {
			max_tokens = 2048,
		},
	})
end, 100)
