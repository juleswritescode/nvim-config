local vim = vim
local execute = vim.api.nvim_command
local fn = vim.fn
-- ensure that packer is installed
local install_path = fn.stdpath('data')..'/site/pack/packer/opt/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    execute('!git clone https://github.com/wbthomason/packer.nvim '..install_path)
    execute 'packadd packer.nvim'
end
vim.cmd('packadd packer.nvim')
local packer = require'packer'
local util = require'packer.util'
packer.init({
  package_root = util.join_paths(vim.fn.stdpath('data'), 'site', 'pack')
})
--- startup and add configure plugins
packer.startup(function()
    local use = use

    use('nvim-treesitter/nvim-treesitter', {
        run = ':TSUpdate'
    })

    use 'sheerun/vim-polyglot'

    -- these are optional themes but I hear good things about gloombuddy ;)
    -- colorbuddy allows us to run the gloombuddy theme
    use 'tjdevries/colorbuddy.nvim'
    use 'bkegley/gloombuddy'
    use 'gruvbox-community/gruvbox'
    use 'ayu-theme/ayu-vim'
    
    -- sneaking some formatting in here too
    use {'prettier/vim-prettier', run = 'yarn install' }

    use 'neovim/nvim-lspconfig'
    use 'nvim-lua/completion-nvim'
    use 'anott03/nvim-lspinstall'

    use 'nvim-lua/plenary.nvim'
    use 'nvim-lua/popup.nvim'
    use 'nvim-telescope/telescope.nvim'
    use 'nvim-telescope/telescope-fzf-native.nvim'

    use 'jremmen/vim-ripgrep'
  end
)

require "plugins.treesitter"
require "plugins.lsp"
require "plugins.telescope"
