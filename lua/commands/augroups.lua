local augroup = vim.api.nvim_create_augroup
local autocmd = vim.api.nvim_create_autocmd

YankGroup = augroup('YankGroup', {})

autocmd('TextYankPost', {
  group = YankGroup,
  pattern = '*',
  callback = function()
    vim.highlight.on_yank({
      higroup = 'IncSearch',
      timeout = 40
    })
  end,
})

FormatGroup = augroup('FormatGroup', {})

autocmd({ 'BufWritePre' }, {
  group = FormatGroup,
  pattern = { '*.ts', '*.js', '*.vue', '*.json' },
  command = 'Prettier'
})

autocmd({ 'BufWritePre' }, {
  group = FormatGroup,
  pattern = { '*.lua' },
  callback = function()
    vim.lsp.buf.formatting_sync()
  end

})

LspGroup = augroup('LspGroup', {})
