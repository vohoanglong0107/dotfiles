return {
	"mfussenegger/nvim-dap",
	event = { "BufReadPre", "BufNewFile" },
	config = function()
		vim.fn.sign_define("DapBreakpoint", { text = "⏺", texthl = "Error", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "▶", texthl = "Added", linehl = "", numhl = "" })
	end,
}
