return {
	"mfussenegger/nvim-dap",
	event = { "BufReadPre", "BufNewFile" },
	keys = {
		{
			"<leader>dc",
			function()
				require("dap").continue()
			end,
			desc = "Start/Continue debugging",
		},
		{
			"<leader>ds",
			function()
				require("dap").step_over()
			end,
			desc = "Step over",
		},
		{
			"<leader>di",
			function()
				require("dap").step_into()
			end,
			desc = "Step in",
		},
		{
			"<leader>do",
			function()
				require("dap").step_out()
			end,
			desc = "Step out",
		},
		{
			"<leader>db",
			function()
				require("dap").toggle_breakpoint()
			end,
			desc = "Toggle Breakpoint",
		},
	},
	config = function()
		vim.fn.sign_define("DapBreakpoint", { text = "🟥", texthl = "", linehl = "", numhl = "" })
		vim.fn.sign_define("DapStopped", { text = "▶️", texthl = "", linehl = "", numhl = "" })
	end,
}
