local bufferline_ok, bufferline = pcall(require, "bufferline")
if not bufferline_ok then
  print "Bufferline not loaded"
  return
end

bufferline.setup {
  options = {
    mode = 'buffers',
    themable = true, -- override highlights by theme
    numbers = "none", -- you can use a function to see buffer Ids
    close_command = "Bdelete! %d", -- can be a string | function, see "Mouse actions"
    indicator_icon = "▎",
    modified_icon = "●",
    left_trunc_marker = "",
    right_trunc_marker = "",
    max_name_length = 30,
    max_prefix_length = 30, -- prefix used when a buffer is de-duplicated
    tab_size = 21,
    diagnostics = "nvim_lsp",
    diagnostics_update_in_insert = false,
    diagnostics_indicator = function(count, level)
      if level == 'warning' then
        return " " .. count
      else
        return " " .. count
      end
    end,
    -- custom_filter = function(buf_number) end
    --   -- filter out filetypes you don't want to see
    --   if vim.bo[buf_number].filetype ~= "<dontshow>" then
    --     return true
    --   end
    -- end,
    offsets = { { filetype = "NvimTree", text = "", padding = 1 } },
    show_buffer_icons = true,
    show_tab_indicators = true,
    persist_buffer_sort = true, -- whether or not custom sorted buffers should persist
    separator_style = "thin", -- tab separator styles
    enforce_regular_tabs = true,
    always_show_bufferline = false,
    -- sort_by = 'id' | 'extension' | 'relative_directory' | 'directory' | 'tabs' | function(buffer_a, buffer_b)
    --   -- add custom logic
    --   return buffer_a.modified > buffer_b.modified
    -- end
  },
}

local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
  print "WhichKey not loaded for Bufferline"
  return
end

wk.register({
  b = {
    name = "Buffer",
    c = { function() vim.cmd [[:Bdelete]] end, "Close" },
    p = { function() vim.cmd [[:BufferLinePick]] end, "Pick" },
    l = { function() vim.cmd [[:BufferLineCycleNext]] end, "Next" },
    h = { function() vim.cmd [[:BufferLineCyclePrev]] end, "Prev" },
    s = { function() bufferline.sort_buffers_by("directory") end, "Sort Buffers" },
  }
}, { prefix = '<leader>' })
