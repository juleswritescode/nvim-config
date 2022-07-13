local status_ok, gitsigns = pcall(require, "gitsigns")
if not status_ok then
  print "Gitsigns could not be set up"
  return
end


local function on_attach(bufnr)
  local wk_ok, wk = pcall(require, 'which-key')
  if not wk_ok then
    print "Which key not setup for gitsigns"
    return
  end

  wk.register({
    g = {
      name = "Git",
      s = { function() gitsigns.stage_hunk() end, "Stage Hunk" },
      r = { function() gitsigns.reset_hunk() end, "Reset Hunk" },
      n = { function() gitsigns.next_hunk() end, "Next Hunk" },
      p = { function() gitsigns.prev_hunk() end, "Prev Hunk" },
      q = { function() gitsigns.setqflist("all") end, "Hunks To QuickfixList" },
      b = { function() gitsigns.blame_line({ full = true, ignore_whitespace = true }) end, "Blame Line" },
      v = { function() gitsigns.preview_hunk() end, "Preview Hunk" },
      d = {
        name = "Diff",
        d = { function() gitsigns.diffthis(nil, { vertical = true }) end, "Show Diff" },
        a = { function()
          local input = vim.fn.input("What to compare against? > ", "")
          gitsigns.diffthis(input, { vertical = true })
        end, "Against ..." },
      },
      t = {
        name = "Toggle",
        d = { function() gitsigns.toggle_deleted() end, "Show Deleted" },
      }
    }
  }, { buffer = bufnr, prefix = '<leader>' })

end

gitsigns.setup {
  on_attach = on_attach,
  signs = {
    add = { hl = "GitSignsAdd", text = "▎", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn", },
    change = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn",
    },
    delete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn",
    },
    topdelete = { hl = "GitSignsDelete", text = "_", numhl = "GitSignsDeleteNr", linehl = "GitSignsDeleteLn",
    },
    changedelete = { hl = "GitSignsChange", text = "▎", numhl = "GitSignsChangeNr", linehl = "GitSignsChangeLn",
    },
  },
  signcolumn = true, -- Toggle with `:Gitsigns toggle_signs`
  numhl = false, -- Toggle with `:Gitsigns toggle_numhl`
  linehl = false, -- Toggle with `:Gitsigns toggle_linehl`
  word_diff = false, -- Toggle with `:Gitsigns toggle_word_diff`
  show_deleted = false, -- Show deleted version of hunk
  watch_gitdir = {
    interval = 1000,
    follow_files = true,
  },
  attach_to_untracked = true,
  current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
  current_line_blame_opts = {
    virt_text = true,
    virt_text_pos = "eol", -- 'eol' | 'overlay' | 'right_align'
    delay = 1000,
    ignore_whitespace = false,
  },
  current_line_blame_formatter_opts = {
    relative_time = false,
  },
  sign_priority = 6,
  update_debounce = 100,
  status_formatter = nil, -- Use default
  max_file_length = 40000,
  preview_config = {
    -- Options passed to nvim_open_win
    border = "single",
    style = "minimal",
    relative = "cursor",
    row = 0,
    col = 1,
  },
  trouble = false, -- use trouble instead of native qflist (if installed)
  yadm = {
    enable = false,
  },
}
