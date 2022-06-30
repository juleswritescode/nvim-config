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

key_mapper('n', '<leader>cth', ':lua ContextSetup(true)', false)
key_mapper('n', '<leader>cts', ':lua ContextSetup(false)', false)
ContextSetup(false)
