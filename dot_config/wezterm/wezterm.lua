local wezterm = require("wezterm")
local container_domain = require("container_domain")
local toolbox_domain = require("toolbox_domain")
local catppuccin = wezterm.plugin.require("https://github.com/catppuccin/wezterm")

local config = wezterm.config_builder()

container_domain.apply_to_config(config)
toolbox_domain.apply_to_config(config)
catppuccin.apply_to_config(config, { sync = true })

config.window_background_opacity = 0.85
config.set_environment_variables = {
	EDITOR = "nvim",
	PATH = "/opt/homebrew/bin:/usr/local/bin:" .. os.getenv("PATH"),
}
config.font = wezterm.font("FiraMono Nerd Font Mono")
config.enable_tab_bar = false

-- config.exit_behavior = "Hold"

return config
