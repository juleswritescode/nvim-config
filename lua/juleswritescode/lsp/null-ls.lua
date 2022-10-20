local null_ls_status_ok, null_ls = pcall(require, "null-ls")
if not null_ls_status_ok then
	print("Null-Ls not loadable")
	return
end

local diagnostics = null_ls.builtins.diagnostics
local formatting = null_ls.builtins.formatting
local code_actions = null_ls.builtins.code_actions

--[[
  You can add options to any builtin.
  formatting.prettier.with({
    env = { ENV_VAR = '...' },      
    extra_args = { '--nosemi' },
    filetypes = { 'html' },
    extra_filetypes = { 'xml' }, -- for not overwriting defaults
    disabled_filetypes = { 'xml' },
    timeout = 10000,
    prefer_local = 'node_modules/bin'
    condition = function(utils)
      return utils.root_has_file({ '.prettierrc' })
    end
  })

  For diagnostics:
  method = null_ls.methods.DIANOGSTICS_ON_SAVE, -- only run on save
--]]

--[[
  Arguments:
  :NullLsInfo -- get sources for buffer
--]]
local sources = {
	formatting.stylua,
	formatting.prettier,
	formatting.rustfmt,
	formatting.pg_format.with({
		extra_args = { "-f", "1", "-u", "1", "-U", "1", "-k" },
	}),
	-- diagnostics.eslint, tsserver will take care of this
	code_actions.eslint,
}

local augroup = vim.api.nvim_create_augroup("LspFormatting", {})

null_ls.setup({
	sources = sources,
	cmd = { "nvim" },
	debounce = 250,
	debug = false,
	default_timeout = 5000,
	diagnostics_format = "#{m} (#{s})",
	fallback_severity = vim.diagnostic.severity.ERROR,
	log_level = "warn",
	notify_format = "[null-ls] %s",
	on_init = nil,
	on_exit = nil,
	update_in_insert = false,
	on_attach = function(client, bufnr)
		if client.supports_method("textDocument/formatting") then
			vim.api.nvim_clear_autocmds({ group = augroup, buffer = bufnr })
			vim.api.nvim_create_autocmd("BufWritePre", {
				group = augroup,
				buffer = bufnr,
				callback = function()
					vim.lsp.buf.formatting_sync({
						bufnr = bufnr,
						filter = function(c)
							return c.name == "null-ls"
						end,
					})
				end,
			})
		end
	end,
})
