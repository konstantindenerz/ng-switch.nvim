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

### Customizing Keybindings

If you want to override the default shortcuts, you can define your own in the Lazy.nvim configuration:

```lua
{
  "konstantindenerz/ng-switch.nvim",
  config = function()
    require("ng-switch").setup({
      keymaps = false, -- Disable default keymaps
    })
  end,
  keys = {
    { "<leader>cnt", ":NgSwitchTS<cr>", desc = "To Component" },
    { "<leader>cnc", ":NgSwitchStyle<cr>", desc = "To Style" },
    { "<leader>cnh", ":NgSwitchHTML<cr>", desc = "To Template" },
    { "<leader>cnsp", ":NgSwitchSpec<cr>", desc = "To Spec" },
    { "<leader>cnst", ":NgSwitchStories<cr>", desc = "To Stories" },
  },
}
```
