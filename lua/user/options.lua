local opt = vim.opt
local options = {
	clipboard = "unnamedplus", -- allows neovim to access the system clipboard
	completeopt = { "menuone", "noselect" }, -- mostly just for cmp
	fileencoding = "utf-8", -- the encoding written to a file
	fileencodings = "utf-8", -- the encoding written to a file
	encoding = "utf-8", -- the encoding written to a file
	ignorecase = true, -- ignore case in search patterns
	mouse = "a", -- allow the mouse to be used in neovim
	pumheight = 7, -- pop up menu height
	showmode = false, -- we don't need to see things like -- INSERT -- anymore
	showtabline = 2, -- always show tabs
	smartcase = true, -- smart case
	smartindent = true, -- make indenting smarter again
	splitbelow = true, -- force all horizontal splits to go below current window
	splitright = true, -- force all vertical splits to go to the right of current window
	swapfile = false, -- creates a swapfile
	termguicolors = true, -- set term gui colors (most terminals support this)
	timeoutlen = 300, -- time to wait for a mapped sequence to complete (in milliseconds)
	undofile = true, -- enable persistent undo
	updatetime = 300, -- faster completion (4000ms default)
	writebackup = false, -- if a file is being edited by another program (or was written to file while editing with another program), it is not allowed to be edited
	expandtab = true, -- enable convert tabs to spaces
	shiftwidth = 2, -- the number of spaces inserted for each indentation
	tabstop = 2, -- specify character width for a tab
	softtabstop = 2, -- insert 2 spaces for a tab
	cursorline = true, -- highlight the current line
	number = true, -- set numbered lines
	relativenumber = true, -- enable relative number
	numberwidth = 2, -- set number column width to 2 {default 4}
	signcolumn = "yes", -- always show the sign column, otherwise it would shift the text each time
	wrap = false, -- display lines as one long line
	linebreak = true, -- wrap by word
	scrolloff = 99999, -- is one of my fav
	sidescrolloff = 8, -- scroll left to right
	inccommand = "split", -- show preview in split window when in %s mode to replace something
	lazyredraw = true, -- don't redraw while executing macros (good performance config)
	redrawtime = 7000, -- redraw timeout, otherwise to set syntax off
	title = true, -- show title
	ch = 0, -- automatically hide and show command line
	spell = false, -- enable builtin spell check that work with treesitter, so it can do well in comment spell checking
	laststatus = 3, -- enable global status line
	foldmethod = "expr", -- gives the fold level from foldexpr for a line
	foldexpr = "nvim_treesitter#foldexpr()", -- enable treesitter experimental fold level,
	foldlevel = 99, -- dont open fold at starting up
	foldnestmax = 7, -- fold nest dont more than 2, default limit is 20
	shortmess = opt.shortmess + "c", -- don't give ins-completion-menu messages
	whichwrap = opt.whichwrap + "<,>,[,],h,l", -- keys that allow move the cursor to previous/next line
	guicursor = "", -- keep cursor block
	colorcolumn = "81", -- number of column that should be highlight
}

for k, v in pairs(options) do
	opt[k] = v
end

local global_options = {
	loaded = true,
	loaded_netrwPlugin = true,
	copilot_proxy = "localhost:7890",
	copilot_no_tab_map = true,
	copilot_suggestion_hidden = true,
	user_emmet_mode = "i",
	user_emmet_install_global = 0,
}

for k, v in pairs(global_options) do
	vim.g[k] = v
end

FILETYPE_EXCLUDE = {
	"NvimTree",
	"alpha",
	"Outline",
	"dashboard",
	"qf",
	"help",
	"man",
	"lspinfo",
	"gitcommit",
	"TelescopePrompt",
	"spectre_panel",
	"startify",
	"packer",
	"neogitstatus",
	"Trouble",
	"",
	nil,
}
