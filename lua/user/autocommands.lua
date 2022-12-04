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

local _git = group("_git", { clear = true })
cmd("FileType", { pattern = "gitcommit", command = "silent!setlocal wrap", group = _git })
cmd("FileType", { pattern = "gitcommit", command = "silent!setlocal spell", group = _git })

local _markdown = group("_markdown", { clear = true })
cmd("FileType", { pattern = "markdown", command = "silent!setlocal wrap", group = _markdown })
cmd("FileType", { pattern = "markdown", command = "silent!setlocal spell", group = _markdown })

local _auto_resize = group("_auto_resize", { clear = true })
cmd("VimResized", { pattern = "*", command = "silent!tabdo wincmd =", group = _auto_resize })

local _alpha = group("_alpha", { clear = true })
cmd("User", {
	pattern = "AlphaReady",
	command = "silent!set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2",
	group = _alpha,
})

local _tsfold = group("_tsfold", { clear = true })
cmd("BufWinEnter", { pattern = "*", command = "silent!normal zx", group = _tsfold })

local _outlines = group("_outlines", { clear = true })
cmd("FileType", { pattern = "Outline", command = "silent!set nospell", group = _outlines })

local _coderun = group("_coderun", { clear = true })
if vim.fn.executable("node") then
	cmd(
		{ "BufRead", "BufNewFile" },
		{ pattern = "*.js", command = "noremap <leader>r :% w !node<cr>", group = _coderun }
	)
else
	cmd(
		{ "BufRead", "BufNewFile" },
		{ pattern = "*.js", command = "noremap <leader>r :echo 'node is not installed'<cr>", group = _coderun }
	)
end

local _last_position = group("_last_position", { clear = true })
cmd("BufWinEnter", { pattern = "*", command = "silent!normal '", group = _last_position })

function _G._remove_trailing_whitespaces()
	local l = vim.fn.line(".")
	local c = vim.fn.col(".")
	vim.cmd([[%s/\s\+$//e]])
	vim.fn.cursor(l, c)
end

local _remove_whitespace = group("_remove_whitespace", { clear = true })
cmd("BufWritePre", { pattern = "*", command = "silent!lua _remove_trailing_whitespaces()", group = _remove_whitespace })

local _large_file = group("_large_file", { clear = true })
cmd({ "BufReadPre", "BufWinEnter" }, { pattern = "*", command = "silent!lua _CHECK_LARGE_FILE()", group = _large_file })
