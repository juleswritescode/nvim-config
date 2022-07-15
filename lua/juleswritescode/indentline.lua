local indentline_ok, indent_blankline = pcall(require, "indent_blankline")
if not indentline_ok then
	print("Indentline could not be loaded")
	return
end

vim.g.indent_blankline_show_trailing_blankline_indent = false
vim.g.indent_blankline_context_patterns = {
	"class",
	"return",
	"function",
	"method",
	"^if",
	"^while",
	"jsx_element",
	"^for",
	"^object",
	"^table",
	"block",
	"arguments",
	"if_statement",
	"else_clause",
	"jsx_element",
	"jsx_self_closing_element",
	"try_statement",
	"catch_clause",
	"import_statement",
	"operation_type",
}
-- HACK: work-around for https://github.com/lukas-reineke/indent-blankline.nvim/issues/59
vim.wo.colorcolumn = "99999"

local helper = require("juleswritescode.helper")

local hg_group = helper.get_hl_tbl_by_name("BufferLineHintVisible")

if hg_group then
	vim.cmd(string.format("highlight IndentBlanklineContextChar guifg=%s gui=nocombine", hg_group.foreground))
	-- vim.cmd(string.format("highlight IndentBlanklineContextStart guifg=%s gui=nocombine", hg_group.foreground))
end

-- vim.opt.list = true
-- vim.opt.listchars:append "space:⋅"
-- vim.opt.listchars:append "space:"
-- vim.opt.listchars:append "eol:↴"

indent_blankline.setup({
	char = "▏",
	space_char_blankline = " ",

	-- show current context
	show_current_context_start = false,
	show_current_context = true,

	show_first_indent_level = false,
	show_end_of_line = true,
	use_treesitter = true,
	use_treesitter_scope = true,
	blankline_buftype_exclude = { "terminal", "nofile" },
	filetype_exclude = {
		"help",
		"startify",
		"dashboard",
		"packer",
		"neogitstatus",
		"NvimTree",
		"Trouble",
	},
})
