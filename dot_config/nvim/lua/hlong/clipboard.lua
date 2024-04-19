-- https://github.com/neovim/neovim/blob/13ebfafc958c6feb4d908eed913c6dc3c6f05b4e/runtime/plugin/osc52.lua
-- remove paste as well as terminal check, as wezterm disallow read from clipboard by OSC52,
-- but allow setting clipboard by OSC52
local tty = false
for _, ui in ipairs(vim.api.nvim_list_uis()) do
  if ui.chan == 1 and ui.stdout_tty then
    tty = true
    break
  end
end

if not tty or vim.g.clipboard ~= nil or vim.o.clipboard ~= '' or not os.getenv('SSH_TTY') then
  return
end

local osc52 = require('vim.ui.clipboard.osc52')
vim.g.clipboard = {
  name = 'OSC 52',
  copy = {
    ['+'] = osc52.copy('+'),
    ['*'] = osc52.copy('*'),
  },
  paste = {
    ['+'] = function () end,
    ['*'] = function () end,
  },
}
