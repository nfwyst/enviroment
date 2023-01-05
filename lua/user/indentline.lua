local status_ok, indent_blankline = pcall(require, "indent_blankline")
if not status_ok then
	return
end

vim.g.indent_blankline_buftype_exclude = { "terminal", "nofile" }
vim.g.indent_blankline_filetype_exclude = FILETYPE_EXCLUDE
vim.g.indentLine_enabled = 1
vim.g.indent_blankline_char = "▏" -- ┊
vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_show_first_indent_level = false
vim.g.indent_blankline_use_treesitter = true
vim.g.indent_blankline_show_current_context = true
vim.g.indent_blankline_context_patterns = {
	"class",
	"return",
	"function",
	"method",
	"^if",
	"^while",
	"jsx_element",
	"^for",
	"^object",
	"^table",
	"block",
	"arguments",
	"if_statement",
	"else_clause",
	"jsx_element",
	"jsx_self_closing_element",
	"try_statement",
	"catch_clause",
	"import_statement",
	"operation_type",
}

vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#777777", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineContextSpaceChar", { nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineIndent", { fg = "#666666", nocombine = true })

indent_blankline.setup({
	show_current_context = true,
	char_highlight_list = {
		"IndentBlanklineIndent",
	},
})
