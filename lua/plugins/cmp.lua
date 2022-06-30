local lspkind = require "lspkind"
local cmp = require "cmp"

local source_map = {
  nvim_lsp = '[LSP]',
  luasnip = '[LuaSnip]',
  nvim_lua = '[NvimLua]',
}

cmp.setup({
  snippet = {
    expand = function(args)
      require("luasnip").lsp_expand(args.body)
    end
  },
  mapping = cmp.mapping.preset.insert({
    ['<CR>'] = cmp.mapping.confirm({ select = true  }),
    ['<C-Space>'] = cmp.mapping.complete(),
  }),
  formatting = {
    format = lspkind.cmp_format({
      mode = 'symbol',
      maxwidth = 50,
      before = function(entry, vim_item)
        local menu = source_map[entry.source.name]
        vim_item.menu = menu
        return vim_item
      end
    }),

  },
  sources = cmp.config.sources({
    -- for more sources, check https://github.com/hrsh7th/nvim-cmp/wiki/List-of-sources
    { name = 'nvim_lsp' },
    { name = 'luasnip' }
  })
})

--[[ for filetypes
cmp.setup.filetype('ts?', { ..config })
--]]
