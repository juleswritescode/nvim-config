local nmap = require("juleswritescode.helper").nmap
local nnoremap = require("juleswritescode.helper").nnoremap
local vnoremap = require("juleswritescode.helper").vnoremap

--[[ Key Mappings --]]
vim.api.nvim_set_keymap("", "<Space>", "<Nop>", { noremap = true, silent = true })
vim.g.mapleader = " "
vim.g.maplocalleader = " "

--[[
-- Enter Plugins specific keymaps in either the plugin file
-- or in the after/plugins hook folder. 
--]]

nmap("<up>", "<nop>")
nmap("<down>", "<nop>")
nmap("<left>", "<nop>")
nmap("<right>", "<nop>")

-- Windows!
nnoremap("<leader>we", "<C-w>=") -- all windows equal
nnoremap("<leader>wv", "<C-w>v") -- vertical split
nnoremap("<leader>wh", "<C-w>s")
nnoremap("<leader>we", "<C-w><C-w>") -- focus window!

nnoremap("<leader>hs", ":set hls!<CR>") -- toggle highlight search

-- yanking
nnoremap("<leader>yb", "0f{V%y") -- yank block
nnoremap("<leader>yy", '"+y') -- yank into clipboard
nnoremap("<leader>yY", 'gg"+yG') -- yank whole file into clipboard
vnoremap("<leader>y", '"+y') -- paste from clipboard

-- pasting
nnoremap("<leader>pp", '"+p') -- paste from clipboard
nnoremap("<leader>pb", "0f{%o<Esc>p") -- paste below block
vnoremap("<leader>p", '"_dP') -- paste in visual mode

-- highlighting
nnoremap("<leader>vb", "0f{V%") -- highlight whole block

-- delete block
nnoremap("<leader>vb", "0f{V%d") -- delete whole block

nnoremap("<", "<gv") -- indent left
nnoremap(">", ">gv") -- indent right

-- window navigation
nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")
