local M = {}

local function bind(op, outer_opts)
	outer_opts = outer_opts or { noremap = true, silent = true }
	return function(lhs, rhs, opts)
		opts = vim.tbl_extend("force", outer_opts, opts or {})
		vim.keymap.set(op, lhs, rhs, opts)
	end
end

M.nmap = bind("n", { noremap = false })
M.nnoremap = bind("n")
M.vnoremap = bind("v")
M.xnoremap = bind("x")
M.inoremap = bind("i")

M.dump = function(o)
	if type(o) == "table" then
		local s = "{ "
		for k, v in pairs(o) do
			if type(k) ~= "number" then
				k = '"' .. k .. '"'
			end
			s = s .. "[" .. k .. "] = " .. M.dump(v) .. ","
		end
		return s .. "} "
	else
		return tostring(o)
	end
end

M.map = function(tbl, fn)
	local t = {}

	for k, v in pairs(tbl) do
		t[k] = fn(v)
	end

	return t
end

M.Set = function(tablelist)
	local set = {}

	for _, l in ipairs(tablelist) do
		set[l] = true
	end

	return set
end

M.file_exists = function(name)
	local f = io.open(name, "r")
	if f ~= nil then
		return true
	else
		return false
	end
end

M.get_hl_tbl_by_name = function(name)
	local ok, hl = pcall(vim.api.nvim_get_hl_by_name, name, true)
	if not ok then
		print("Cannot get hl by name: " .. name)
		return
	end
	for _, key in pairs({ "foreground", "background", "special" }) do
		if hl[key] then
			hl[key] = string.format("#%06x", hl[key])
		end
	end
	return hl
end

return M
