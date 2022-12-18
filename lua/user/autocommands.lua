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
		vim.api.nvim_create_autocmd("BufWinEnter", {
			once = true,
			command = "silent!normal! '\" | zx",
		})
	end,
})

cmd("FileType", {
	pattern = "Outline",
	command = "silent!set nospell",
	group = group("_outlines", { clear = true }),
})

cmd("BufWritePre", {
	pattern = "*",
	command = "silent!lua vim.lsp.buf.format()",
	group = group("_remove_whitespace", { clear = true }),
})

cmd("BufRead", {
	pattern = "*",
	once = true,
	command = "silent!lua _CHECK_LARGE_FILE()",
	group = group("_large_file", { clear = true }),
})
