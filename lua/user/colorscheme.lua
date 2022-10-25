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

vim.g.NeoSolarized_lineNr = 0 -- 0 or 1 (default) -> To Show backgroung in LineNr
vim.g.Illuminate_useDeprecated = 1 -- Force old version illuminate behavior
vim.g.Illuminate_ftblacklist = { "NvimTree", "alpha", "Outline" } -- The filetype that illuminate will not work

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

vim.cmd([[
try
  colorscheme tokyonight "NeoSolarized
catch /^Vim\%((\a\+)\)\=:E185/
  colorscheme default
  set background=dark
endtry

augroup BgHighlight
  autocmd!
  highlight FloatBorder guibg=NONE ctermbg=NONE  " Removes the border of float menu (LSP and Autocompletion uses it)
  highlight link NormalFloat Normal
  highlight NormalFloat ctermbg=NONE ctermfg=NONE guibg=NONE guifg=NONE
  highlight Pmenu ctermbg=NONE guibg=NONE
  highlight ColorColumn guibg=238
  highlight IlluminatedWordText gui=bold cterm=bold guibg=#002b36
  highlight LspReferenceRead cterm=bold gui=bold
  highlight LineNr guifg=#737aa2
  highlight CursorLineNr guifg=#3b4261
augroup END
]])
