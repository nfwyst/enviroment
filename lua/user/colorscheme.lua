vim.api.nvim_exec("language en_US", false)

local ns_status_ok, NeoSolarized = pcall(require, "NeoSolarized")
if ns_status_ok then
	NeoSolarized.setup({
		style = "dark",
		transparent = true,
		terminal_colors = true,
		enable_italics = true,
		styles = {
			comments = { italic = true },
			keywords = { italic = false },
			functions = { bold = true },
			variables = {},
			string = { italic = true },
			underline = false,
			undercurl = false,
		},
	})
end

vim.g.NeoSolarized_lineNr = 0 -- 0 or 1 (default) -> To Show background in LineNr

local status_ok, tokyonight = pcall(require, "tokyonight")
if status_ok then
	tokyonight.setup({
		transparent = true,
		styles = {
			floats = "transparent",
			sidebars = "transparent",
		},
	})
end

local theme_ok, _ = pcall(vim.cmd, "colorscheme tokyonight")
vim.opt.background = "dark"
if not theme_ok then
	vim.cmd("colorscheme NeoSolarized")
end

local ill_status_ok, illuminate = pcall(require, "illuminate")
if not ill_status_ok then
	return
end
illuminate.configure({
	filetypes_denylist = FILETYPE_EXCLUDE,
	large_file_cutoff = max_file_length,
	min_count_to_highlight = 2,
	under_cursor = false,
})

local Visual_gray = "#3E4452"
vim.api.nvim_set_hl(0, "Pmenu", { ctermbg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "Normal", { bg = "NONE" })
vim.api.nvim_set_hl(0, "NormalFloat", { bg = "NONE" })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#737aa2" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#dddddd" })
vim.api.nvim_set_hl(0, "ColorColumn", {
	bg = Visual_gray,
	fg = Visual_gray,
	sp = Visual_gray,
	nocombine = true,
})
