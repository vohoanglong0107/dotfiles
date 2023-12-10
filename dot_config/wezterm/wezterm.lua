local wezterm = require("wezterm")
local catppuccin = wezterm.plugin.require("https://github.com/catppuccin/wezterm")

local config = wezterm.config_builder()

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

local function get_container_runtime()
	local success, _, _ = wezterm.run_child_process({ "which", "docker" })
	if success then
		return "docker"
	end
	success, _, _ = wezterm.run_child_process({ "which", "podman" })
	if success then
		return "podman"
	end
	return nil
end

local function list_container(container_runtime)
	-- https://wezfurlong.org/wezterm/faq.html#im-on-macos-and-wezterm-cannot-find-things-in-my-path
	local success, stdout, stderr =
		wezterm.run_child_process({ "zsh", "-c", container_runtime .. " ps --format {{.ID}}:{{.Names}}" })
	local containers = {}
	if success then
		for _, container in ipairs(split(stdout, "\n")) do
			if container ~= "" then
				local id, name = table.unpack(split(container, ":"))
				table.insert(containers, { id = id, name = name })
			end
		end
	else
		wezterm.log_error(stderr)
	end
	return containers
end

local function container_domain(container_runtime, container_id, container_name)
	return wezterm.exec_domain("container-" .. container_name, function(cmd)
		cmd.args = cmd.args or { "zsh" }
		local wrapped = {
			container_runtime,
			"exec",
			"-it",
			"-w",
			cmd.cwd ~= nil and cmd.cwd or "/",
			container_id,
		}
		for _, arg in ipairs(cmd.args) do
			table.insert(wrapped, arg)
		end

		cmd.args = wrapped
		return cmd
	end, "Open in container " .. container_name)
end

local function get_container_domains()
	local domains = {}

	local container_runtime = get_container_runtime()
	if container_runtime == nil then
		wezterm.log_info("Container runtime (docker, podman, etc) not found")
		return domains
	end
	local containers = list_container(container_runtime)
	if next(containers) ~= nil then
		for _, container in ipairs(containers) do
			table.insert(domains, container_domain(container_runtime, container["id"], container["name"]))
		end
	end
	return domains
end

local function get_toolbox_command()
	local success, _, _ = wezterm.run_child_process({ "which", "toolbox" })
	if success then
		return "toolbox"
	end
	return nil
end

local function list_toolboxes(toolbox_command)
	local success, stdout, stderr = wezterm.run_child_process({ "zsh", "-c", toolbox_command .. " list -c" })
	local toolboxes = {}
	if success then
		local containers_info = split(stdout, "\n")
		-- First line is column header
		table.remove(containers_info, 1)
		for _, container in ipairs(containers_info) do
			if container ~= "" then
				local id, name = table.unpack(split(container, " "))
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

local function set_exec_domains()
	local exec_domains = {}
	for _, domain in ipairs(get_container_domains()) do
		table.insert(exec_domains, domain)
	end
	for _, domain in ipairs(get_toolbox_domains()) do
		table.insert(exec_domains, domain)
	end
	return exec_domains
end

config.window_background_opacity = 0.85
config.exec_domains = set_exec_domains()
config.set_environment_variables = {
	EDITOR = "nvim",
	PATH = "/opt/homebrew/bin:/usr/local/bin:" .. os.getenv("PATH"),
}
config.font = wezterm.font("FiraMono Nerd Font Mono")
config.enable_tab_bar = false

catppuccin.apply_to_config(config, { sync = true })
-- config.exit_behavior = "Hold"

return config
