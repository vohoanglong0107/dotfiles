local wezterm = require("wezterm")
local helpers = require("helpers")

local function get_toolbox_command()
	return helpers.check_command("toolbox")
end

local function list_toolboxes(toolbox_command)
	local success, stdout, stderr = helpers.run_in_shell(toolbox_command .. " list -c")
	local toolboxes = {}
	if success then
		local containers_info = helpers.split(stdout, "\n")
		-- First line is column header
		table.remove(containers_info, 1)
		for _, container in ipairs(containers_info) do
			if container ~= "" then
				local id, name = table.unpack(helpers.split(container, " "))
				table.insert(toolboxes, { id = id, name = name })
			end
		end
	else
		wezterm.log_error(stderr)
	end
	return toolboxes
end

local function toolbox_domain(toolbox_command, toolbox_name)
	return wezterm.exec_domain("toolbox-" .. toolbox_name, function(cmd)
		cmd.args = cmd.args or { "zsh", "-l" }
		local wrapped = {
			toolbox_command,
			"run",
			"-c",
			toolbox_name,
		}
		for _, arg in ipairs(cmd.args) do
			table.insert(wrapped, arg)
		end

		cmd.args = wrapped
		return cmd
	end, "Open in toolbox " .. toolbox_name)
end

local function get_toolbox_domains()
	local domains = {}

	local toolbox_command = get_toolbox_command()
	if toolbox_command == nil then
		wezterm.log_info("Toolbox not found")
		return domains
	end
	local toolboxes = list_toolboxes(toolbox_command)
	if next(toolboxes) ~= nil then
		for _, container in ipairs(toolboxes) do
			table.insert(domains, toolbox_domain(toolbox_command, container["name"]))
		end
	end
	return domains
end

local function _apply_to_config(config)
	local exec_domains = config.exec_domains
	if exec_domains == nil then
		exec_domains = {}
	end
	exec_domains = helpers.concat_table(exec_domains, get_toolbox_domains())
	config.exec_domains = exec_domains
end

local M = {}
M.apply_to_config = _apply_to_config
return M
