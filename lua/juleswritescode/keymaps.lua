local nmap = require('juleswritescode.helper').nmap
local nnoremap = require('juleswritescode.helper').nnoremap
local vnoremap = require('juleswritescode.helper').vnoremap
--[[ Key Mappings --]]

vim.g.mapleader = ' '
nnoremap('<leader>', '<nop>')

--[[
-- Enter Plugins specific keymaps in either the plugin file
-- or in the after/plugins hook folder. 
--]]

nmap('<up>', '<nop>')
nmap('<down>', '<nop>')
nmap('<left>', '<nop>')
nmap('<right>', '<nop>')

--[[ Buffer Navigation --]]
nnoremap('<C-j>', ':cnext<CR>', { silent = true })
nnoremap('<C-k>', ':cprev<CR>', { silent = true })
nnoremap('<leader><CR>', ':so ~/.config/nvim/init.lua<CR>')

--[[ Indentation --]]
nnoremap('<', '<gv')
nnoremap('>', '>gv')

--[[ Utilities ]] --
nnoremap('<leader>xh', ':Vex<CR>') -- open explorer
nnoremap('<leader>yb', '0f{V%y') -- yank block
nnoremap('<leader>vb', '0f{V%') -- highlight block
nnoremap('<leader>db', '0f{V%d') -- delete block
nnoremap('<leader>cp', '"+p') -- paste from clipboard
nnoremap('<leader>y', '"+y') -- yank into clipboard (normal)
vnoremap('<leader>y', '"+y') -- yank into clipboard (visual)
nnoremap('<leader>Y', 'gg"+yG') -- yank whole file into clipboard

nnoremap('<leader>hs', ':set hlsearch!<CR>')
