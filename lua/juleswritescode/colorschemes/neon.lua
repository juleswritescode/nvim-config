local options = {
  neon_style = 'light', -- default, doom, dark, light
  neon_italic_comment = true,
  neon_italic_keyword = true,
  neon_italic_boolean = false,
  neon_italic_function = true,
  neon_italic_variable = false,
  neon_bold = true,
  neon_transparent = false
}

for k, v in pairs(options) do
  vim.g[k] = v
end

vim.cmd [[colorscheme neon]]
