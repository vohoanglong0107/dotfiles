local install_path = vim.fn.stdpath("data") .. "/site/pack/packer/start/packer.nvim"
if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
	PACKER_BOOTSTRAP = vim.fn.system({
		"git",
		"clone",
		"--depth",
		"1",
		"https://github.com/wbthomason/packer.nvim",
		install_path,
	})
	print("Installing packer close and reopen Neovim...")
	vim.cmd([[packadd packer.nvim]])
end

local plugins = {
	-- Packer can manage itself
	{ "wbthomason/packer.nvim", commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" },

	-- Neovim plugins' utils
	{ "nvim-lua/plenary.nvim", commit = "253d34830709d690f013daf2853a9d21ad7accab" },

	{ "lewis6991/impatient.nvim", commit = "d3dd30ff0b811756e735eb9020609fa315bfbbcc" },

	-- Theme
	{ "nvim-tree/nvim-web-devicons", commit = "3548363849878ef895ce54edda02421279b419d8" },
	{ "folke/tokyonight.nvim", commit = "62b4e89ea1766baa3b5343ca77d62c817f5f48d0" },
	{ "catppuccin/nvim", as = "catppuccin", commit = "6368edcd0b5e5cb5d9fb7cdee9d62cffe3e14f0e" },

	-- Interfaces
	{ "glepnir/dashboard-nvim", commit = "1aab263f4773106abecae06e684f762d20ef587e" },
	{ "nvim-lualine/lualine.nvim", commit = "e99d733e0213ceb8f548ae6551b04ae32e590c80" },
	{ "rcarriga/nvim-notify", commit = "bdd647f61a05c9b8a57c83b78341a0690e9c29d7" },
	{ "nvim-tree/nvim-tree.lua", commit = "68a2a0971eb50f13e4d54498a2add73f131b9a85" },
	{ "folke/trouble.nvim", commit = "897542f90050c3230856bc6e45de58b94c700bbf" },
	{ "folke/which-key.nvim", commit = "61553aeb3d5ca8c11eea8be6eadf478062982ac9" },
	{ "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" },

	-- Core
	{
		"nvim-treesitter/nvim-treesitter",
		commit = "4f07518fb9eecb59ca51f168ce5d890d0ad352e6",
		run = function()
			local ts_update = require("nvim-treesitter.install").update({ with_sync = true })
			ts_update()
		end,
	},
	{
		"nvim-treesitter/nvim-treesitter-textobjects",
		commit = "f27f22053d210191e0a267ca15ec80a10a226a97",
	},
	{
		"JoosepAlviste/nvim-ts-context-commentstring",
		commit = "32d9627123321db65a4f158b72b757bcaef1a3f4",
	},

	{ "neovim/nvim-lspconfig", commit = "ea5744f9243ec25a178a0bc403a4c8203ecc4f23" },
	{ "hrsh7th/cmp-nvim-lsp", commit = "59224771f91b86d1de12570b4070fe4ad7cd1eeb" },
	{ "hrsh7th/cmp-buffer", commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" },
	{ "hrsh7th/cmp-path", commit = "91ff86cd9c29299a64f968ebb45846c485725f23" },
	{ "hrsh7th/cmp-cmdline", commit = "8bc9c4a34b223888b7ffbe45c4fe39a7bee5b74d" },
	{ "hrsh7th/nvim-cmp", commit = "8a9e8a89eec87f86b6245d77f313a040a94081c1" },
	{ "saadparwaiz1/cmp_luasnip", commit = "18095520391186d634a0045dacaa346291096566" },
	{ "L3MON4D3/LuaSnip", commit = "79f647218847b1cd204fede7dd89025e43fd00c3" },
	{ "jose-elias-alvarez/null-ls.nvim", commit = "7b2b28e207a1df4ebb13c7dc0bd83f69b5403d71" },
	{ "williamboman/mason.nvim", commit = "9f84d49d33a790fb6d0fe23371c662cf77957ec5" },
	{ "williamboman/mason-lspconfig.nvim", commit = "a1e2219ecea273d52b1ce1d527dd3a93cfe5b396" },
	{ "jayp0521/mason-null-ls.nvim", commit = "1128f0d940cb2e93397d58a7177c866e8ca2f11f" },
	{ "jayp0521/mason-nvim-dap.nvim", commit = "4f236808c0bf597a5be5d963f91f103904937216" },
	{ "folke/neodev.nvim", commit = "a6cd21560f88b54d8f8ddd1cd145be3ed4a051bc" },

	{ "nvim-telescope/telescope.nvim", commit = "f40e3e2304c633411ddf266075f7db5184b1db02" },
	{ "nvim-telescope/telescope-fzf-native.nvim", commit = "65c0ee3d4bb9cb696e262bca1ea5e9af3938fc90", run = "make" },
	{ "nvim-telescope/telescope-symbols.nvim", commit = "f7d7c84873c95c7bd5682783dd66f84170231704" },

	{ "numToStr/Comment.nvim", commit = "5f01c1a89adafc52bf34e3bf690f80d9d726715d" },
	{ "kylechui/nvim-surround", commit = "93380716d94e451c340e653ce09d73e9cabe54c6" },
	{ "windwp/nvim-autopairs", commit = "6b6e35fc9aca1030a74cc022220bc22ea6c5daf4" },
	{ "tpope/vim-repeat", commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a" },
	{ "ggandor/leap.nvim", commit = "9a69febb2e5a4f5f5a55dd2d7173098fde917bc5" },

	-- git
	{ "lewis6991/gitsigns.nvim", commit = "9ff7dfb051e5104088ff80556203634fc8f8546d" },
	{ "sindrets/diffview.nvim", commit = "7de7334ef61a3f3806b1616c2d785b8bbf080060" },
	{ "tpope/vim-fugitive", commit = "23b9b9b2a3b88bdefee8dfd1126efb91e34e1a57" },
	{ "TimUntersberger/neogit", commit = "de227f740bb29f90d62f9a6112f926de5f052358" },

	{ "moll/vim-bbye", commit = "25ef93ac5a87526111f43e5110675032dbcacf56" },
	{ "ahmedkhalf/project.nvim", commit = "685bc8e3890d2feb07ccf919522c97f7d33b94e4" },
	{ "akinsho/toggleterm.nvim", commit = "b02a1674bd0010d7982b056fd3df4f717ff8a57a" },
}

-- Autocommand that reloads neovim whenever you save the plugins.lua file
vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]])

local status_ok, packer = pcall(require, "packer")

if not status_ok then
	vim.notify(packer, vim.log.levels.WARN)
	return
end

packer.init({
	display = {
		open_fn = function()
			return require("packer.util").float({ border = "rounded" })
		end,
	},
})

return packer.startup(function(use)
	for _, plugin in pairs(plugins) do
		use(plugin)
	end
end)
