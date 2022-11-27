local status_ok, which_key = pcall(require, "which-key")
if not status_ok then
	return
end

local setup = {
	plugins = {
		marks = true, -- shows a list of your marks on ' and `
		registers = true, -- shows your registers on " in NORMAL or <C-r> in INSERT mode
		spelling = {
			enabled = true, -- enabling this will show WhichKey when pressing z= to select spelling suggestions
			suggestions = 20, -- how many suggestions should be shown in the list?
		},
		-- the presets plugin, adds help for a bunch of default keybindings in Neovim
		-- No actual key bindings are created
		presets = {
			operators = false, -- adds help for operators like d, y, ... and registers them for motion / text object completion
			motions = true, -- adds help for motions
			text_objects = true, -- help for text objects triggered after entering an operator
			windows = true, -- default bindings on <c-w>
			nav = true, -- misc bindings to work with windows
			z = true, -- bindings for folds, spelling and others prefixed with z
			g = true, -- bindings for prefixed with g
		},
	},
	-- add operators that will trigger motion and text object completion
	-- to enable all native operators, set the preset / operators plugin above
	-- operators = { gc = "Comments" },
	key_labels = {
		-- override the label used to display some keys. It doesn't effect WK in any other way.
		-- For example:
		-- ["<space>"] = "SPC",
		-- ["<cr>"] = "RET",
		-- ["<tab>"] = "TAB",
	},
	icons = {
		breadcrumb = "»", -- symbol used in the command line area that shows your active key combo
		separator = "➜", -- symbol used between a key and it's label
		group = "+", -- symbol prepended to a group
	},
	popup_mappings = {
		scroll_down = "<c-d>", -- binding to scroll down inside the popup
		scroll_up = "<c-u>", -- binding to scroll up inside the popup
	},
	window = {
		border = "rounded", -- none, single, double, shadow
		position = "bottom", -- bottom, top
		margin = { 1, 0, 1, 0 }, -- extra window margin [top, right, bottom, left]
		padding = { 2, 2, 2, 2 }, -- extra window padding [top, right, bottom, left]
		winblend = 0,
	},
	layout = {
		height = { min = 4, max = 25 }, -- min and max height of the columns
		width = { min = 20, max = 50 }, -- min and max width of the columns
		spacing = 3, -- spacing between columns
		align = "left", -- align columns left, center or right
	},
	ignore_missing = true, -- enable this to hide mappings for which you didn't specify a label
	hidden = { "<silent>", "<cmd>", "<Cmd>", "<CR>", "call", "lua", "^:", "^ " }, -- hide mapping boilerplate
	show_help = true, -- show help message on the command line when the popup is visible
	triggers = "auto", -- automatically setup triggers
	-- triggers = {"<leader>"} -- or specify a list manually
	triggers_blacklist = {
		-- list of mode / prefixes that should never be hooked by WhichKey
		-- this is mostly relevant for key maps that start with a native binding
		-- most people should not need to change this
		i = { "j", "k" },
		v = { "j", "k" },
	},
}

local opts = {
	mode = "n", -- NORMAL mode
	prefix = "<leader>",
	buffer = nil, -- Global mappings. Specify a buffer number for buffer local mappings
	silent = true, -- use `silent` when creating keymaps
	noremap = true, -- use `noremap` when creating keymaps
	nowait = true, -- use `nowait` when creating keymaps
}

local gopts = vim.tbl_deep_extend("force", opts, { prefix = "g" })

local gmappings = {
	["D"] = { "<cmd>lua vim.lsp.buf.declaration()<cr>", "Go to declaration" },
	["d"] = { "<cmd>lua vim.lsp.buf.definition()<cr>", "Go to definition" },
	["I"] = { "<cmd>lua vim.lsp.buf.implementation()<cr>", "Go to implementation" },
	["r"] = { "<cmd>Telescope lsp_references<cr>", "Go to references" },
	["l"] = { '<cmd>lua vim.diagnostic.open_float({ border = "rounded" })<cr>', "Show diagnostic" },
	["k"] = { "<cmd>lua vim.lsp.buf.hover()<cr>", "Show hover info" },
	["K"] = { "<cmd>lua vim.lsp.buf.signature_help()<cr>", "Show signature help" },
	["o"] = { "<c-o>", "Jump back" },
	["t"] = { "<c-t>", "Go back" },
}

local mappings = {
	["a"] = { "<cmd>Alpha<cr>", "Alpha" },
	["b"] = {
		"<cmd>lua require('telescope.builtin').buffers(require('telescope.themes').get_dropdown{previewer = false})<cr>",
		"Buffers",
	},
	["e"] = { "<cmd>NvimTreeToggle<cr>", "Explorer" },
	["E"] = { "<cmd>NvimTreeFindFile<cr>", "Show file in explorer" },
	["w"] = { "<cmd>w!<CR>", "Save" },
	["x"] = { "<cmd>x<cr>", "Save and quit" },
	["q"] = { "<cmd>q!<CR>", "Quit" },
	["c"] = { "<cmd>Bdelete!<CR>", "Close Buffer" },
	["h"] = { "<cmd>nohlsearch<CR>", "No Highlight" },
	["f"] = {
		":Telescope find_files<cr>",
		"Find files",
	},
	["F"] = { "<cmd>Telescope live_grep theme=ivy<cr>", "Find Text" },
	["P"] = { "<cmd>lua require('telescope').extensions.projects.projects()<cr>", "Projects" },
	["r"] = "Code runner",
	["o"] = { "<cmd>SymbolsOutline<cr>", "Outline" },
	["O"] = { "<cmd>lua vim.fn.system({'open', vim.fn.expand('%')})<cr>", "Open current file" },
	["v"] = { "<cmd>e $MYVIMRC<cr>", "Open init.lua" },
	["S"] = { "<cmd>e " .. vim.fn.stdpath("data") .. "/custom-snippets/package.json<cr>", "Open custom snippets" },
	["T"] = { "<cmd>CmpTabnineHub<cr>", "Open tabnine hub" },
	["n"] = { "<cmd>set ignorecase!<cr>", "Toggle case sensitive" },

	C = {
		name = "Copilot",
		d = { "<cmd>Copilot disable<cr>", "Disable copilot" },
		e = { "<cmd>Copilot enable<cr>", "Enable copilot" },
		i = { "<cmd>Copilot setup<cr>", "Authenticate and enable GitHub Copilot" },
		s = { "<cmd>Copilot status<cr>", "Check copilot status" },
		p = { "<cmd>Copilot panel<cr>", "Open more completions" },
	},

	d = {
		name = "Debug",
		b = { "<cmd>DapToggleBreakpoint<cr>", "Set breakpoint" },
		B = {
			"<cmd>lua require 'dap'.set_breakpoint(vim.fn.input('Breakpoint condition: '))<cr>",
			"Set breakpoint condition",
		},
		o = { "<cmd>DapStepOut<cr>", "Step out" },
		i = { "<cmd>DapStepInto<cr>", "Step Into" },
		v = { "<cmd>DapStepOver<cr>", "Step Over" },
		c = { "<cmd>DapContinue<cr>", "Continue" },
		u = { "<cmd>lua require 'dap'.run_to_cursor()<cr>", "Run to cursor" },
		t = { "<cmd>DapTerminate<cr>", "Terminate" },
		R = { "<cmd>lua require 'dap'.clear_breakpoints()<cr>", "Clear breakpoint" },
		e = { "<cmd>lua require 'dap'.set_exception_breakpoints({'all'})<cr>", "Debug set exception breakpoint" },
		n = { "<cmd>lua debug_node()<cr>", "Debug node" },
		J = { "<cmd>lua debug_jest()<cr>", "Debug jest" },
		h = { "<cmd>lua require 'dap.ui.widgets'.hover()<cr>", "Hover" },
		s = {
			"<cmd>lua local widgets = require 'dap.ui.widgets'; widgets.centered_float(widgets.scopes)<cr>",
			"Scopes",
		},
		k = { "<cmd>lua require 'dap'.Up()<cr>zz", "up" },
		j = { "<cmd>lua require 'dap'.Down()<cr>zz", "down" },
		r = { "<cmd>lua require 'dap'.repl.open({}, 'vsplit')<cr><c-w>l", "Open repl" },
		f = { "<cmd>Telescope dap frames<cr>", "Dap frames" },
		l = { "<cmd>Telescope dap list_breakpoints<cr>", "List breakpoints" },
		O = { "<cmd>lua require 'dapui'.open()<cr>", "Open UI" },
		C = { "<cmd>lua require 'dapui'.close()<cr>", "Close UI" },
	},

	p = {
		name = "Packer",
		c = { "<cmd>PackerCompile<cr>", "Compile" },
		i = { "<cmd>PackerInstall<cr>", "Install" },
		s = { "<cmd>PackerSync<cr>", "Sync" },
		S = { "<cmd>PackerStatus<cr>", "Status" },
		u = { "<cmd>PackerUpdate<cr>", "Update" },
		t = { "<cmd>TSPlaygroundToggle<cr>", "TS playground" },
		h = { "<cmd>TSHighlightCapturesUnderCursor<cr>", "Highlight group capture" },
	},

	g = {
		name = "Git",
		g = { "<cmd>lua _LAZYGIT_TOGGLE()<CR>", "Lazygit" },
		j = { "<cmd>lua require 'gitsigns'.next_hunk()<cr>", "Next Hunk" },
		k = { "<cmd>lua require 'gitsigns'.prev_hunk()<cr>", "Prev Hunk" },
		l = { "<cmd>lua require 'gitsigns'.blame_line()<cr>", "Blame" },
		p = { "<cmd>lua require 'gitsigns'.preview_hunk()<cr>", "Preview Hunk" },
		r = { "<cmd>lua require 'gitsigns'.reset_hunk()<cr>", "Reset Hunk" },
		R = { "<cmd>lua require 'gitsigns'.reset_buffer()<cr>", "Reset Buffer" },
		s = { "<cmd>lua require 'gitsigns'.stage_hunk()<cr>", "Stage Hunk" },
		u = {
			"<cmd>lua require 'gitsigns'.undo_stage_hunk()<cr>",
			"Undo Stage Hunk",
		},
		o = { "<cmd>Telescope git_status<cr>", "Open changed file" },
		b = { "<cmd>Telescope git_branches<cr>", "Checkout branch" },
		c = { "<cmd>Telescope git_commits<cr>", "Checkout commit" },
		d = {
			"<cmd>Gitsigns diffthis HEAD<cr>",
			"Diff",
		},
	},

	l = {
		name = "LSP",
		a = { "<cmd>lua vim.lsp.buf.code_action()<cr>", "Code Action" },
		d = {
			"<cmd>Telescope Telescope diagnostics bufnr=0<cr>",
			"Document Diagnostics",
		},
		w = {
			"<cmd>Telescope diagnostics<cr>",
			"Workspace Diagnostics",
		},
		f = { "<cmd>lua vim.lsp.buf.format{async=false,timeout_ms=5000}; vim.cmd('normal! zx')<cr>", "Format" },
		i = { "<cmd>LspInfo<cr>", "Info" },
		I = { "<cmd>LspInstallInfo<cr>", "Installer Info" },
		j = {
			"<cmd>lua vim.lsp.diagnostic.goto_next()<CR>",
			"Next Diagnostic",
		},
		k = {
			"<cmd>lua vim.lsp.diagnostic.goto_prev()<cr>",
			"Prev Diagnostic",
		},
		l = { "<cmd>lua vim.lsp.codelens.run()<cr>", "CodeLens Action" },
		q = { "<cmd>lua vim.lsp.diagnostic.set_loclist()<cr>", "Quickfix" },
		r = { "<cmd>lua vim.lsp.buf.rename()<cr>", "Rename" },
		s = { "<cmd>Telescope lsp_document_symbols<cr>", "Document Symbols" },
		S = {
			"<cmd>Telescope lsp_dynamic_workspace_symbols<cr>",
			"Workspace Symbols",
		},
	},

	s = {
		name = "Search",
		c = { "<cmd>Telescope colorscheme<cr>", "Colorscheme" },
		h = { "<cmd>Telescope help_tags<cr>", "Find Help" },
		M = { "<cmd>Telescope man_pages<cr>", "Man Pages" },
		r = { "<cmd>Telescope oldfiles<cr>", "Open Recent File" },
		R = { "<cmd>Telescope registers<cr>", "Registers" },
		k = { "<cmd>Telescope keymaps<cr>", "Keymaps" },
		C = { "<cmd>Telescope commands<cr>", "Commands" },
	},

	t = {
		name = "Terminal",
		n = { "<cmd>lua _NODE_TOGGLE()<cr>", "Node" },
		u = { "<cmd>lua _NCDU_TOGGLE()<cr>", "NCDU" },
		t = { "<cmd>lua _HTOP_TOGGLE()<cr>", "Htop" },
		p = { "<cmd>lua _PYTHON_TOGGLE()<cr>", "Python" },
		f = { "<cmd>ToggleTerm direction=float<cr>", "Float" },
		h = { "<cmd>ToggleTerm size=10 direction=horizontal<cr>", "Horizontal" },
		v = { "<cmd>ToggleTerm size=80 direction=vertical<cr>", "Vertical" },
	},
}

which_key.setup(setup)
which_key.register(mappings, opts)
which_key.register(gmappings, gopts)

-- fix comment conflicts
local ncommentmappings = {
	gb = "Togggle block comment",
	gbc = "Toggle block comment",
	gc = "Toggle line comment",
	gcc = "Toggle line comment",
	gco = "Comment next line",
	gcO = "Comment prev line",
	gcA = "Comment end of line",
	["g>"] = "Comment region",
	["g>c"] = "Add line comment",
	["g>b"] = "Add block comment",
	["g<lt>"] = "Uncomment region",
	["g<lt>c"] = "Remove line comment",
	["g<lt>b"] = "Remove block comment",
}
local xcommentmappings = {
	gb = "Togggle block comment",
	gc = "Toggle line comment",
	["g>"] = "Comment region",
	["g<lt>"] = "Uncomment region",
}
which_key.register(ncommentmappings, { mode = "n" })
which_key.register(xcommentmappings, { mode = "x" })
