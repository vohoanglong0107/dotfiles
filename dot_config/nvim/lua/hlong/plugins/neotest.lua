return {
  "nvim-neotest/neotest",
  dependencies = {
    "nvim-neotest/nvim-nio",
    "nvim-lua/plenary.nvim",
    "antoinemadec/FixCursorHold.nvim",
    "nvim-treesitter/nvim-treesitter",
    "mrcjkb/rustaceanvim",
  },
  keys = {
    {
      "<leader>tr",
      function()
        require("neotest").run.run()
      end,
      desc = "Run closest test",
    },
    {
      "<leader>to",
      function()
        require("neotest").output.open({ enter = true })
      end,
      desc = "Open test output",
    },
    {
      "[t",
      function()
        require("neotest").jump.prev({ status = "failed" })
      end,
      desc = "Jump to previous failed test",
    },
    {
      "]t",
      function()
        require("neotest").jump.next({ status = "failed" })
      end,
      desc = "Jump to next failed test",
    },
  },
  config = function()
    require("neotest").setup({
      adapters = {
        require("rustaceanvim.neotest"),
      },
    })
  end,
}
