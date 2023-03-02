local colorscheme = "catppuccin"

require("hlong.themes." .. colorscheme)

local scheme_status_ok, scheme = pcall(vim.cmd, "colorscheme " .. colorscheme)
if not scheme_status_ok then
	vim.notify(scheme, vim.log.levels.WARN)
	return
end
