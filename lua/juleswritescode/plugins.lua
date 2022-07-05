local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data') .. '/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
    execute 'packadd packer.nvim'
end

vim.cmd('packadd packer.nvim')
local packer = require 'packer'
local util = require 'packer.util'
packer.init({
    package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

--- startup and add configure plugins
packer.startup(function()
    local use = use

    use('nvim-treesitter/nvim-treesitter', {
        run = ':TSUpdate'
    })
    use('nvim-treesitter/playground')
    use('nvim-treesitter/nvim-treesitter-context')

    use 'sheerun/vim-polyglot'

    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzf-native.nvim'
    use 'sharkdp/fd'
    use 'BurntSushi/ripgrep'

    -- these are optional themes but I hear good things about gloombuddy ;)
    -- colorbuddy allows us to run the gloombuddy theme
    use 'tjdevries/colorbuddy.nvim'
    use 'bkegley/gloombuddy'
    use 'gruvbox-community/gruvbox'
    use 'folke/tokyonight.nvim'
    use 'ayu-theme/ayu-vim'

    -- sneaking some formatting in here too
    use { 'prettier/vim-prettier', run = 'yarn install' }

    use 'neovim/nvim-lspconfig'

    -- Autocompletion
    use "L3MON4D3/LuaSnip"
    use "saadparwaiz1/cmp_luasnip"
    use 'hrsh7th/cmp-nvim-lsp'
    use 'hrsh7th/cmp-buffer'
    use 'hrsh7th/nvim-cmp'
    use 'onsails/lspkind-nvim'
    use 'nvim-lua/completion-nvim'

    use 'anott03/nvim-lspinstall'

end
)

require "plugins.treesitter"
require "plugins.cmp"
require "plugins.lsp"
require "plugins.telescope"
require "plugins.treesitter-context"
