vim.opt.termguicolors = true
vim.opt.syntax = 'on'
vim.opt.errorbells = false
vim.opt.shortmess:append('c')
vim.opt.ignorecase = true
vim.opt.showmode = false
vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = vim.fn.stdpath('config') .. '/undodir'
vim.opt.undofile = true
vim.opt.updatetime = 50
vim.opt.hidden = true
vim.opt.completeopt = 'menuone,noinsert,noselect'
vim.opt.autoindent = true
vim.opt.smartindent = true
vim.opt.hlsearch = true
vim.opt.incsearch = true

--[[ Styles --]]
vim.opt.guifont = 'Operator Mono:h14'

--[[ Cursor --]]
vim.opt.guicursor = 'n:block'
vim.opt.guicursor:append('o-r:hor50')
vim.opt.guicursor:append('v:hor10')
vim.opt.guicursor:append('i:ver10')
vim.opt.guicursor:append('a:blinkon50-blinkoff50')

vim.opt.scrolloff = 8
vim.opt.colorcolumn = '80'
vim.opt.formatoptions:remove('ro')
vim.opt.signcolumn = 'yes'
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.smarttab = true
vim.opt.expandtab = true
vim.opt.cindent = true
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cmdheight = 3
vim.opt.wrap = true

vim.opt.isfname:append('@-@')
