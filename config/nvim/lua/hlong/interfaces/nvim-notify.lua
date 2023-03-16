local notify_status_ok, notify = pcall(require, "notify")
if not notify_status_ok then
	vim.notify(notify, vim.log.levels.WARN)
	return
end

notify.setup({
	background_colour = "#000000",
})

vim.notify = notify
