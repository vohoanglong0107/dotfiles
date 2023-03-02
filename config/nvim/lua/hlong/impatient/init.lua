local impatient_status_ok, impatient = pcall(require, "impatient")
if not impatient_status_ok then
	vim.notify(impatient, vim.log.levels.WARN)
	return
end

impatient.enable_profile()
