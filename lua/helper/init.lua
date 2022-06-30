key_mapper = function(mode, key, result, be_silent)
    be_silent = be_silent or false
    vim.api.nvim_set_keymap(
        mode,
        key,
        result,
        { noremap = true, silent = be_silent }
    )
end
