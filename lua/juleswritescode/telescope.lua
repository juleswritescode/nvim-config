local status_ok, telescope = pcall(require, "telescope")
if not status_ok then
  print "Telescope not found"
  return
end

local actions = require "telescope.actions"
local builtin = require "telescope.builtin"

telescope.setup({
  defaults = {
    prompt_prefix = ">",
    selection_caret = " ",
    mappings = {
      n = {
      },
      i = {
        ["<C-h>"] = actions.which_key,
        ["<C-v>"] = actions.file_vsplit,
        ["<Tab>"] = actions.toggle_selection,
        ["<leader>cc"] = { "<esc>", type = "command" }
      }
    },
  },
  pickers = {
    -- grep_string = { theme = TELESCOPE_THEME },
    -- find_files = { theme = TELESCOPE_THEME },
    -- lsp_references = { theme = TELESCOPE_THEME },
    -- live_grep = { theme = TELESCOPE_THEME },
    -- help_tags = { theme = TELESCOPE_THEME },
    -- buffers = { theme = TELESCOPE_THEME },
    -- diagnostics = { theme = TELESCOPE_THEME },
    -- builtin = { theme = TELESCOPE_THEME },
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

local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
  print "Which Key not found"
  return
end

wk.register({
  f = {
    name = "Find",
    ["<CR>"] = { function() builtin.current_buffer_fuzzy_find() end, "Find In Buffer" },
    m = { function() builtin.marks() end, "Find Marks" },
    o = { function() builtin.vim_options() end, "Find Vim Options" },
    d = { function() builtin.git_bcommits() end, "Find Diffs in Commits" },
    c = { function() builtin.command_history() end, "Find Command History" },
    k = { function() builtin.colorscheme() end, "Find (K)Colorschemes" },
    h = { function() builtin.search_history() end, "Find Search history" },
    s = { function() builtin.grep_string() end, "Find String Under Cursor" }, -- find string
    f = { function() builtin.find_files() end, "Find Files" }, -- find files
    r = { function() builtin.lsp_references() end, "Find References Under Cursor" }, -- find references
    t = { function() builtin.live_grep() end, "Find Text" }, -- find text
    -- h = { function() builtin.help_tags() end, "Find Help Tags" }, -- find help tags
    b = { function() builtin.buffers() end, "Find Buffers" }, -- find buffers
    p = { function() builtin.diagnostics() end, "Find Diagnostics" }, -- find problems
    ["ip"] = { function() telescope.extensions.project.project({}) end, "Find Within Project" }, -- find in projects, <C-s> to search a string
    ["sp"] = { function() builtin.builtin() end, "Show Available Pickers" }, -- show pickers
    ["vrc"] = { function() search_dotfiles() end, "Search VimRC" }
  }
}, { prefix = "<leader>" })

return M
