-- ensure that packer is installed
local fn = vim.fn
local install_path = fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if fn.empty(fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing Packer, close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")
if not status_ok then
	print("Packer was not found.")
	return
end

--- startup and add configure plugins
return packer.startup({
	function(use)
		-- improve loading time of plugins
		use("lewis6991/impatient.nvim")

		-- treesitter & syntax highlighting
		use("nvim-treesitter/nvim-treesitter", {
			run = ":TSUpdate",
		})
		use("nvim-treesitter/playground")
		use("nvim-treesitter/nvim-treesitter-context")
		use("sheerun/vim-polyglot")

		-- dependencies
		use("nvim-lua/plenary.nvim")
		use("nvim-lua/popup.nvim")
		use("sharkdp/fd")
		use("BurntSushi/ripgrep")

		-- telescope
		use("nvim-telescope/telescope.nvim")
		use("nvim-telescope/telescope-project.nvim")
		use("nvim-telescope/telescope-fzy-native.nvim")

		-- colors
		use("olimorris/onedarkpro.nvim")
		use("luisiacc/gruvbox-baby")
		use("folke/tokyonight.nvim")
		use("rafamadriz/neon")

		-- LSP
		use("neovim/nvim-lspconfig")
		use("williamboman/nvim-lsp-installer")
		use("anott03/nvim-lspinstall")
		use("jose-elias-alvarez/null-ls.nvim")

		-- Autocompletion
		use("hrsh7th/nvim-cmp")
		use("hrsh7th/cmp-buffer")
		use("hrsh7th/cmp-path")
		use("hrsh7th/cmp-cmdline")
		use("hrsh7th/cmp-nvim-lsp")
		use("hrsh7th/cmp-nvim-lua")
		use("saadparwaiz1/cmp_luasnip")
		use("nvim-lua/completion-nvim")

		-- snippets
		use("L3MON4D3/LuaSnip")
		use("rafamadriz/friendly-snippets")

		-- git
		use("lewis6991/gitsigns.nvim")

		-- tools
		use("numToStr/Comment.nvim")
		use("JoosepAlviste/nvim-ts-context-commentstring")
		use("windwp/nvim-autopairs")

		-- nerd tree
		use("kyazdani42/nvim-web-devicons")
		use("kyazdani42/nvim-tree.lua")

		-- whichkey
		use("folke/which-key.nvim")

		-- bufferline
		use("akinsho/bufferline.nvim")
		use("moll/vim-bbye")

		-- toggleterm
		use({ "akinsho/toggleterm.nvim", tag = "v2.*" })

		-- alpha, start screen
		use("goolord/alpha-nvim")

		-- indentline
		use("lukas-reineke/indent-blankline.nvim")

		-- lualine
		use("nvim-lualine/lualine.nvim")

		-- trouble, diagnostics window
		use("folke/trouble.nvim")

		-- Debugger
		use("mfussenegger/nvim-dap")
		use("rcarriga/nvim-dap-ui")
		use("theHamsta/nvim-dap-virtual-text")

		-- setup plugins after downloading packer
		if PACKER_BOOTSTRAP then
			require("packer").sync()
		end
	end,
	config = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})
