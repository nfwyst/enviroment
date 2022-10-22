local status_ok, _ = pcall(require, "lspconfig")
if not status_ok or is_large_file then
  return
end

require "user.lsp.configs"
require("user.lsp.handlers").setup()
require "user.lsp.null-ls"
