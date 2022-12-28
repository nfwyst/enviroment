local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting

local function on_init(new_client, _)
	if vim.bo.filetype == "c" then
		new_client.offset_encoding = "utf-32"
	end
end

null_ls.setup({
	debug = false,
	on_init = on_init,
	sources = {
		formatting.prettier,
		formatting.stylua,
		formatting.clang_format,
	},
})
