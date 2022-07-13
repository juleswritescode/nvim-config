local nmap = require('juleswritescode.helper').nmap
local nnoremap = require('juleswritescode.helper').nnoremap

local ok, wk = pcall(require, "which-key")
if not ok then
  print "WhichKey not loaded, no mappings work."
  return
end

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

--[[ Quickfix Navigation --]]
wk.register({
  w = {
    name = "Window",
    e = { "<C-w>=", "All Equal" },
    v = { "<C-w>v", "Vertical Split" },
    h = { "<C-w>s", "Horizontal Split" },
    f = { "<C-w><C-w>", "Focus" },
  },
  h = {
    name = "Highlight",
    s = { ":set hlsearch<CR>", "Highlight Search" }
  },
  q = {
    name = "QuickFix",
    j = { ":cnext<CR>", "Next quick fix item" },
    k = { ":cprev<CR>", "Previous quick fix item" },
  },
  y = {
    name = "Yank",
    b = { "0f{V%y", "Yank Block" },
    y = { '"+y', "Yank Into Clipboard" },
    Y = { 'gg"+yG', "Yank File" },
  },
  v = {
    name = "Visual",
    b = { "0f{V%", "Highlight Block" },
  },
  d = {
    name = "Delete",
    b = { "0f{V%d", "Delete Block" },
  },
  p = {
    name = "Pasting",
    p = { '"+p', "Paste From Clipboard" },
    b = { '0f{%o<Esc>p', "Paste Below Block" },
  },
  ['<'] = { '<gv', "Indent Left" },
  ['>'] = { '>gv', "Indent Right" }
}, { prefix = '<leader>' })

wk.register({
  y = { '"+y', "Yank into Clipboard" },
  p = { '"_dP', "Paste without Save" },
}, {
  prefix = "<leader>",
  mode = 'v'
})


nnoremap("<C-h>", "<C-w>h")
nnoremap("<C-j>", "<C-w>j")
nnoremap("<C-k>", "<C-w>k")
nnoremap("<C-l>", "<C-w>l")
