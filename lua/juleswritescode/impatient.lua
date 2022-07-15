local impatient_ok, impatient = pcall(require, "impatient")
if not impatient_ok then
	print("Impatient could not be loaded.")
	return
end

-- Lua modules will be compiled to bytecode (using loadstring) and they will be stored in a cache file
-- :LuaCacheClear => will clear the cache (a new one will be created on startup)
-- :LuaCacheLog => will show the log
-- :LuaCacheProfile => view profiling data

impatient.enable_profile()
