local status_ok, whichkey = pcall(require, "which-key")
if not status_ok then
  print "Couldn't load whichkey"
  return
end

vim.o.timeoutlen = 200 -- The timeout before whichkey is triggered.

whichkey.setup {
  plugins = {
    presets = {
      windows = false,
      nav = false,
    }
  },
  window = {
    border = "double",
  },
  ignore_missing = true,
  triggers_blacklist = {
    n = { "<C-c>" },
    i = { "<C-c>" },
    v = { "<C-c>" },
  }
}
