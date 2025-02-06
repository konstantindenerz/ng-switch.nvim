if vim.g.loaded_ng_switch then
  return
end
vim.g.loaded_ng_switch = true

require("ng-switch").setup()
