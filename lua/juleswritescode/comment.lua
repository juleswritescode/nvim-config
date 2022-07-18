local status_ok, comment = pcall(require, "Comment")
if not status_ok then
	print("Comment Plugin not found")
	return
end

comment.setup({
	pre_hook = function(ctx)
		local U = require("Comment.utils")

		local location = nil

		if ctx.type == U.ctype.block then
			location = require("ts_context_commentstring.utils").get_cursor_location()
		elseif ctx.cmotion == U.cmotion.v or ctx.cmotion == U.cmotion.V then
			location = require("ts_context_commentstring.utils").get_visual_start_location()
		end

		return require("ts_context_commentstring.internal").calculate_commentstring({
			key = ctx.ctype == U.ctype.line and "__default" or "__multiline",
			location = location,
		})
	end,
	-- Mappings are handled with which-key
	mappings = {
		basic = false,
		extra = false,
		extended = false,
	},
})

local comment_api_ok, comment_api = pcall(require, "Comment.api")
if not comment_api_ok then
	print("Comment Api Not Loadable")
	return
end

local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	print("No Wk loadable for comment")
	return
end

-- Normal mode mappings
wk.register({
	c = {
		name = "Comment",
		a = {
			function()
				comment_api.insert_linewise_eol()
			end,
			"EOL",
		},
		O = {
			function()
				comment_api.insert_linewise_above()
			end,
			"Above",
		},
		o = {
			function()
				comment_api.insert_linewise_below()
			end,
			"Below",
		},
		c = {
			function()
				comment_api.toggle_current_linewise()
			end,
			"Line",
		},
		b = {
			function()
				comment_api.toggle_current_linewise()
			end,
			"Block",
		},
	},
}, {
	prefix = "<leader>",
	mode = "n",
})

--
wk.register({
	c = {
		name = "Comment",
		a = {
			function()
				comment_api.insert_linewise_eol()
			end,
			"EOL",
		},
		O = {
			function()
				comment_api.insert_linewise_above()
			end,
			"Above",
		},
		o = {
			function()
				comment_api.insert_linewise_below()
			end,
			"Below",
		},
		c = {
			function()
				comment_api.toggle_current_linewise()
			end,
			"Line",
		},
		b = {
			function()
				comment_api.toggle_current_linewise()
			end,
			"Block",
		},
	},
}, {
	prefix = "<leader>",
	mode = "o",
})
