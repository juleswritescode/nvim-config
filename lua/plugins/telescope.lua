require("telescope").setup({
  defaults = {
    file_sorter = require "telescope.sorters".get_fzy_sorter,
    prompt_prefix = ">",
    color_devicons = true,

    file_previewer = require "telescope.previewers".vim_buffer_cat.new,
    grep_previewer = require "telescope.previewers".vim_buffer_vimgrep.new,
    qflist_previewer = require "telescope.previewers".vim_buffer_qflist.new,
  }
})

local M = {}

M.search_dotfiles = function()
  require("telescope.builtin").find_files({
    prompt_title = "< VimRC >",
    cwd = vim.env.NVIM_DOTFILES,
    hidden = true,
  })
end

local nnoremap = require "helper".nnoremap

nnoremap('<leader>ff', function() require "telescope.builtin".find_files() end)
nnoremap('<leader>ft', function() require "telescope.builtin".live_grep() end)
nnoremap('<leader>fh', function() require "telescope.builtin".help_tags() end)
nnoremap('<leader>fb', function() require "telescope.builtin".buffers() end)
nnoremap('<leader>vrc', function() M.search_dotfiles() end)


return M
