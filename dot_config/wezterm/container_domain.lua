local wezterm = require("wezterm")
local helpers = require("helpers")

local function get_container_runtime()
	local runtimes = { "docker", "podman" }
	for _, runtime in ipairs(runtimes) do
		local container_runtime = helpers.check_command(runtime)
		if container_runtime ~= nil then
			return container_runtime
		end
	end
	return nil
end

local function list_container(container_runtime)
	-- https://wezfurlong.org/wezterm/faq.html#im-on-macos-and-wezterm-cannot-find-things-in-my-path
	local success, stdout, stderr = helpers.run_in_shell(container_runtime .. " ps --format {{.ID}}:{{.Names}}")
	local containers = {}
	if success then
		for _, container in ipairs(helpers.split(stdout, "\n")) do
			if container ~= "" then
				local id, name = table.unpack(helpers.split(container, ":"))
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

local function _apply_to_config(config)
	local exec_domains = config.exec_domains
	if exec_domains == nil then
		exec_domains = {}
	end
	exec_domains = helpers.concat_table(exec_domains, get_container_domains())
	config.exec_domains = exec_domains
end

local M = {}
M.apply_to_config = _apply_to_config
return M
