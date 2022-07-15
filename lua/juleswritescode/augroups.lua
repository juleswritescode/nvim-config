local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

GeneralSettings = augroup("GeneralSettings", {})

autocmd("FileType", {
	group = GeneralSettings,
	pattern = { "qf", "help", "man", "lspinfo" },
	callback = function()
		vim.cmd([[ nnoremap <silent> <buffer> q :close<CR> ]])
	end,
})

YankGroup = augroup("YankGroup", {})

autocmd("TextYankPost", {
	group = YankGroup,
	pattern = "*",
	callback = function()
		vim.highlight.on_yank({
			higroup = "IncSearch",
			timeout = 40,
		})
	end,
})

vim.cmd([[
	augroup _alpha
		autocmd!
		autocmd User AlphaReady set showtabline=0 | autocmd BufUnload <buffer> set showtabline=2
	augroup end
]])
