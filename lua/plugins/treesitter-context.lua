function ContextSetup(show_all_context)
  require "treesitter-context".setup {
    enable = true,
    max_lines = 0,
    throttle = true,
    patterns = {
      default = {
        'class',
        'function',
        'method',
        'for',
        'while',
        'if',
        'switch',
        'case',
      },

      typescript = {
        'class_declaration',
        'abstract_class_declaration',
        'else_clause'
      }
    }
  }
end

local nnoremap = require"helper".nnoremap
nnoremap('<leader>cth', function() ContextSetup(true) end)
nnoremap('<leader>cts', function() ContextSetup(false) end)
ContextSetup(false)
