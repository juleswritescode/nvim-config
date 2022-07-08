local nmap = require('juleswritescode.helper').nmap
local nnoremap = require('juleswritescode.helper').nnoremap
local vnoremap = require('juleswritescode.helper').vnoremap
--[[ Key Mappings --]]

vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--[[
-- Enter Plugins specific keymaps in either the plugin file
-- or in the after/plugins hook folder. 
--]]

nmap('<up>', '<nop>')
nmap('<down>', '<nop>')
nmap('<left>', '<nop>')
nmap('<right>', '<nop>')

--[[ Window Navigation --]]
nnoremap('<C-h>', '<C-w>h')
nnoremap('<C-j>', '<C-w>j')
nnoremap('<C-k>', '<C-w>k')
nnoremap('<C-l>', '<C-w>l')

--[[ Indentation --]]
nnoremap('<', '<gv')
nnoremap('>', '>gv')

--[[ Utilities ]] --
nnoremap('<leader>xf', ':Lex 25<CR>') -- open explorer
nnoremap('<leader>yb', '0f{V%y') -- yank block
nnoremap('<leader>vb', '0f{V%') -- highlight block
nnoremap('<leader>db', '0f{V%d') -- delete block
nnoremap('<leader>cp', '"+p') -- paste from clipboard
nnoremap('<leader>y', '"+y') -- yank into clipboard (normal)
vnoremap('<leader>y', '"+y') -- yank into clipboard (visual)
nnoremap('<leader>Y', 'gg"+yG') -- yank whole file into clipboard
vnoremap('p', '"_dP') -- do not save over-pasted word 

nnoremap('<leader>hs', ':set hlsearch!<CR>')
