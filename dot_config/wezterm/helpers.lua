local wezterm = require("wezterm")

-- https://stackoverflow.com/a/7615129
local function split(s, sep)
	if sep == nil then
		sep = "%s%"
	end
	local t = {}
	for str in string.gmatch(s, "([^" .. sep .. "]+)") do
		table.insert(t, str)
	end
	return t
end

local function concat_table(first, second)
  local res = {table.unpack(first)}
	for _, v in ipairs(second) do
		table.insert(res, v)
	end
  return res
end

local function check_command(command)
	local success, _, _ = wezterm.run_child_process({ "which", command })
	if success then
		return command
	end
	return nil
end

local function run_in_shell(command)
	local success, stdout, stderr = wezterm.run_child_process({ "zsh", "-c", command })
	return success, stdout, stderr
end

local M = {}
M.split = split
M.check_command = check_command
M.concat_table = concat_table
M.run_in_shell = run_in_shell

return M
