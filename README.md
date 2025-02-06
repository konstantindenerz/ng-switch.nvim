# NgSwitch.nvim

A simple Neovim plugin for Angular file switching (`.ts`, `.html`, `.spec.ts`, `.scss`, `.stories.ts`).

## Installation

### Lazy.nvim

```lua
{
  "konstantindenerz/ng-switch",
  dir = "~/.config/nvim/lua/plugins/ng-switch",
  config = function()
    require("ng-switch").setup({ keymaps = true })
  end,
}
```
