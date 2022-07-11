function ContextSetup()
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

ContextSetup()
