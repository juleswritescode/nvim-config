local cmp_status_ok, cmp = pcall(require, "cmp")
if not cmp_status_ok then
  print("Cmp not found")
  return
end

local luasnip_status_ok, luasnip = pcall(require, "luasnip")
if not luasnip_status_ok then
  print("Luasnip not found")
  return
end


local source_map = {
  nvim_lsp = '[LSP]',
  luasnip = '[LuaSnip]',
  nvim_lua = '[NvimLua]',
  buffer = '[Buffer]',
  path = '[Path]',
}

require "luasnip/loaders/from_vscode".lazy_load()

local function check_previous_char_is_space()
  local col = vim.fn.col(".") - 1 -- returns cursor y position in line
  local is_start_of_line = col == 0
  local is_character = vim.fn.getline("."):sub(col, col):match("%s")
  return is_start_of_line or is_character
end

--   פּ ﯟ   some other good icons
local kind_icons = {
  Text = "",
  Method = "m",
  Function = "",
  Constructor = "",
  Field = "",
  Variable = "",
  Class = "",
  Interface = "",
  Module = "",
  Property = "",
  Unit = "",
  Value = "",
  Enum = "",
  Keyword = "",
  Snippet = "",
  Color = "",
  File = "",
  Reference = "",
  Folder = "",
  EnumMember = "",
  Constant = "",
  Struct = "",
  Event = "",
  Operator = "",
  TypeParameter = "",
}

cmp.setup({
  window = {
    documentation = {
      border = { "╭", "─", "╮", "│", "╯", "─", "╰", "│" },
    }
  },
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ["<C-p>"] = cmp.mapping.select_prev_item(),
    ["<C-n>"] = cmp.mapping.select_next_item(),

    ["<C-u>"] = cmp.mapping(cmp.mapping.scroll_docs(-1), { "i", "c" }),
    ["<C-d>"] = cmp.mapping(cmp.mapping.scroll_docs(1), { "i", "c" }),

    ["<C-s>"] = cmp.mapping(cmp.mapping.complete(), { "i", "c" }), -- "suggest" code completion

    ["<C-y>"] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.

    ["<C-c>"] = cmp.mapping(function(fallback)
      if cmp.get_active_entry() then
        cmp.abort()
      else
        fallback()
      end
    end),

    -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.

    -- Accept currently selected item. If none selected, `select` first item.
    -- Set `select` to `false` to only confirm explicitly selected items.

    ["<CR>"] = cmp.mapping.confirm({ select = true }),

    ["<Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expandable() then
        luasnip.expand()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      elseif check_previous_char_is_space() then
        fallback()
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),

    ["<S-Tab>"] = cmp.mapping(function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end, {
      "i",
      "s",
    }),
  }),
  formatting = {
    fields = { 'abbr', 'kind', 'menu' },

    format = function(entry, vim_item)
      local menu = source_map[entry.source.name]

      vim_item.kind = string.format("%s", kind_icons[vim_item.kind])
      vim_item.menu = menu

      return vim_item
    end

  },
  confirmation = {
    default_behavior = cmp.ConfirmBehavior.Replace,
  },
  -- TODO: This seems different from nvim-from-scratch config, check out the functions
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'nvim_lua' },
    { name = 'luasnip' },
    { name = 'buffer' },
    { name = 'path' },
  }),
  -- TODO: Check out more experimental stuff
  experimental = {
    ghost_text = false,
  },
})
