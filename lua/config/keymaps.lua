--[[ Key Mappings --]]
vim.g.mapleader = ' '

key_mapper('', '<up>', '<nop>', true)
key_mapper('', '<down>', '<nop>', true)
key_mapper('', '<left>', '<nop>', true)
key_mapper('', '<right>', '<nop>', true)
key_mapper('i', '<up>', '<nop>', true)
key_mapper('i', '<down>', '<nop>', true)
key_mapper('i', '<left>', '<nop>', true)
key_mapper('i', '<right>', '<nop>', true)

--[[ Buffer Navigation --]]
key_mapper('', '<C-j>', ':cnext<CR>', true)
key_mapper('', '<C-k>', ':cprev<CR>', true)
key_mapper('n', '<leader><CR>', ':so ~/.config/nvim/init.lua<CR>', false)
key_mapper('n', '<leader>vrc', ':lua require("plugins.telescope").search_dotfiles()<CR>', false)

--[[ Indentation --]]
key_mapper('', '<', '<gv', true)
key_mapper('', '>', '>gv', true)

--[[ Utilities ]] --
key_mapper('n', '<leader>xh', ':Vex', true) -- open explorer
key_mapper('n', '<leader>yb', '0f{V%y', true) -- yank block
key_mapper('n', '<leader>vb', '0f{V%', true) -- highlight block
key_mapper('n', '<leader>db', '0f{V%d', true) -- delete block
key_mapper('n', '<leader>cp', '"+p', true) -- paste from clipboard
key_mapper('n', '<leader>y', '"+y', true) -- yank into clipboard (normal)
key_mapper('v', '<leader>y', '"+y', true) -- yank into clipboard (visual)
key_mapper('n', '<leader>Y', 'gg"+yG', true) -- yank whole file into clipboard

key_mapper('n', '<leader>hs', ':set hlsearch!<CR>', false)
