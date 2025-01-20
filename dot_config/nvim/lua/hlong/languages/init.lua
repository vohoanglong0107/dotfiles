-- Set up language specific config
--
-- Can't put them in after/ftplugin due to how lspconfig works
-- Ref: https://github.com/neovim/nvim-lspconfig/issues/970#issuecomment-860133357

require("hlong.languages.docker")
require("hlong.languages.go")
require("hlong.languages.hcl")
require("hlong.languages.java")
require("hlong.languages.javascript")
require("hlong.languages.lua")
require("hlong.languages.python")
require("hlong.languages.ruby")
require("hlong.languages.rust")
require("hlong.languages.shell")
require("hlong.languages.yaml")
