key_mapper('n', '<C-p>', ':lua require"telescope.builtin".find_files()<CR>', false)
key_mapper('n', '<C-f>', ':lua require"telescope.builtin".live_grep()<CR>', false)
key_mapper('n', '<leader>fh', ':lua require"telescope.builtin".help_tags()<CR>', false)
key_mapper('n', '<leader>fb', ':lua require"telescope.builtin".buffers()<CR>', false)

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

return M
