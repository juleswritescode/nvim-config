local installer_status_ok, lsp_installer = pcall(require, "nvim-lsp-installer")
if not installer_status_ok then
  print("Lsp Installer not found")
  return
end

lsp_installer.setup {
  automatic_installation = false
}

local config_status_ok, lspconfig = pcall(require, 'lspconfig')
if not config_status_ok then
  print("Lsp Config not found for installer")
  return
end

local servers = lsp_installer.get_installed_servers()

for _, server in pairs(servers) do

  local opts = {
    on_attach = require("juleswritescode.lsp.handlers").on_attach,
    capabilities = require("juleswritescode.lsp.handlers").capabilities,
  }

  local has_custom_opts, server_custom_opts = pcall(require, "juleswritescode.lsp.settings." .. server.name)

  if has_custom_opts then
    opts = vim.tbl_deep_extend("force", server_custom_opts.settings or {}, opts)
  end

  lspconfig[server.name].setup(opts)
end
