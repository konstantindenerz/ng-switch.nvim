# NgSwitch.nvim

A simple Neovim plugin for Angular file switching (`.ts`, `.html`, `.spec.ts`, `.scss`, `.stories.ts`).

## Installation

### Lazy.nvim

```lua
{
  "konstantindenerz/ng-switch.nvim",
  config = function()
    require("ng-switch").setup({ keymaps = true })
  end,
}
```
