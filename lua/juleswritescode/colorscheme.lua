local colorscheme = 'gruvbox'

-- neon, tokyonight, onedarkpro, gruvbox

local ok, _ = pcall(require, "juleswritescode.colorschemes." .. colorscheme)
if not ok then
  print "Colorscheme not loadable."
  return
end
