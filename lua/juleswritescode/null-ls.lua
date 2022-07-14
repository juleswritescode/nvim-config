local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
  print "Null-Ls not loadable"
  return
end

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

local sources = {
  formatting.stylua,
  formatting.prettier,
  formatting.rustfmt,
  formatting.pg_format,
  diagnostics.eslint,
  code_actions.eslint,
}

null_ls.setup {
  debug = false,
  sources = sources,
}
