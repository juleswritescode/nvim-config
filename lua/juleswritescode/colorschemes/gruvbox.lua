local options = {
  gruvbox_baby_background_color = "dark",
  gruvbox_baby_function_style = "bold",
  gruvbox_baby_keyword_style = "italic",
  gruvbox_baby_comment_style = "italic",
  -- See also :h highlight-guifg
  gruvbox_baby_telescope_theme = 1,
  gruvbox_baby_transparent_mode = 0
}

for k, v in pairs(options) do
  vim.g[k] = v
end

-- Load the colorscheme
vim.cmd [[colorscheme gruvbox-baby]]
