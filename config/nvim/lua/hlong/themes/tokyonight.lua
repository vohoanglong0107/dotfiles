local tokyonight_status_ok, tokyonight = pcall(require, "tokyonight")
if not tokyonight_status_ok then
	vim.notify(tokyonight, vim.log.levels.WARN)
	return
end

tokyonight.setup({
	on_highlights = function(hl, c)
		hl.DiffDelete = {
			fg = "#545454",
			bg = hl.DiffDelete.bg,
		}
	end,
})
