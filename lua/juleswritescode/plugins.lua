-- ensure that packer is installed
local fn = vim.fn
local install_path = fn.stdpath('data') .. '/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
    PACKER_BOOTSTRAP = fn.system {
        'git',
        'clone',
        '--depth',
        '1',
        'https://github.com/wbthomason/packer.nvim',
        install_path
    }
    print "Installing Packer, close and reopen Neovim..."
    vim.cmd [[packadd packer.nvim]]
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, 'packer')
if not status_ok then
    return
end

packer.init {
    display = {
        open_fn = function()
            require "packer.util".util.float { border = "rounded" }
        end
    }
}

--- startup and add configure plugins
packer.startup(function(use)
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

    -- setup plugins after downloading packer
    if PACKER_BOOTSTRAP then
        require "packer".sync()
    end
end
)
