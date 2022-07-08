local options = {
  backup = false, -- do not use a backupdir (when writing to files)
  swapfile = false, -- hell no, creates a swapfile for every opened buffer
  undofile = true, -- enable persistent undo
  writebackup = true, -- will create a backup before writing to a file
  fileencoding = 'utf-8', -- the encoding the buffer is safed in

  cmdheight = 3, -- cmd line height below
  pumheight = 10, -- pop up menu height
  showmode = false, -- no messages on last line when in some mode
  conceallevel = 0, -- make `` visible in markdown files
  cursorline = true, -- show line on current cursor position
  relativenumber = true,
  number = true,

  completeopt = { "menuone", "noselect", "noinsert" }, -- how do deal with suggestions

  hlsearch = true, -- highlight search
  ignorecase = true, -- case insensitive search
  smartcase = true, -- case sensitive search when uppercase letter is included

  showtabline = 1, -- show tab lines when there are more than 2 stops
  expandtab = true, -- insert spaces instead of tabs
  tabstop = 2, -- tab with
  shiftwidth = 2, -- spaces inserted for 1 indentation

  smartindent = true, -- indent next line when typing i.e. { 
  autoindent = true, -- keep indentation when hitting <CR>

  splitbelow = true, -- all horizontal splits go below the current buffer
  splitright = true, -- all vertical splits go right of the current buffer

  termguicolors = true, -- more colors

  syntax = 'on',
  updatetime = 300, -- fast autocompletion for CMP

  --[[ Cursor --]]
  guicursor = 'n:block',

  scrolloff = 8,
  sidescrolloff = 8,
  colorcolumn = '100', -- show the text-width column, width of 100
  signcolumn = 'yes', -- always show the sign column instead of shifting content
  wrap = true, -- wrap lines for readability

}

for k, v in pairs(options) do
  vim.opt[k] = v
end

vim.opt.isfname:append('@-@')
vim.opt.guicursor:append('o-r:hor50')
vim.opt.guicursor:append('v:hor10')
vim.opt.guicursor:append('i:ver10')
vim.opt.guicursor:append('a:blinkon50-blinkoff50')
vim.opt.shortmess:append('c')
vim.opt.formatoptions:remove('cro')
