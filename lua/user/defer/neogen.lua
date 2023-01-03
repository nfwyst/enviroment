vim.defer_fn(function()
	require("neogen").setup({
		enabled = true,
		snippet_engine = "luasnip",
	})
end, 100)
