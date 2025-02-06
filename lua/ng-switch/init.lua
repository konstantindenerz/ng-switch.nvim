local M = {}

local transforms = {
  ts_to_html = { "%.ts$", ".html" },
  html_to_ts = { "%.html$", ".ts" },
  spec_to_ts = { "%.spec%.ts$", ".ts" },
  ts_to_spec = { "%.ts$", ".spec.ts" },
  ts_to_style = { "%.ts$", ".scss" },
  style_to_ts = { "%.scss$", ".ts" },
  stories_to_ts = { "%.component%.stories%.ts$", ".component.ts" },
  ts_to_stories = { "%.component%.ts$", ".component.stories.ts" },
}

local function switch(transform, cmd)
  local path, new_path = vim.fn.expand("%"), vim.fn.expand("%"):gsub(transform[1], transform[2])
  if new_path ~= path then
    vim.cmd.edit(new_path)
  else
    error("NgSwitch: No match for '" .. cmd .. "'", 1)
  end
end

M.toggle = function()
  switch(transforms.ts_to_html, "NgSwitchToggle")
end
M.to_ts = function()
  switch(transforms.spec_to_ts, "NgSwitchTS")
end
M.to_html = function()
  switch(transforms.ts_to_html, "NgSwitchHTML")
end
M.to_style = function()
  switch(transforms.ts_to_style, "NgSwitchStyle")
end
M.to_spec = function()
  switch(transforms.ts_to_spec, "NgSwitchSpec")
end
M.to_stories = function()
  switch(transforms.ts_to_stories, "NgSwitchStories")
end

function M.setup(opts)
  opts = opts or {}

  for cmd, func in pairs({
    Toggle = M.toggle,
    TS = M.to_ts,
    HTML = M.to_html,
    Style = M.to_style,
    Spec = M.to_spec,
    Stories = M.to_stories,
  }) do
    vim.api.nvim_create_user_command("NgSwitch" .. cmd, func, {})
  end

  if opts.keymaps then
    for key, cmd in pairs({ q = "Toggle", t = "TS", c = "Style", h = "HTML", sp = "Spec", st = "Stories" }) do
      vim.keymap.set("n", "<leader>cn" .. key, ":NgSwitch" .. cmd .. "<cr>", { desc = "To " .. cmd })
    end
  end
end

return M
