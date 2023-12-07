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

local function list_container()
	-- https://wezfurlong.org/wezterm/faq.html#im-on-macos-and-wezterm-cannot-find-things-in-my-path
	local success, stdout, stderr = wezterm.run_child_process({ "zsh", "-c", "docker ps --format {{.ID}}:{{.Names}}" })
	wezterm.log_info(stdout)
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

local function container_domain(container_id, container_name)
	return wezterm.exec_domain("container-" .. container_name, function(cmd)
		cmd.args = cmd.args or { "zsh" }
		local wrapped = {
			"docker",
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

local exec_domains = {}

local containers = list_container()
wezterm.log_info(containers)
if next(containers) ~= nil then
	for _, container in ipairs(containers) do
		table.insert(exec_domains, container_domain(container["id"], container["name"]))
	end
end

config.window_background_opacity = 0.85
config.exec_domains = exec_domains
config.set_environment_variables = {
	EDITOR = "nvim",
	PATH = "/opt/homebrew/bin:/usr/local/bin:" .. os.getenv("PATH"),
}
config.font = wezterm.font("FiraCode Nerd Font Mono")
config.enable_tab_bar = false

catppuccin.apply_to_config(config, { sync = true })
-- config.exit_behavior = "Hold"

return config
