local wezterm = require("wezterm")
local catppuccin = wezterm.plugin.require("https://github.com/catppuccin/wezterm")

local config = wezterm.config_builder()

local function split(s, delimiter)
	local result = {}
	local from = 1
	local delim_from, delim_to = string.find(s, delimiter, from)
	while delim_from do
		table.insert(result, string.sub(s, from, delim_from - 1))
		from = delim_to + 1
		delim_from, delim_to = string.find(s, delimiter, from)
	end
	table.insert(result, string.sub(s, from))
	return result
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

local function set_exec_domains()
	local exec_domains = {}
	for _, domain in ipairs(get_container_domains()) do
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
