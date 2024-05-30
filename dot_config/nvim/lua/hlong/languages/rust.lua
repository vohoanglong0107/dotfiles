local base = require("hlong.languages.base")

vim.g.rustaceanvim = {
  tools = {
    hover_actions = {
      replace_builtin_hover = false,
    },
    float_win_config = {
      border = "rounded",
    },
  },
  server = {
    on_attach = function(client, bufnr)
      base.lsp_keymaps(bufnr)
    end,
  },
}
