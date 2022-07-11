local status_ok, autopairs = pcall(require, "nvim-autopairs")
if not status_ok then
  print "Autopairs not found"
  return
end

autopairs.setup {
  enable_check_bracket_line = true,
  check_ts = true,
  ts_config = {
    lua = { "string", "source" },
    javascript = { "string", "template_string" },
    java = false,
  },
  disable_filetype = { "TelescopePrompt", "spectre_panel" },
  fast_wrap = {
    -- wrap a word in brackets
    map = "€", -- <A-e>
    chars = { "{", "[", "(", '"', "'" },
    pattern = string.gsub([[ [%'%"%)%>%]%)%}%,] ]], "%s+", ""),
    offset = 0, -- Offset from pattern match
    end_key = "$",
    keys = "qwertyuiopzxcvbnmasdfghjkl",
    check_comma = true,
    highlight = "PmenuSel",
    highlight_grey = "LineNr",
  },
}

local cmp_autopairs = require "nvim-autopairs.completion.cmp"
local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  print "Cmp not found for AutoPairs"
  return
end

cmp.event:on("confirm_done",
  cmp_autopairs.on_confirm_done({})
)
