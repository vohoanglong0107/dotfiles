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
  { "wbthomason/packer.nvim",      commit = "6afb67460283f0e990d35d229fd38fdc04063e0a" },

  -- Neovim plugins' utils
  { "nvim-lua/plenary.nvim",       commit = "253d34830709d690f013daf2853a9d21ad7accab" },
  { "MunifTanjim/nui.nvim",        commit = "0dc148c6ec06577fcf06cbab3b7dac96d48ba6be" },
  { "lewis6991/impatient.nvim",    commit = "d3dd30ff0b811756e735eb9020609fa315bfbbcc" },

  -- Theme
  { "nvim-tree/nvim-web-devicons", commit = "3548363849878ef895ce54edda02421279b419d8" },
  { "folke/tokyonight.nvim",       commit = "62b4e89ea1766baa3b5343ca77d62c817f5f48d0" },
  {
    "catppuccin/nvim",
    as = "catppuccin",
    commit = "6368edcd0b5e5cb5d9fb7cdee9d62cffe3e14f0e",
  },

  -- Interfaces
  { "akinsho/bufferline.nvim",             commit = "4ecfa81e470a589e74adcde3d5bb1727dd407363" },
  { "glepnir/dashboard-nvim",              commit = "1aab263f4773106abecae06e684f762d20ef587e" },
  { "nvim-lualine/lualine.nvim",           commit = "e99d733e0213ceb8f548ae6551b04ae32e590c80" },
  { "rcarriga/nvim-notify",                commit = "bdd647f61a05c9b8a57c83b78341a0690e9c29d7" },
  { "nvim-tree/nvim-tree.lua",             commit = "45400cd7e02027937cd5e49845545e606ecf5a1f" },
  { "folke/trouble.nvim",                  commit = "897542f90050c3230856bc6e45de58b94c700bbf" },
  { "folke/which-key.nvim",                commit = "6d886f4dcaa25d1fe20e332f779fe1edb726d063" },
  { "lukas-reineke/indent-blankline.nvim", commit = "db7cbcb40cc00fc5d6074d7569fb37197705e7f6" },
  { "folke/noice.nvim",                    commit = "e5cb84f1ed524f850fa92e3a256e830ed07fadee" },
  { "folke/todo-comments.nvim",            commit = "9d642940fe32e4a22570101f7ecf88e9e38a10f7" },

  -- Core
  {
    "nvim-treesitter/nvim-treesitter",
    commit = "834f1dcb8736c82b1269227b4bfe830310b5b6a1",
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

  { "neovim/nvim-lspconfig",                    commit = "4bb0f1845c5cc6465aecedc773fc2d619fcd8faf" },
  { "hrsh7th/cmp-nvim-lsp",                     commit = "0e6b2ed705ddcff9738ec4ea838141654f12eeef" },
  { "hrsh7th/cmp-buffer",                       commit = "3022dbc9166796b644a841a02de8dd1cc1d311fa" },
  { "hrsh7th/cmp-path",                         commit = "91ff86cd9c29299a64f968ebb45846c485725f23" },
  { "hrsh7th/cmp-cmdline",                      commit = "8fcc934a52af96120fe26358985c10c035984b53" },
  { "hrsh7th/nvim-cmp",                         commit = "feed47fd1da7a1bad2c7dca456ea19c8a5a9823a" },
  { "saadparwaiz1/cmp_luasnip",                 commit = "18095520391186d634a0045dacaa346291096566" },
  { "L3MON4D3/LuaSnip",                         commit = "58236e8b2f20de23ff35106dace9212b41d78860" },
  { "rafamadriz/friendly-snippets",             commit = "8d91ba2dc2421a54981115f61b914974f938fa77" },
  { "jose-elias-alvarez/null-ls.nvim",          commit = "d112a351ef8ff20060100fdc20e402a5880c4ef0" },
  { "williamboman/mason.nvim",                  commit = "10ff879fc56160e10437da5c1ca558371ddb6989" },
  { "williamboman/mason-lspconfig.nvim",        commit = "a81503f0019942111fe464209237f8b4e85f4687" },
  { "jayp0521/mason-null-ls.nvim",              commit = "1128f0d940cb2e93397d58a7177c866e8ca2f11f" },
  { "jayp0521/mason-nvim-dap.nvim",             commit = "4f236808c0bf597a5be5d963f91f103904937216" },
  { "folke/neodev.nvim",                        commit = "a6cd21560f88b54d8f8ddd1cd145be3ed4a051bc" },
  { "nvim-telescope/telescope.nvim",            commit = "f40e3e2304c633411ddf266075f7db5184b1db02" },
  { "nvim-telescope/telescope-fzf-native.nvim", commit = "65c0ee3d4bb9cb696e262bca1ea5e9af3938fc90", run = "make" },
  { "nvim-telescope/telescope-symbols.nvim",    commit = "f7d7c84873c95c7bd5682783dd66f84170231704" },
  { "numToStr/Comment.nvim",                    commit = "5f01c1a89adafc52bf34e3bf690f80d9d726715d" },
  { "kylechui/nvim-surround",                   commit = "93380716d94e451c340e653ce09d73e9cabe54c6" },
  { "windwp/nvim-autopairs",                    commit = "6b6e35fc9aca1030a74cc022220bc22ea6c5daf4" },
  { "tpope/vim-repeat",                         commit = "24afe922e6a05891756ecf331f39a1f6743d3d5a" },
  { "ggandor/leap.nvim",                        commit = "9a69febb2e5a4f5f5a55dd2d7173098fde917bc5" },

  -- git
  { "lewis6991/gitsigns.nvim",                  commit = "9ff7dfb051e5104088ff80556203634fc8f8546d" },
  { "sindrets/diffview.nvim",                   commit = "7de7334ef61a3f3806b1616c2d785b8bbf080060" },
  { "TimUntersberger/neogit",                   commit = "de227f740bb29f90d62f9a6112f926de5f052358" },
  { "moll/vim-bbye",                            commit = "25ef93ac5a87526111f43e5110675032dbcacf56" },
  { "ahmedkhalf/project.nvim",                  commit = "685bc8e3890d2feb07ccf919522c97f7d33b94e4" },
  { "akinsho/toggleterm.nvim",                  commit = "b02a1674bd0010d7982b056fd3df4f717ff8a57a" },
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
