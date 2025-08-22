local wezterm = require("wezterm")
local catppuccin = wezterm.plugin.require("https://github.com/catppuccin/wezterm")

local config = wezterm.config_builder()

catppuccin.apply_to_config(config, { sync = true })

if wezterm.target_triple == "x86_64-unknown-linux-gnu" then
	local container_domain = require("container_domain")
	-- FIXME: should only apply toolbox on Fedora machines
	local toolbox_domain = require("toolbox_domain")
	container_domain.apply_to_config(config)
	toolbox_domain.apply_to_config(config)
end

config.window_background_opacity = 0.85
config.set_environment_variables = {
	EDITOR = "nvim",
	PATH = "/opt/homebrew/bin:/usr/local/bin:" .. os.getenv("PATH"),
}
config.font = wezterm.font("JetBrains Mono")
config.enable_tab_bar = false

config.keys = {
	{ key = "UpArrow", mods = "SHIFT", action = wezterm.action.ScrollByLine(-1) },
	{ key = "DownArrow", mods = "SHIFT", action = wezterm.action.ScrollByLine(1) },
}

if wezterm.target_triple ~= "x86_64-pc-windows-msvc" then
	config.term = "wezterm"
end

if wezterm.target_triple == "x86_64-pc-windows-msvc" then
	config.default_prog = { "pwsh" }
end

-- config.exit_behavior = "Hold"

return config
