local options = {
  tokyonight_style = 'storm',
  tokyonight_terminal_colors = true,
  tokyonight_italic_comments = true,
  tokyonight_italic_keywords = true,
  tokyonight_italic_functions = true,
}

for k, v in pairs(options) do
  vim.g[k] = v
end

local status_ok, _ = pcall(vim.cmd, 'colorscheme tokyonight')
if not status_ok then
  vim.notify("Colorscheme tokoynight not found!")
  return
end
