local toggleterm_ok, toggleterm = pcall(require, "toggleterm")
if not toggleterm_ok then
	print("Toggleterm Not Loaded")
	return
end

toggleterm.setup({
	size = 20,
	open_mapping = "<C-t>",
	shading_factor = 2,
	close_on_exit = true,
	direction = "float",
	float_opts = {
		border = "curved",
		winblend = 0,
		highlights = {
			border = "Normal",
			background = "Normal",
		},
	},
})

local helper = require("juleswritescode.helper")

local terminal_ok, t = pcall(require, "toggleterm.terminal")
if not terminal_ok then
	print("Terminal from ToggleTerm Not Loaded")
	return
end

local Terminal = t.Terminal

local node = Terminal:new({ cmd = "node", hidden = "true" })

local function open_split(cmd)
	vim.cmd(string.format(':TermExec direction="vertical" size=50 cmd="%s" <CR>', cmd))
end

local function install_deps()
	if helper.file_exists("package-lock.json") then
		open_split("npm install && exit")
	elseif helper.file_exists("yarn.lock") then
		open_split("yarn install && exit")
	end
end

local function run_test_file_watch()
	local filename = vim.fn.expand("%")
	if string.find(filename, "test") or string.find(filename, "spec") then
		open_split(string.format("npm t %s -- --watch", filename))
		return
	end

	local extension = string.match(filename, "^.+(%..+)$")
	local extension_idx = string.find(filename, extension)
	local filenames_with_test = {
		string.sub(filename, 1, extension_idx) .. "test" .. extension,
		string.sub(filename, 1, extension_idx) .. "spec" .. extension,
	}

	for _, test_file_name in ipairs(filenames_with_test) do
		if helper.file_exists(test_file_name) then
			open_split(string.format("npm t %s -- --watch", test_file_name))
		end
		return
	end

	print("TestFile for " .. filename .. " not found.")
end

local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	print("Toggleterm Not Loaded")
	return
end

wk.register({
	t = {
		name = "Terminal",
		t = {
			function()
				run_test_file_watch()
			end,
			"Test File",
		},
		i = {
			function()
				install_deps()
			end,
			"Install Deps",
		},
		r = {
			name = "Open Repl",
			n = {
				function()
					node:toggle()
				end,
				"Node",
			},
		},
	},
}, { prefix = "<leader>" })
