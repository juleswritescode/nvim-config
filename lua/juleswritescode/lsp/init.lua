local function overwrite_capabilities()
  local capabilities = vim.lsp.protocol.make_client_capabilities()
  capabilities.textDocument.completion.completionItem.snippetSupport = true
  require('cmp_nvim_lsp').update_capabilities(capabilities)
end

local nnoremap = require "juleswritescode.helper".nnoremap
local function setup_commands()
  nnoremap('<leader>gd', function() vim.lsp.buf.definition() end)
  nnoremap('<leader>gD', function() vim.lsp.buf.declaration() end)
  nnoremap('<leader>gi', function() vim.lsp.buf.implementation() end)
  nnoremap('<leader>gr', function() vim.lsp.buf.references() end)
  nnoremap('<leader>gt', function() vim.lsp.buf.type_definition() end)
  nnoremap('K', function() vim.lsp.buf.hover() end)
  nnoremap('<c-k>', function() vim.lsp.buf.signature_help() end)
  nnoremap('<leader>ca', function() vim.lsp.buf.code_action() end)
  nnoremap('<leader>rn', function() vim.lsp.buf.rename() end)
end

local function config(_config, server_type)
  return vim.tbl_deep_extend("force", {
    on_attach = function()
      overwrite_capabilities()
      setup_commands()
      print("Attached Language Server: ", server_type)
    end,
  }, _config or {})
end

-- setup language servers here
require("lspconfig").tsserver.setup(config({}, 'TypeScript'))

require("lspconfig").volar.setup(config({}, 'Volar'))

local sumneko_root_path = "/usr/local/Cellar/lua-language-server/3.4.0"
local sumneko_binary = sumneko_root_path .. "/bin/lua-language-server"
require("lspconfig").sumneko_lua.setup(config({
  cmd = { sumneko_binary, "-E", sumneko_root_path .. "/libexec/main.lua" },
  settings = {
    Lua = {
      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";")
      },
      diagnostics = {
        globals = { 'vim', 'use' },
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.expand("$VIMRUNTIME/lua/vim/lsp")] = true,
        }
      }
    },
  }
}, 'LUA'))

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
  vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = {
    spacing = 4
  },
  signs = false,
  update_in_insert = false,
}
)
