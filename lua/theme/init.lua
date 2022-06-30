if vim.api.nvim_eval('exists("+termguicolors")') then
  vim.cmd('let &t_8f = "<Esc>[38;2;%lu;%lu;%lum"')
  vim.cmd('let &t_8b = "<Esc>[48;2;%lu;%lu;%lum"')
end

vim.cmd("colorscheme gruvbox")
vim.opt.background = 'dark'
vim.g.gruvbox_contrast_dark = 'hard'
vim.g.gruvbox_invert_selection = '0'
vim.g.gruvbox_italic = '1'

-- cute highlighting
vim.cmd [[highlight ColorColumn ctermbg=0 guibg=#333333]]
vim.cmd [[highlight LineNr guifg=#555555]]
vim.cmd [[highlight htmlArg gui=italic,bold cterm=italic,bold]]
vim.cmd [[highlight Comment gui=italic cterm=italic]]
vim.cmd [[highlight jsFunction gui=italic cterm=italic ctermfg=108 guifg=#8ec07c]]
vim.cmd [[highlight Type cterm=italic,bold gui=italic,bold]]
vim.cmd [[highlight! link Type GruvboxYellow]]
vim.cmd [[highlight! link jsObjectKey None]]
vim.cmd [[highlight! link jsObjectShorthandProp GruvboxAqua]]
