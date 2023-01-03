local mason_status_ok, mason = pcall(require, "mason")
local lsp_status_ok, lsp = pcall(require, "lspconfig")
local mason_lsp_status_ok, mason_lsp = pcall(require, "mason-lspconfig")
if not mason_status_ok or not lsp_status_ok or not mason_lsp_status_ok then
	return
end

mason.setup({
	ui = {
		icons = {
			package_installed = "✓",
			package_pending = "➜",
			package_uninstalled = "✗",
		},
	},
})

local servers = {
	"jsonls",
	"sumneko_lua",
	"clangd",
	"cmake",
	"cssls",
	"gopls",
	"html",
	"sqls",
	"tsserver",
	"yamlls",
	"tailwindcss",
	"marksman",
	"eslint",
}

mason_lsp.setup({
	ensure_installed = servers,
})

for _, server in pairs(servers) do
	local opts = {
		on_attach = require("user.lsp.handlers").on_attach,
		capabilities = require("user.lsp.handlers").capabilities,
	}
	local has_custom_opts, server_custom_opts = pcall(require, "user.lsp.settings." .. server)
	if has_custom_opts then
		opts = vim.tbl_deep_extend("force", opts, server_custom_opts)
	end
	lsp[server].setup(opts)
end
