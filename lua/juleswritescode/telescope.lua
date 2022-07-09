local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  print "Telescope not found"
  return
end

local actions = require "telescope.actions"
local sorters = require "telescope.sorters"
local previewers = require "telescope.previewers"
local builtin = require "telescope.builtin"

local TELESCOPE_THEME = 'ivy'

telescope.setup({
  defaults = {
    prompt_prefix = ">",
    selection_caret = " ",
    mappings = {
      i = {
        ["<C-h>"] = actions.which_key,
      }
    },
  },
  pickers = {
    grep_string = { theme = TELESCOPE_THEME },
    find_files = { theme = TELESCOPE_THEME },
    lsp_references = { theme = TELESCOPE_THEME },
    live_grep = { theme = TELESCOPE_THEME },
    help_tags = { theme = TELESCOPE_THEME },
    buffers = { theme = TELESCOPE_THEME },
    diagnostics = { theme = TELESCOPE_THEME },
    builtin = { theme = TELESCOPE_THEME },
  },
  extensions = {
    fzy_native = {
      override_generic_sorter = true,
      override_file_sorter = true,
    },
    project = {
      base_dirs = {
        { '~/dev_projects/tresor-one/tresor-api', max_depth = 4 },
        { '~/dev_projects/tresor-one/tresor', max_depth = 4 },
      },
    }
  }

  -- file_sorter = sorters.get_fzy_sorter,

  -- color_devicons = true,

  --[[
    file_previewer = previewers.vim_buffer_cat.new,
    grep_previewer = previewers.vim_buffer_vimgrep.new,
    qflist_previewer = previewers.vim_buffer_qflist.new,
    --]]
})

telescope.load_extension('fzy_native')
telescope.load_extension('project')

local M = {}

local function search_dotfiles()
  builtin.find_files({
    prompt_title = "< VimRC >",
    cwd = vim.env.NVIM_DOTFILES,
    hidden = true,
  })
end

local nnoremap = require "juleswritescode.helper".nnoremap

nnoremap('<leader>fs', function() builtin.grep_string() end) -- find string
nnoremap('<leader>ff', function() builtin.find_files() end) -- find files
nnoremap('<leader>fr', function() builtin.lsp_references() end) -- find references
nnoremap('<leader>ft', function() builtin.live_grep() end) -- find text
nnoremap('<leader>fh', function() builtin.help_tags() end) -- find help tags
nnoremap('<leader>fb', function() builtin.buffers() end) -- find buffers
nnoremap('<leader>fp', function() builtin.diagnostics() end) -- find problems
nnoremap('<leader>fip', function() telescope.extensions.project.project({}) end) -- find in projects
nnoremap('<leader>fsp', function() builtin.builtin() end) -- show pickers
nnoremap('<leader>vrc', function() search_dotfiles() end)


return M
