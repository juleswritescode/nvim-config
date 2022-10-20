local dap_ok, dap = pcall(require, "dap")
if not dap_ok then
	print("Dap could not be loaded.")
	return
end

-- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation#Javascript
-- TODO: install more adapters for go, rust, neovim lua, etc.

dap.adapters.node2 = {
	type = "executable",
	command = "node",
	args = { os.getenv("HOME") .. "/.local/share/vscode-node-debug2/out/src/nodeDebug.js" },
}
dap.configurations.javascript = {
	{
		name = "Launch",
		type = "node2",
		request = "launch",
		program = "${file}",
		cwd = vim.loop.cwd(),
		sourceMaps = true,
		protocol = "inspector",
		console = "integratedTerminal",
	},
	{
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
}

dap.configurations.typescript = {
	{
		name = "Attach to process",
		type = "node2",
		request = "attach",
		processId = require("dap.utils").pick_process,
	},
	{
		name = "ts-node (Node2 with ts-node)",
		type = "node2",
		request = "launch",
		cwd = vim.loop.cwd(),
		runtimeArgs = { "-r", "ts-node/register" },
		runtimeExecutable = "node",
		args = { "--inspect", "${file}" },
		sourceMaps = true,
		skipFiles = { "<node_internals>/**", "node_modules/**" },
	},
	{
		name = "Jest (Node2 with ts-node)",
		type = "node2",
		request = "launch",
		cwd = vim.loop.cwd(),
		runtimeArgs = { "--inspect-brk", "${workspaceFolder}/node_modules/.bin/jest" },
		runtimeExecutable = "node",
		args = { "${file}", "--runInBand", "--coverage", "false" },
		sourceMaps = true,
		port = 9229,
		skipFiles = { "<node_internals>/**", "node_modules/**" },
	},
}

local dapui_ok, dapui = pcall(require, "dapui")
if not dapui_ok then
	print("Dapui not ok")
	return
end

dapui.setup({
	layouts = {
		{
			elements = {
				"console",
			},
			size = 7,
			position = "bottom",
		},
		{
			elements = {
				-- Elements can be strings or table with id and size keys.
				{ id = "scopes", size = 0.25 },
				"watches",
			},
			size = 40,
			position = "left",
		},
	},
})

dap.listeners.after.event_initialized["dapui_config"] = function()
	dapui.open(1)
end
dap.listeners.before.event_terminated["dapui_config"] = function()
	dapui.close()
end
dap.listeners.before.event_exited["dapui_config"] = function()
	dapui.close()
end

local wk_ok, wk = pcall(require, "which-key")
if not wk_ok then
	print("Which key not loaded for DAP")
	return
end

wk.register({
	D = {
		name = "Debug",
		d = {
			function()
				dap.continue()
			end,
			"Start",
		},
		q = {
			function()
				dap.close()
			end,
			"Quit",
		},
		b = {
			function()
				dap.toggle_breakpoint()
			end,
			"Toggle Breakpoint",
		},
		B = {
			function()
				dap.set_breakpoint(vim.fn.input("Breakpoint condition: "))
			end,
			"Toggle Breakpoint with condition",
		},
		j = {
			function()
				dap.step_over()
			end,
			"Step Over",
		},
		l = {
			function()
				dap.step_into()
			end,
			"Step Into",
		},
		i = {
			function()
				dap.repl.open()
			end,
			"Inspect in REPL",
		},
		c = {
			function()
				dap.run_to_cursor()
			end,
			"Run To Cursor",
		},
	},
}, {
	prefix = "<leader>",
})
