local M = {}

M.settings = {
  settings = {
    Lua = {
      format = {
        enable = false -- done by style lua
      },
      diagnostics = {
        globals = { "vim" }
      },
      workspace = {
        library = {
          [vim.fn.expand("$VIMRUNTIME/lua")] = true,
          [vim.fn.stdpath("config") .. "/lua"] = true,
        }
      }
    },
  }
}

return M
