local function has_capability(client, capability)
	return client.resolved_capabilities[capability]
end

function setup_diagnostics()
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

local nnoremap = require "juleswritescode.helper".nnoremap
local function setup_commands(bufnr)
	local opts = { buffer = bufnr }
	nnoremap('<leader>gd', function() vim.lsp.buf.definition() end, opts)
	nnoremap('<leader>gD', function() vim.lsp.buf.declaration() end, opts)
	nnoremap('<leader>gi', function() vim.lsp.buf.implementation() end, opts)
	nnoremap('<leader>gr', function() vim.lsp.buf.references() end, opts)
	nnoremap('<leader>gt', function() vim.lsp.buf.type_definition() end, opts)
	nnoremap('K', function() vim.lsp.buf.hover() end, opts)
	nnoremap('<c-k>', function() vim.lsp.buf.signature_help() end, opts)
	nnoremap('<leader>ca', function() vim.lsp.buf.code_action() end, opts)
	nnoremap('<leader>rn', function() vim.lsp.buf.rename() end, opts)
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

	if client.name == 'tsserver' then
		client.resolved_capabilities.document_formatting = false
	end

	return cmp_nvim_lsp.update_capabilities(capabilities)
end

M.setup = function()
	setup_diagnostics()
end

return M
