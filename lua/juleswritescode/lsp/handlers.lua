local function has_capability(client, capability)
	return client.resolved_capabilities[capability]
end

local function setup_diagnostics()
	local signs = {
		{ name = "DiagnosticSignError", text = "" },
		{ name = "DiagnosticSignWarn", text = "" },
		{ name = "DiagnosticSignHint", text = "" },
		{ name = "DiagnosticSignInfo", text = "" },
	}

	for _, sign in ipairs(signs) do
		vim.fn.sign_define(sign.name, { texthl = sign.name, text = sign.text, numhl = "" })
	end

	local config = {
		virtual_text = false,
		signs = {
			active = signs,
		},
		update_in_insert = true,
		underline = true,
		severity_sort = true,
		float = {
			focusable = false,
			style = "minimal",
			border = "rounded",
			source = "always",
			header = "",
			prefix = "",
		},
	}

	vim.diagnostic.config(config)

	vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
		border = "rounded",
		width = 60,
	})

	vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
		border = "rounded",
		width = 60,
	})

	vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
		underline = true,
		virtual_text = {
			spacing = 4
		}
	})
end

local function setup_highlight_document(client)
	if not has_capability(client, 'document_highlight') then
		return
	end

	vim.cmd [[
		augroup lsp_document_highlight
			autocmd! * <buffer>
			autocmd CursorHold <buffer> lua vim.lsp.buf.document_highlight()
			autocmd CursorMoved <buffer> lua vim.lsp.buf.clear_references()
		augroup END
	]]
end

local function setup_commands(bufnr)
	local opts = { buffer = bufnr, prefix = "<leader>" }

	local wk_ok, wk = pcall(require, "which-key")
	if not wk_ok then
		print "Not setting LSP commands, WhichKey not traceable"
		return
	end

	wk.register({
		l = {
			name = "LSP",
			R = { function() vim.lsp.buf.rename() end, "Rename" },
			a = { function() vim.lsp.buf.code_action() end, "Code Actions" },
			k = { function() vim.diagnostic.open_float() end, "Show Diagnostics" },
			n = { function() vim.diagnostic.goto_next() end, "Next Diagnostic" },
			p = { function() vim.diagnostic.goto_prev() end, "Prev Diagnostic" },
			s = { function() vim.lsp.buf.signature_help() end, "Show Signature Help" },
			h = { function() vim.lsp.buf.hover() end, "Hover" },
			d = { function() vim.lsp.buf.definition() end, "Goto Definition" },
			D = { function() vim.lsp.buf.declaration() end, "Goto Declaration" },
			i = { function() vim.lsp.buf.implementation() end, "Goto Implementation" },
			r = { function() vim.lsp.buf.references() end, "Goto References" },
			t = { function() vim.lsp.buf.type_definition() end, "Goto Type Definition" },
		},
	}, opts)
end

local M = {}

M.on_attach = function(client, bufnr)
	setup_commands(bufnr)
	setup_highlight_document(client)
	print("Attached language server: " .. client.name)
end

M.overwrite_capabilities = function(client)
	local capabilities = vim.lsp.protocol.make_client_capabilities()

	local status_ok, cmp_nvim_lsp = pcall(require, 'cmp_nvim_lsp')
	if not status_ok then
		return
	end

	if client.name == 'tsserver' or client.name == 'volar' then
		client.resolved_capabilities.document_formatting = false
	end

	return cmp_nvim_lsp.update_capabilities(capabilities)
end

M.setup = function()
	setup_diagnostics()
end

return M
