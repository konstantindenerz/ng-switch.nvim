local M = {}

local transforms = {
  {
    "%.component%.ts$",
    {
      html = ".component.html",
      style = ".component.scss",
      spec = ".component.spec.ts",
      stories = ".component.stories.ts",
    },
  },
  {
    "%.component%.html$",
    { ts = ".component.ts", style = ".component.scss", spec = ".component.spec.ts", stories = ".component.stories.ts" },
  },
  {
    "%.component%.scss$",
    { ts = ".component.ts", html = ".component.html", spec = ".component.spec.ts", stories = ".component.stories.ts" },
  },
  {
    "%.component%.spec%.ts$",
    { ts = ".component.ts", html = ".component.html", style = ".component.scss", stories = ".component.stories.ts" },
  },
  {
    "%.component%.stories%.ts$",
    { ts = ".component.ts", html = ".component.html", style = ".component.scss", spec = ".component.spec.ts" },
  },
}

local function switch(target)
  local path = vim.fn.expand("%")

  for _, entry in ipairs(transforms) do
    local pattern, replacements = entry[1], entry[2]
    if path:match(pattern) and replacements[target] then
      local new_path = path:gsub(pattern, replacements[target])
      if new_path ~= path then
        vim.cmd.edit(new_path)
        return
      end
    end
  end

  error("NgSwitch: No matching file found", 1)
end

M.to_ts = function()
  switch("ts")
end
M.to_html = function()
  switch("html")
end
M.to_style = function()
  switch("style")
end
M.to_spec = function()
  switch("spec")
end
M.to_stories = function()
  switch("stories")
end

function M.setup(opts)
  opts = opts or {}

  for cmd, func in pairs({
    TS = M.to_ts,
    HTML = M.to_html,
    Style = M.to_style,
    Spec = M.to_spec,
    Stories = M.to_stories,
  }) do
    vim.api.nvim_create_user_command("NgSwitch" .. cmd, func, {})
  end

  if opts.keymaps then
    for key, cmd in pairs({ t = "TS", h = "HTML", c = "Style", sp = "Spec", st = "Stories" }) do
      vim.keymap.set("n", "<leader>cn" .. key, ":NgSwitch" .. cmd .. "<cr>", { desc = "To " .. cmd })
    end
  end
end

return M
