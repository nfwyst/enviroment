vim.defer_fn(function()
	require("close_buffers").setup({
		next_buffer_cmd = function(windows)
			local status_ok, bufferline = pcall(require, "bufferline")
			if not status_ok then
				return
			end
			bufferline.cycle(-1)
			local bufnr = vim.api.nvim_get_current_buf()

			for _, window in ipairs(windows) do
				vim.api.nvim_win_set_buf(window, bufnr)
			end
		end,
	})
end, 100)
