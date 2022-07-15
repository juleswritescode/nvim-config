local status_ok, _ = pcall(require, "lspconfig")
if not status_ok then
  print "Could not load LSP config"
  return
end

require "juleswritescode.lsp.installer"
require "juleswritescode.lsp.handlers".setup()
require "juleswritescode.lsp.null-ls"
