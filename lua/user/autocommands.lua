local api = vim.api
local cmd = api.nvim_create_autocmd
local group = api.nvim_create_augroup

local _general_settings = group("_general_settings", { clear = true })

cmd("FileType", {
	pattern = { "qf", "help", "man", "lspinfo" },
	command = "nnoremap <silent> <buffer> q :close<cr>",
	group = _general_settings,
})

cmd("TextYankPost", {
	pattern = "*",
	command = "silent!lua require('vim.highlight').on_yank({higroup = 'Visual', timeout = 200})",
	group = _general_settings,
})

cmd("BufWinEnter", {
	pattern = "*",
	command = "silent!set formatoptions-=cro",
	group = _general_settings,
})

cmd("FileType", {
	pattern = "qf",
	command = "silent!set nobuflisted",
	group = _general_settings,
})

cmd("FileType", {
	pattern = { "markdown", "gitcommit" },
	command = "silent!setlocal wrap | setlocal spell",
	group = group("_markdown_git", { clear = true }),
})

cmd("VimResized", {
	pattern = "*",
	command = "silent!tabdo wincmd =",
	group = group("_auto_resize", { clear = true }),
})

cmd("User", {
	pattern = "AlphaReady",
	command = "silent!set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2",
	group = group("_alpha", { clear = true }),
})

cmd("BufRead", {
	callback = function()
		cmd("BufWinEnter", {
			once = true,
			callback = function()
				vim.cmd("silent!normal! '\" | zx")
			end,
		})
	end,
})

cmd({ "BufWinEnter", "WinEnter" }, {
	pattern = "*",
	callback = function()
		local filetype = vim.bo.filetype
		if contains(FILETYPE_EXCLUDE, filetype) or not filetype then
			return
		end
		local tree_api_ok, tree_api = pcall(require, "nvim-tree.api")
		if not tree_api_ok then
			return
		end
		if _IS_IN_NO_NECK_PAIN then
			tree_api.tree.close()
		end
	end,
	group = group("_nvim_tree_close", { clear = true }),
})

cmd("FileType", {
	pattern = "Outline",
	command = "silent!set nospell",
	group = group("_outlines", { clear = true }),
})

cmd("FileType", {
	pattern = { "qf", "help", "man", "lspinfo" },
	command = "silent!setlocal colorcolumn=0",
	group = group("_no_colorcolumn", { clear = true }),
})

cmd("BufRead", {
	pattern = "*",
	once = true,
	command = "silent!lua _CHECK_LARGE_FILE()",
	group = group("_large_file", { clear = true }),
})

cmd({ "WinEnter", "BufWinEnter" }, {
	pattern = "NvimTree*",
	callback = function()
		local def = vim.api.nvim_get_hl_by_name("Cursor", true)
		vim.api.nvim_set_hl(0, "Cursor", vim.tbl_extend("force", def, { blend = 100 }))
		vim.opt.guicursor:append("a:Cursor/lCursor")
	end,
})

cmd({ "BufLeave", "WinClosed" }, {
	pattern = "NvimTree*",
	callback = function()
		local def = vim.api.nvim_get_hl_by_name("Cursor", true)
		vim.api.nvim_set_hl(0, "Cursor", vim.tbl_extend("force", def, { blend = 0 }))
		vim.opt.guicursor = "n-v-c-sm:block,i-ci-ve:ver25,r-cr-o:hor20"
	end,
})

cmd("FileType", {
	pattern = { "html", "typescriptreact", "javascriptreact", "typescript", "javascript" },
	once = true,
	command = "silent!EmmetInstall",
	group = group("_emmet", { clear = true }),
})
