local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	return
end

-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/formatting
local formatting = null_ls.builtins.formatting
-- https://github.com/jose-elias-alvarez/null-ls.nvim/tree/main/lua/null-ls/builtins/diagnostics
local diagnostics = null_ls.builtins.diagnostics

local function on_init(new_client, _)
  if vim.bo.filetype == "c" then
    new_client.offset_encoding = 'utf-32'
  end
end

local sources = {
  formatting.prettier.with({ extra_args = { "--no-semi", "--single-quote", "--jsx-single-quote" } }),
  formatting.black.with({ extra_args = { "--fast" } }),
  formatting.stylua,
  formatting.clang_format,
}

if not is_large_file then
  table.insert(sources, diagnostics.eslint)
end

null_ls.setup({
	debug = false,
  on_init = on_init,
	sources = sources,
})
