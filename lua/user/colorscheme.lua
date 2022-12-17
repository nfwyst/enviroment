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

vim.api.nvim_set_hl(0, "Pmenu", { ctermbg = "NONE", bg = "NONE" })
vim.api.nvim_set_hl(0, "ColorColumn", { bg = 238 })
vim.api.nvim_set_hl(0, "LspReferenceRead", { bold = true })
vim.api.nvim_set_hl(0, "LineNr", { fg = "#737aa2" })
vim.api.nvim_set_hl(0, "CursorLineNr", { fg = "#dddddd" })
