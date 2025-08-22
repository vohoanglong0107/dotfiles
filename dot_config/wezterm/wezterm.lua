local wezterm = require("wezterm")
local catppuccin = wezterm.plugin.require("https://github.com/catppuccin/wezterm")
local helpers = require("helpers")

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
config.window_decorations = "INTEGRATED_BUTTONS|RESIZE"
config.enable_tab_bar = true
config.hide_tab_bar_if_only_one_tab = true
config.show_new_tab_button_in_tab_bar = false

config.set_environment_variables = {
	EDITOR = "nvim",
	PATH = "/opt/homebrew/bin:/usr/local/bin:" .. os.getenv("PATH"),
}
config.font = wezterm.font("JetBrains Mono")

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

local mocha_palette = {
	crust = "#11111b",
	base = "#1e1e2e",
	text = "#cdd6f4",
	blue = "#89b4fa",
	mantle = "#181825",
	surface0 = "#313244",
}

-- For some reason these settings are not applied by catppuccin plugin
config.colors = {
	tab_bar = {
		active_tab = {
			bg_color = mocha_palette.blue,
			fg_color = mocha_palette.crust,
		},
		inactive_tab = {
			bg_color = mocha_palette.mantle,
			fg_color = mocha_palette.text,
		},
		inactive_tab_hover = {
			bg_color = mocha_palette.base,
			fg_color = mocha_palette.text,
		},

		inactive_tab_edge = mocha_palette.surface0,
	},
}

config.window_frame = {
	font = wezterm.font("JetBrains Mono"),
	-- font_size = 10,
}

-- config.exit_behavior = "Hold"

return config
