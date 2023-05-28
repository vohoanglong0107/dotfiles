local opts = { silent = true }

-- Shorten function name
local keymap = vim.keymap.set

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>", opts)
keymap("n", "<C-Down>", ":resize +2<CR>", opts)
keymap("n", "<C-Left>", ":vertical resize -2<CR>", opts)
keymap("n", "<C-Right>", ":vertical resize +2<CR>", opts)

-- Navigate window
keymap("n", "<C-w>b", "<C-w>s", opts)

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==", opts)
keymap("n", "<A-k>", ":m .-2<CR>==", opts)

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>", opts)

-- Better paste
keymap("v", "p", '"_dP', opts)

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv", opts)
keymap("v", ">", ">gv", opts)

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==", opts)
keymap("v", "<A-k>", ":m .-2<CR>==", opts)
keymap("v", "p", '"_dP', opts)

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Image viewing
-- run imv detached from vim
keymap("n", "<leader>vi", ":!imv % &<CR>", opts)

-- Markdown previewing
keymap("n", "<leader>vm", function()
	local uv = vim.loop
	local tmp_pdf = os.tmpname()
	local w = uv.new_fs_event()
	local md = vim.api.nvim_buf_get_name(0)
	if w == nil then
		vim.notify("can't spawn new fs event")
		return
	end
	local function spanw_pandoc(callback)
		uv.spawn("pandoc", { args = { "-f", "markdown", "-t", "pdf", "-o", tmp_pdf, md } }, function(code)
			assert(code == 0, "Pandoc return non zero code: " .. code)
			if callback ~= nil then
				callback()
			end
		end)
	end
	w:start(
		md,
		{},
		vim.schedule_wrap(function()
			spanw_pandoc()
		end)
	)
	spanw_pandoc(function()
		uv.spawn("zathura", { args = { tmp_pdf } }, function()
			w:stop()
			os.remove(tmp_pdf)
		end)
	end)
end, opts)
