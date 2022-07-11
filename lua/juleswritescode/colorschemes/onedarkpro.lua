local status_ok, onedarkpro = pcall(require, "onedarkpro")
if not status_ok then
  print "OneDarkPro not loadable"
  return
end

vim.o.background = 'dark'

onedarkpro.setup {
  theme = 'onedark_vivid'
}
