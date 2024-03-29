local Job = require("plenary.job")
local Path = require("plenary.path")
local uv = vim.loop

-- Shorten function name
local function keymap(mode, lhs, rhs, opts)
    local options = { noremap = true, silent = true }
    if opts then
        if opts.desc then
            opts.desc = "keymaps.lua: " .. opts.desc
        end
        options = vim.tbl_extend('force', options, opts)
    end
    vim.keymap.set(mode, lhs, rhs, options)
end

-- Modes
--   normal_mode = "n",
--   insert_mode = "i",
--   visual_mode = "v",
--   visual_block_mode = "x",
--   term_mode = "t",
--   command_mode = "c",

-- Resize with arrows
keymap("n", "<C-Up>", ":resize -2<CR>")
keymap("n", "<C-Down>", ":resize +2<CR>")
keymap("n", "<C-Left>", ":vertical resize -2<CR>")
keymap("n", "<C-Right>", ":vertical resize +2<CR>")

-- Navigate window
keymap("n", "<C-w>b", "<C-w>s")

-- Move text up and down
keymap("n", "<A-j>", ":m .+1<CR>==")
keymap("n", "<A-k>", ":m .-2<CR>==")

-- Clear highlights
keymap("n", "<leader>h", "<cmd>nohlsearch<CR>")

-- Consistent search direction
keymap("n", "n", function()
	return vim.v.searchforward == 1 and "n" or "N"
end, { expr = true, silent = true })
keymap("n", "N", function()
	return vim.v.searchforward == 1 and "N" or "n"
end, { expr = true, silent = true })

-- Undo
keymap("n", "U", "<cmd>redo<CR>")

-- Moving aroung
keymap("n", "gl", "$")
keymap("n", "gs", "^")
keymap("n", "gm", "%", { silent = true, remap = true, desc = "Go to matching pair" })
keymap("v", "gl", "$")
keymap("v", "gs", "^")
keymap("v", "gm", "%", { silent = true, remap = true, desc = "Go to matching pair" })
keymap("n", "ga", "<C-6>")

-- System clipboard yank
keymap("v", "<leader>y", '"+y')
keymap("v", "<leader>p", '"+p')
keymap("n", "<leader>p", '"+p')

-- Visual --
-- Stay in indent mode
keymap("v", "<", "<gv")
keymap("v", ">", ">gv")

-- Move text up and down
keymap("v", "<A-j>", ":m .+1<CR>==")
keymap("v", "<A-k>", ":m .-2<CR>==")

-- Insert --
keymap("i", "jk", "<Esc>")

-- Terminal --
-- Better terminal navigation
-- keymap("t", "<C-h>", "<C-\\><C-N><C-w>h", term_opts)
-- keymap("t", "<C-j>", "<C-\\><C-N><C-w>j", term_opts)
-- keymap("t", "<C-k>", "<C-\\><C-N><C-w>k", term_opts)
-- keymap("t", "<C-l>", "<C-\\><C-N><C-w>l", term_opts)

-- Image viewing
-- run imv detached from vim
keymap("n", "<leader>vi", function()
	Job:new({
		command = "imv",
		args = { vim.api.nvim_buf_get_name(0) },
	}):start()
end)

local function new_tmp_file_name()
	local tmp = os.tmpname()
	-- on posix lua create the file on os.tmpname()
	os.remove(tmp)
	return tmp
end

-- Markdown previewing
keymap("n", "<leader>vm", function()
	local tmp_pdf = new_tmp_file_name() .. ".pdf"
	local tmp_md = new_tmp_file_name() .. ".md"
	local w = uv.new_fs_event()
	local md = vim.api.nvim_buf_get_name(0)
	if w == nil then
		vim.notify("can't spawn new fs event")
		return
	end
	local function spanw_pandoc(callback)
		local file = assert(io.open(tmp_md, "w"))
		file:write('<div class="markdown-body">', "\n")
		local current_file = assert(io.open(md, "r"))
		file:write(current_file:read("*a"), "\n")
		file:write("</div>")
		file:close()
		Job:new({
			command = "pandoc",
			args = {
				"-f",
				"gfm",
				"-t",
				"html5",
				"-c",
				-- https://stackoverflow.com/a/23994783, thanks to wkhtmltopdf and gfm
				os.getenv("HOME") .. "/.config/pandoc/github-markdown.css",
				"-o",
				tmp_pdf,
				tmp_md,
			},
			cwd = Path:new({ md }):parent().filename,
			-- silent, gfm pandoc is very loud
			-- on_stdout = function(err, data)
			-- 	assert(not err, err)
			-- 	vim.notify("pandoc: " .. data)
			-- end,
			-- on_stderr = function(err, data)
			-- 	assert(not err, err)
			-- 	vim.notify("pandoc: " .. data, vim.log.levels.WARN)
			-- end,
			on_exit = function(j, return_val)
				assert(return_val == 0, "Pandoc return non zero code: " .. return_val)
				if callback ~= nil then
					callback()
				end
			end,
		}):start()
	end
	w:start(
		md,
		{},
		vim.schedule_wrap(function()
			spanw_pandoc()
		end)
	)
	spanw_pandoc(function()
		Job:new({
			command = "zathura",
			args = { tmp_pdf },
			on_exit = function()
				w:stop()
				os.remove(tmp_pdf)
				os.remove(tmp_md)
			end,
		}):start()
	end)
end)
