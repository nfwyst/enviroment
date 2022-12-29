vim.defer_fn(function()
	require("copilot_cmp").setup({
		method = "getCompletionsCycling",
		formatters = {
			label = require("copilot_cmp.format").format_label_text,
			insert_text = require("copilot_cmp.format").format_insert_text,
			preview = require("copilot_cmp.format").deindent,
		},
	})
end, 100)

vim.api.nvim_set_hl(0, "CmpItemKindCopilot", { fg = "#6CC644" })
